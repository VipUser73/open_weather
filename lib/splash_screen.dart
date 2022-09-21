import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: const Text('Loading'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(100, 200, 250, 1),
              Color.fromRGBO(50, 120, 200, 1)
            ],
          ),
        ),
        child: const SafeArea(
            child: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        )),
      ),
    );
  }
}
