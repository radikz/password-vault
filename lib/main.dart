import 'package:flutter/material.dart';
import 'package:flutter_vault/model/theme_data.dart';
import 'package:flutter_vault/provider/data_provider.dart';
import 'package:flutter_vault/provider/dbhelper_provider.dart';
import 'package:flutter_vault/screen/add_screen.dart';
import 'package:flutter_vault/screen/home_screen.dart';
import 'screen/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DBHelperProvider()),
        ChangeNotifierProxyProvider<DBHelperProvider, DataProvider>(
          create: (context) => DataProvider([], null),
          update: (ctx, db, previous) => DataProvider(
            previous.items, db
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Vault',
        theme: themeData(),
        home: LoginScreen(),
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
          AddScreen.routeName: (ctx) => AddScreen(),
        },
      ),
    );
  }
}
