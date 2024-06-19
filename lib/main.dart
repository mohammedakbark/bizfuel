
import 'package:bizfuel/firebase_options.dart';
import 'package:bizfuel/view/login/letsgo.dart';
import 'package:bizfuel/viewmodel/auth.dart';
import 'package:bizfuel/viewmodel/firebasehelper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthControoler(),
        ),
        ChangeNotifierProvider(
          create: (context) => FirebaseHelper(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: Letsgo(),
        home: Letsgo(),
      ),
    );
  }
}