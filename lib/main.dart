import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/flavor.dart';
import 'package:noteapp/my_app.dart';
import 'package:noteapp/providers/auth_provider.dart';
import 'package:noteapp/providers/language_provider.dart';
import 'package:noteapp/providers/theme_provider.dart';
import 'package:noteapp/services/firestore_database.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    /*
      * MultiProvider for top services that do not depends on any runtime values
      * such as user uid/email.
       */
    MultiProvider(
      providers: [
        Provider<Flavor>.value(value: Flavor.dev),
      
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<LanguageProvider>(
          create: (context) => LanguageProvider(),
        ),
      ],
      child: MyApp(
        databaseBuilder: (_, uid) => FirestoreDatabase(uid: uid),
      ),
    ),
  );
}
