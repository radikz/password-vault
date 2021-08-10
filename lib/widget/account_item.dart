import 'package:flutter/material.dart';
import 'package:flutter_vault/provider/data_provider.dart';
import 'package:provider/provider.dart';
import '../model/account.dart';
import '../screen/add_screen.dart';

class AccountItem extends StatefulWidget {
  final Account account;

  AccountItem(this.account);

  @override
  _AccountItemState createState() => _AccountItemState();
}

class _AccountItemState extends State<AccountItem> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    print(isVisible);
    return Dismissible(
      key: ValueKey(widget.account.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        // Provider.of<CartProvider>(context, listen: false).removeItem(idKey);
        Provider.of<DataProvider>(context, listen: false).delete(widget.account.id);
      },
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to remove item from the list?'),
              actions: <Widget>[
                TextButton(onPressed: () {
                  Navigator.of(ctx).pop(false);
                }, child: Text('No')),
                TextButton(onPressed: () {
                  Navigator.of(ctx).pop(true);
                }, child: Text('Yes'))
              ],
            ));
      },
      child: Card(
        color: Colors.white,
        elevation: 2.0,
        child: InkWell(
          onTap: () => Navigator.of(context).pushNamed(AddScreen.routeName, arguments: widget.account),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Icon(Icons.people),
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.account.site, style: Theme.of(context).textTheme.headline6,),
                    SizedBox(height: 5,),
                    Text(widget.account.username, style: Theme.of(context).textTheme.subtitle1,),
                    // Text(account.password, style: Theme.of(context).textTheme.subtitle1,),
                    TextFormField(
                      maxLines: 1,
                      obscureText: isVisible,
                      initialValue: widget.account.password,
                      enabled: false,
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  child: Container(
                    child: isVisible ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
