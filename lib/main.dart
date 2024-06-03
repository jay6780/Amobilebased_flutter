import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import 'controller/carousel_controller.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final carousel_controller carouselController = carousel_controller();
  late Timer _timer;
  int _currentPage = 0;

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    ));
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 2, milliseconds: 0), (Timer timer) {
      if (_currentPage < carouselController.images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      carouselController.pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.firaSans().fontFamily,
      ),
      home: Scaffold(
        backgroundColor: Color(0xffffffff),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "MEST System",
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
          drawer: Builder(
            builder: (BuildContext context) {
              return Drawer(
                child: Container(
                  color: Color(0xffcaf4ff),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/lottie/running.json',
                              height: 150,
                              width: 300,
                            ),
                            DrawerHeader(
                              decoration: BoxDecoration(),
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'A mobile-based Emergency',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      'response tool',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.home),
                              title: Text('Home page'),
                              onTap: () {
                                Navigator.pop(context);
                                _showSnackBar(context,'Home page');
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.switch_access_shortcut),
                              title: Text('Switch to offline mode'),
                              onTap: () {
                                Navigator.pop(context);
                                _showSnackBar(context,'Switched to offline mode');
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.contacts),
                              title: Text('Saved responders contact'),
                              onTap: () {
                                Navigator.pop(context);
                                _showSnackBar(context,'Responders contact');
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.book),
                              title: Text('User Manual'),
                              onTap: () {
                                Navigator.pop(context);
                                _showSnackBar(context,'User Manual');
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.exit_to_app),
                              title: Text('exit app'),
                              onTap: () {
                                Navigator.pop(context);
                                _showSnackBar(context,'Exiting app');
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        body: Column(
          children: [
            Container(
              height: 150,
              child: PageView.builder(
                controller: carouselController.pageController,
                itemCount: carouselController.images.length,
                itemBuilder: (context, index) {
                  return Image.asset(
                    carouselController.images[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Center(),
          ],
        ),
      ),
    );
  }
}
