import 'package:flutter/material.dart';
import 'package:flutter_vault/model/argument.dart';
import '../screen/home_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.home),
              ),
              title: Text('Home'),
              trailing: Icon(Icons.arrow_right_outlined),
              onTap: () => Navigator.of(context).pushReplacementNamed(HomeScreen.routeName),
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.password_outlined),
              ),
              title: Text('Change Password'),
              trailing: Icon(Icons.arrow_right_outlined),
              onTap: () => Navigator.of(context).pushNamed('/', arguments: true),
            ),
          ],
        ),
      ),
    );
  }
}
