import 'package:flutter/material.dart';
import 'package:flutter_vault/screen/home_screen.dart';
import 'package:flutter_vault/util/secure_storage.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String text = '';
  bool isInit = true;
  String data;
  var isChange = false;
  String password;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    final arg = ModalRoute.of(context).settings.arguments as bool;

    if (isInit){
      if (arg == null) {
        SecureStorage().readSecureData('pass').then((pass) {
          setState(() {
            data = pass;
          });
        });
      } else {
        print(arg);
        isChange = arg;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  void _onKeyboardTap(String value) {
    setState(() {
      text = text + value;
    });
  }

  Widget otpNumberWidget(int position) {
    try {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
        child: Center(child: Text(text[position], style: TextStyle(color: Colors.black),)),
      );
    } catch (e) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data == null ? 'Create Vault' : 'Login Vault'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text('Enter 6 digits password', style: TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.w500))
                        ),
                        Container(
                          constraints: const BoxConstraints(
                              maxWidth: 500
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              otpNumberWidget(0),
                              otpNumberWidget(1),
                              otpNumberWidget(2),
                              otpNumberWidget(3),
                              otpNumberWidget(4),
                              otpNumberWidget(5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    constraints: const BoxConstraints(
                        maxWidth: 500
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        if (isChange && isChange != null) {
                          //change password
                          SecureStorage().writeSecureData('pass', text);
                          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                        } else {
                          //if not change password
                          if (data == null) {
                            // if storage password null then create password
                            SecureStorage().writeSecureData('pass', text);
                            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                          } else {
                            // if storage password is not null then redirect to home
                            if (data == text) Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                            else {
                              //if input password is not match with storage password
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Access denied!'),
                              ));
                            }
                          }
                        }

                        // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                      },
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14))
                      ),
                      color: Theme.of(context).buttonColor,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Confirm', style: TextStyle(color: Colors.white),),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16,),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  NumericKeyboard(
                    onKeyboardTap: _onKeyboardTap,
                    rightIcon: Icon(
                      Icons.backspace,
                    ),
                    rightButtonFn: () {
                      setState(() {
                        text = text.substring(0, text.length - 1);
                      });
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}