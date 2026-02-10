import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './routes/app_router.dart';
import './store/user_state_model.dart';

/*
  ⚠️ 基于 go_router(StatefulShellRoute) + provider 搭建带底部标签栏的App，可作为项目开发基础框架

  缺少：App 启动广告页

 */

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserStateModel>(create: (context) => UserStateModel()),
      ],
      child: MaterialApp.router(
        title: 'Navigation 2.0 App',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate, 
        ],
        supportedLocales: [
          Locale('zh'), // Spanish
          Locale('en'), // English
        ],
        theme: ThemeData(
          primarySwatch: Colors.blue
        ),
        routerConfig: AppRouter.routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
