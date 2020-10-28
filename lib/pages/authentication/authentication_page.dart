import 'package:flutter/material.dart';
import 'package:property_manager/pages/authentication/register_page.dart';
import 'package:property_manager/pages/authentication/sign_in_page.dart';

class AuthenticationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Authentication"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                width: 400,
                child: TabBar(
                  labelStyle: TextStyle(
                    color: Theme.of(context).accentColor,
                  ),
                  labelColor: Theme.of(context).accentColor,
                  indicatorColor: Theme.of(context).accentColor,
                  tabs: [
                    Tab(text: 'Sign In'),
                    Tab(text: 'Register'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    SignInPage(),
                    RegisterPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
