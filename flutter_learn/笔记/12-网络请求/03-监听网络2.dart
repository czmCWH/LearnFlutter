import 'dart:async';
import 'dart:io';

/// 网络可用状态枚举
enum PureNetworkStatus {
  connected,    // 网络已连接（且可以访问互联网）
  disconnected, // 网络已断开
}

class PureNetworkListener {
  // 单例模式
  static final PureNetworkListener _instance = PureNetworkListener._internal();
  factory PureNetworkListener() => _instance;
  PureNetworkListener._internal();

  Timer? _timer;
  bool _isChecking = false; // 防止上一次检测未完成时并发触发下一次
  bool _isDisposed = false;

  // 引用计数：支持多个页面/调用方各自 start/stop，互不干扰
  int _refCount = 0;

  PureNetworkStatus _lastStatus = PureNetworkStatus.disconnected;
  /// 同步获取当前最近一次检测到的网络状态（供新监听者初始化 UI 用）
  PureNetworkStatus get currentStatus => _lastStatus;

  // 使用 StreamController 向 UI 层发布状态变化
  // 用可空类型 + 懒初始化，配合 dispose 后仍可重新 startListening
  StreamController<PureNetworkStatus>? _statusController =
      StreamController<PureNetworkStatus>.broadcast();

  Stream<PureNetworkStatus> get onStatusChanged {
    _statusController ??= StreamController<PureNetworkStatus>.broadcast();
    return _statusController!.stream;
  }

  // 多个稳定探测域名，任意一个解析成功即视为联网，提升容错率
  // （国内外都覆盖，避免单一域名被墙/故障导致误判）
  static const List<String> _probeHosts = <String>[
    'alidns.com',                     // 阿里公共 DNS（国内）
    'connectivitycheck.gstatic.com',  // Google 检测域名（海外）
    'one.one.one.one',                // Cloudflare DNS
  ];

  /// 开始监听（引用计数 +1）
  /// [interval] 轮询间隔，默认每 5 秒检测一次
  /// 多个调用方可各自调用，内部只会真正启动一个定时器，
  /// 需要与 stopListening 成对调用。
  void startListening({Duration interval = const Duration(seconds: 5)}) {
    _refCount++;

    _isDisposed = false;
    _statusController ??= StreamController<PureNetworkStatus>.broadcast();

    // 已经在监听中，直接复用，不重复创建定时器
    if (_timer != null) return;

    // 启动时立即执行一次检测
    _checkActualInternet();
    // 开启定时轮询
    _timer = Timer.periodic(interval, (timer) {
      _checkActualInternet();
    });
  }

  /// 核心检测逻辑
  Future<void> _checkActualInternet() async {
    // 上一次检测尚未结束（例如弱网导致超时未返回），跳过本次，避免任务堆积
    if (_isChecking || _isDisposed) return;
    _isChecking = true;

    PureNetworkStatus currentStatus;
    try {
      // 先检查本机是否存在可用网络接口（Wi-Fi/蜂窝等）
      // 完全没有网卡时（如飞行模式）可直接判定断网，无需等待 DNS 超时
      final interfaces = await NetworkInterface.list(
        includeLoopback: false,
        type: InternetAddressType.any,
      );
      currentStatus = interfaces.isEmpty
          ? PureNetworkStatus.disconnected
          : await _probeAnyHost();
    } catch (_) {
      // 部分设备/权限下 NetworkInterface.list 可能异常，降级为直接探测域名
      currentStatus = await _probeAnyHost();
    }

    _isChecking = false;

    // 只有在状态真正发生改变时，才通知订阅者，避免不必要的 UI 刷新
    if (currentStatus != _lastStatus) {
      _lastStatus = currentStatus;
      if (!_isDisposed) {
        _statusController?.add(currentStatus);
      }
    }
  }

  /// 依次探测多个域名，任意一个解析成功即视为已联网
  Future<PureNetworkStatus> _probeAnyHost() async {
    for (final host in _probeHosts) {
      try {
        final result = await InternetAddress.lookup(host)
            .timeout(const Duration(seconds: 3)); // 单个域名 3 秒超时
        if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
          return PureNetworkStatus.connected;
        }
      } catch (_) {
        // 当前域名探测失败（SocketException / TimeoutException），继续尝试下一个
        continue;
      }
    }
    return PureNetworkStatus.disconnected;
  }

  /// 暂停监听（引用计数 -1，仅在计数归零时才真正取消定时器）
  /// 必须与 startListening 成对调用，否则其他调用方的监听会被误关闭。
  void stopListening() {
    if (_refCount > 0) {
      _refCount--;
    }
    if (_refCount > 0) return; // 还有其他调用方在用，不真正停止

    _timer?.cancel();
    _timer = null;
  }

  /// 强制停止（忽略引用计数，直接停止定时器）
  /// 谨慎使用：仅用于确定要无视其他调用方、强制停止的场景（如登出清理）。
  void forceStopListening() {
    _refCount = 0;
    _timer?.cancel();
    _timer = null;
  }

  /// 彻底释放资源（一般用于 App 完全退出时调用；
  /// 由于是单例，正常业务场景下无需调用，调用后需重新 startListening 才能恢复监听）
  void dispose() {
    _isDisposed = true;
    _refCount = 0;
    _timer?.cancel();
    _timer = null;
    _statusController?.close();
    _statusController = null;
  }
}

// 整合了引用计数（支持多页面/多调用方安全共用同一单例）的 PureNetworkListener