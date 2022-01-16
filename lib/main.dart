import 'package:assignment3/chatbox.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp().then((value) => print('intialized'));
    runApp(chatbox());
  }

