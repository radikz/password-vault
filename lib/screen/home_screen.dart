import 'package:flutter/material.dart';
import '../widget/app_drawer.dart';
import '../provider/data_provider.dart';
import '../widget/account_item.dart';
import 'package:provider/provider.dart';

import 'add_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vault'),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () => Provider.of<DataProvider>(context, listen: false).fetchAndSetData(),
        child: FutureBuilder(
          future: Provider.of<DataProvider>(context, listen: false).fetchAndSetData(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            }
            else {
              if (snapshot.error != null) {
                return Center(child: Text('Data null'));
              }
              else {
                print(snapshot.data);
                return Consumer<DataProvider>(
                  builder: (ctx, data, child) => ListView.builder(
                    itemCount: data.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AccountItem(data.items[index]);
                    },
                  ),
                );
              }
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed(AddScreen.routeName),
        backgroundColor: Colors.deepOrange,
      ),
      drawer: AppDrawer(),
    );
  }
}
