import 'package:flutter/material.dart';
import 'package:property_manager/models/user_model.dart';
import 'package:property_manager/pages/authentication/authentication_page.dart';
import 'package:property_manager/pages/dashboard/properties_list.dart';
import 'package:property_manager/pages/dashboard/properties_shortlist.dart';
import 'package:property_manager/services/authentication_service.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage();

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  _navigateToAuthPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AuthenticationPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationService authenticationService = Provider.of(context);
    return StreamBuilder<UserModel>(
      stream: authenticationService.userStream,
      builder: (context, userSnapshot) {
        return DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Scaffold(
            appBar: AppBar(
              title: Text("Dashboard"),
              actions: [
                !userSnapshot.hasData
                    ? FlatButton(
                        onPressed: _navigateToAuthPage,
                        child: Text("Sign In"),
                      )
                    : FlatButton(
                        onPressed: authenticationService.signOut,
                        child: Text("Sign Out"),
                      )
              ],
            ),
            body: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 600,
                    child: TabBar(
                      labelStyle: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                      labelColor: Theme.of(context).accentColor,
                      indicatorColor: Theme.of(context).accentColor,
                      tabs: [
                        Tab(
                          text: "Properties",
                        ),
                        Tab(
                          text: "Saved",
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 600,
                      child: TabBarView(
                        children: [
                          PropertiesList(
                            userModel: userSnapshot.data,
                          ),
                          userSnapshot.hasData
                              ? PropertiesShortList(
                                  userModel: userSnapshot.data,
                                )
                              : Container(
                                  child: InkWell(
                                    onTap: _navigateToAuthPage,
                                    child: Center(
                                      child: Text(
                                        "Sign in to save properties.\n\nClick here to get started",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
