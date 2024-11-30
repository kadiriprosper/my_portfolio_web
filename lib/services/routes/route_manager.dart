import 'package:get/get.dart';
import 'package:my_portfolio_web/view/about_page.dart';
import 'package:my_portfolio_web/view/contact_page.dart';
import 'package:my_portfolio_web/view/dashboard_page.dart';
import 'package:my_portfolio_web/view/projects_page.dart';
import 'package:my_portfolio_web/view/splash_screen.dart';
import 'package:my_portfolio_web/view/unknown_route_page.dart';

class RouteManager {
  static String splashScreenRoute = '/';
  static String aboutPageRoute = '/me';
  static String contactPageRoute = '/contact';
  static String dashboardPageRoute = '/dashboard';
  static String projectsPageRoute = '/projects';
  static String unknownPageRoute = '/error';

  static String initialRoute = splashScreenRoute;
  static String errorPageRoute = unknownPageRoute;

  static List<GetPage> getPages() {
    return [
      GetPage(
        name: splashScreenRoute,
        page: () => const SplashScreen(),
      ),
      GetPage(
        name: aboutPageRoute,
        page: () => const AboutPage(),
      ),
      GetPage(
        name: contactPageRoute,
        page: () => const ContactPage(),
      ),
      GetPage(
        name: dashboardPageRoute,
        page: () => const DashboardPage(),
      ),
      GetPage(
        name: projectsPageRoute,
        page: () => const ProjectsPage(),
      ),
      // NOTE::-----------------------------------------------------------
      // Always Make the unknown route last
      GetPage(
        name: unknownPageRoute,
        page: () => const UnknownRoutePage(),
      ),
    ];
  }
}
