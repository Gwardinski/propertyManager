import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:property_manager/pages/dashboard/dashboard_page.dart';
import 'package:property_manager/services/authentication_service.dart';
import 'package:property_manager/services/property_collection_service.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              Provider<AuthenticationService>(
                create: (BuildContext context) => AuthenticationService(),
              ),
              Provider<PropertyCollectionService>(
                create: (BuildContext context) => PropertyCollectionService(),
              ),
            ],
            child: MaterialApp(
              title: 'Property Manager',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: 'Roboto',
              ),
              home: DashboardPage(),
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text("Failed to initialise app"),
          );
        }
        return Container(
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
