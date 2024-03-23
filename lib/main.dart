import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quikhyr/app.dart';
import 'package:quikhyr/features/auth/data/repository/firebase_user_repo.dart';
import 'package:quikhyr/config/firebase_options.dart';
import 'package:quikhyr/simple_bloc_observer.dart';


Future<void> main() async{
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp(FirebaseUserRepo()));
}


