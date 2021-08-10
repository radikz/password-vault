import 'package:flutter/material.dart';
import 'package:flutter_vault/model/account.dart';
import 'package:flutter_vault/provider/data_provider.dart';
import 'package:provider/provider.dart';


class AddScreen extends StatefulWidget {
  static const routeName = "/add";

  @override
  AddScreenState createState() => AddScreenState();
}
//class controller
class AddScreenState extends State<AddScreen> {

  TextEditingController siteController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    siteController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final account = ModalRoute.of(context).settings.arguments as Account;
    //kondisi
    if (account != null) {
      siteController.text = account.site;
      usernameController.text = account.username;
      passwordController.text = account.password;
    }
    //rubah
    return Scaffold(
        appBar: AppBar(
          title: account == null ? Text('Add') : Text('Update'),
          actions: [],
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left:10.0, right:10.0),
          child: ListView(
            children: <Widget> [
              // nama
              Padding (
                padding: EdgeInsets.only(top:20.0, bottom:20.0),
                child: TextField(
                  controller: siteController,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    labelText: 'Site',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              Padding (
                padding: EdgeInsets.only(top:20.0, bottom:20.0),
                child: TextField(
                  controller: usernameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Username / Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              Padding (
                padding: EdgeInsets.only(top:20.0, bottom:20.0),
                child: TextField(
                  controller: passwordController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              // tombol button
              MaterialButton(
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).primaryColorLight,
                child: Text(
                  'Save',
                  textScaleFactor: 1.5,
                ),
                onPressed: () {
                  if (account == null) {
                    // tambah data
                    Provider.of<DataProvider>(context, listen: false).addAccount(siteController.text, usernameController.text, passwordController.text);
                    print('ulu');
                  } else {
                    // ubah data
                    print('id update ${account.id}');
                    Provider.of<DataProvider>(context, listen: false).update(Account(
                      id: account.id,
                      site: siteController.text,
                      username: usernameController.text,
                      password: passwordController.text
                    ));
                  }
                  Navigator.of(context).pop();
                  // kembali ke layar sebelumnya dengan membawa objek contact
                },
              ),
            ],
          ),
        )
    );
  }
}