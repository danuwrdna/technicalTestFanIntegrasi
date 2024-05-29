import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:technicaltestfan/view/page/SplashPage.dart';
import 'package:technicaltestfan/viewmodel/AuthViewModel.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SpalashPage(),
        ));
  }
}
