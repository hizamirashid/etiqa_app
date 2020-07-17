import 'package:etiqa_test_app/add_to_do_Page.dart';
import 'package:flutter/material.dart';
import 'package:etiqa_test_app/main.dart';

import 'main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => MyHomePage(
                  title: 'To-Do List',
                ));
      // case '/add_to_do':
      //   //validation the correct  data type
      //   if (args is String) {
      //     return MaterialPageRoute(
      //       builder: (_) => Add_to_do_Page(
      //         data: args,
      //       ),
      //     );
      //   }

      //   return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
