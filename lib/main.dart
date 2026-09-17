import 'package:flutter/material.dart';
import 'package:green_bin_employee/views/splash_screen.dart';
import 'package:provider/provider.dart';
import 'providers/employee_provider.dart'; // adjust path to match your project structure

void main() {
  runApp( const MyApp(),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EmployeeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        ),
        home: SplashPage()
      ),
    );
  }
}

