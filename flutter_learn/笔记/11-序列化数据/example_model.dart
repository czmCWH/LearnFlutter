/*
  定义数据模型实体类的方式：
    1、手动书写，可以参照如下方式书写；
    2、借助 <https://quicktype.io/>  或 <https://www.geekailab.com/io/tools/json-to-dart/> 自动生成

 1、如果接口返回数据为 null，则 Dart 解析时为 null 值
    var jsonStr = '{"age": null}';
    final userMap = jsonDecode(jsonStr) as Map<String, dynamic>;
    int? age = userMap["age"];
    print(age == null); // true

 2、使用 as Type 如果类型不匹配，则会抛出 TypeError
    // int age = userMap["age"] as int;
    // print(age); // 18
    String? age = userMap["age"] as String?;  // 会报错！
 
 3、Dart 可以正常解析 bool 类型
  var jsonStr = '{"state": false, "isVip": true}';
  final map = jsonDecode(jsonStr) as Map<String, dynamic>;
  print(map["state"]);  // false
  print(map["isVip"]);  // true

 */

class Order {
  final String orderId;
  final User user;
  final Address shippingAddress;
  final List<OrderItem> items;
  final double totalAmount;
  final String status;

  Order({
    required this.orderId,
    required this.user,
    required this.shippingAddress,
    required this.items,
    required this.totalAmount,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['order_id'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      shippingAddress: Address.fromJson(json['shipping_address'] as Map<String, dynamic>),
      items: (json['items'] as List?)
          ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'user': user.toJson(),
      'shipping_address': shippingAddress.toJson(),
      'items': items.map((item) => item.toJson()).toList(),
      'total_amount': totalAmount,
      'status': status,
    };
  }
}

// 用户信息
class User {
  final int id;
  final String name;
  final String? avatar;

  User({required this.id, required this.name, this.avatar});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      avatar: json['avatar'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
    };
  }
}

// 地址信息
class Address {
  final String street;
  final String city;
  final String postalCode;

  Address({required this.street, required this.city, required this.postalCode});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] as String,
      city: json['city'] as String,
      postalCode: json['postal_code'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'postal_code': postalCode,
    };
  }
}

// 订单商品项
class OrderItem {
  final String productId;
  final String name;
  final double price;
  final int quantity;

  OrderItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['product_id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }
}


String? toStringOrNull(dynamic value) {
  if (value == null) return null;
  if (value is String) return value;
  return value.toString();
}

List<dynamic> toListOrEmpty(dynamic value) {
  if (value == null) return [];
  if (value is List) return value;
  return [];
}