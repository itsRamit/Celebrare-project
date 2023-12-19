import 'package:flutter/material.dart';
import 'package:ramit_das/screen/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // useMaterial3: true,
      ),
      home:splash(),
    );
  }
}

//Dear Sir/Ma'am in case you are reading this,
//Regrettably, the implementation of white-shaped frames has been hindered by a lack of suitable resources and compatible packages, 
//despite extensive exploration of available options. Efforts to find relevant packages for this purpose have proven unsuccessful.
