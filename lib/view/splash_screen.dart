import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:my_portfolio_web/controller/data_controller.dart';
import 'package:my_portfolio_web/services/routes/route_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(future: Future(
        () async {
          await dataController.getProject();
          await dataController.getArticles();
          Get.toNamed(RouteManager.dashboardPageRoute);
        },
      ), builder: (context, _) {
        return SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitRipple(
                size: MediaQuery.of(context).size.width / 10,
                color: Colors.purple,
              ),
              Text('Getting Data...'),
            ],
          ),
        );
      }),
    );
  }
}
