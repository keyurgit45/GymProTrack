import 'package:get/get.dart';
import 'package:pacific_gym/views/pages/home_page.dart';
import 'package:pacific_gym/views/pages/intro_page.dart';
import 'package:pacific_gym/views/pages/landing_page.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => LandingPage()),
    GetPage(name: '/intro', page: () => IntroPage()),
    GetPage(name: '/home', page: () => HomePage()),
  ];
}
