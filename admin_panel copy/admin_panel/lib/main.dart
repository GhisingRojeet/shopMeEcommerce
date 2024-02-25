// ignore_for_file: prefer_const_constructors

import 'package:admin_panel/constants/theme.dart';
import 'package:admin_panel/helpers/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:admin_panel/helpers/firebase_options/firebase_options.dart';
import 'package:admin_panel/provider/app_provider.dart';
import 'package:admin_panel/screens/auth_ui/login/login.dart';
import 'package:admin_panel/screens/home_page/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'screens/login/loginadmin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>(
      create: (context) => AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ShopMe',
        theme: themeData,

       home: StreamBuilder(
          stream: FirebaseAuthHelper.instance.getAuthChange,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return const HomePage();
            }
            return const Login();
          }
        ),
      ),
    );
  }
}
