import 'dart:convert';

import 'package:bisa_app/models/current_user.dart';
import 'package:bisa_app/providers/current_user_provider.dart';
import 'package:bisa_app/providers/settings_provider.dart';
import 'package:bisa_app/services/api_service.dart';
import 'package:bisa_app/ui/home/home_page.dart';
import 'package:bisa_app/ui/widgets/popup.dart';
import 'package:flutter/material.dart';
import 'package:page_animation_transition/animations/top_to_bottom_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late SharedPreferences prefs;

  var loggedinUser;

  dynamic settings;

  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(milliseconds: 1100))
        ..repeat(reverse: true);

  late final Animation<double> _animation =
      Tween<double>(begin: 1.0, end: 1.3).animate(_controller);

  late final AnimationController _scaleController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 300));

  late final Animation _scaleAnimation = Tween<double>(
          begin: 1.0,
          // end: 100.0
          end: 90)
      .animate(_scaleController)
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        Navigator.push(
          context,
          PageAnimationTransition(
            pageAnimationType: TopToBottomTransition(),
            page: HomePage(),
          ),
        );
      }
    });

  @override
  void initState() {
    // TODO: implement initState
    // _controller.forward();
    _getSharedPref().then((value) => print('pref initialized'));
    _loadSettings();
    _checkLoggedIn();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: AnimatedBuilder(
            animation: _scaleController,
            builder: (context, child) {
              return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return ScaleTransition(
                            scale: _animation,
                            child: Image.asset(
                              'assets/imgs/bisa_icon.png',
                            ));
                      }));
            }),
      ),
    );
  }

  Future<void> _getSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void _checkLoggedIn() async {
    prefs = await SharedPreferences.getInstance();
    var storedUser = prefs.getString('user');
    // ignore: unused_local_variable
    var isLogin = prefs.getBool('isLogin');

    if (storedUser != null) {
      // if(storedUser != null){
      setState(() {
        loggedinUser = jsonDecode(storedUser);
      });
      // }

      if (loggedinUser.toString().isNotEmpty) {
        var currentUser = CurrentUser(
            id: loggedinUser['id'],
            fname: loggedinUser['fname'],
            lname: loggedinUser['lname'],
            email: loggedinUser['email'],
            city: loggedinUser['city'],
            phone: loggedinUser['phone'],
            gender: loggedinUser['gender'],
            region: loggedinUser['region'],
            cityId: loggedinUser['cityId'],
            regionId: loggedinUser['regionId'],
            token: loggedinUser['token']);

        context.read<CurrentUserProvider>().setCurrentUser(currentUser);
        await Future.delayed(Duration(milliseconds: 3000), () {
          _scaleController.forward();
        });
      } else {
        await Future.delayed(Duration(milliseconds: 3000), () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/login');
          // Navigator.pushNamed(context, '/onboarding');
        });
      }
    } else {
      await Future.delayed(Duration(milliseconds: 3000), () {
        Navigator.pop(context);
        // Navigator.pushNamed(context, '/signin');
        Navigator.pushNamed(context, '/onboarding');
      });
    }
  }

  void _loadSettings() async {
    loadSettings().then((value) {
      if (value != null) {
        if (value['status'] == 'success') {
          context.read<SettingsProvider>().setSettings(value['data']);
          print('settings loaded');
        } else {
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return Popup(
                  msg: value['message'],
                );
              });
        }
      } else {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return Popup(
                msg: 'Sorry, encountered an error. Please try again',
              );
            });
      }
    }).catchError((onError) {
      if (mounted) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return Popup(
                msg: onError,
              );
            });
      }
      return null;
    });
    // context.read<SettingsProvider>().settings;
  }
}
