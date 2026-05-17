import 'package:flutter/material.dart';

// Pages
import '../../features/opportunities/presentation/pages/splash_page.dart';
import '../../features/opportunities/presentation/pages/opportunities_list_page.dart';
import '../../features/opportunities/presentation/pages/opportunity_detail_page.dart';
import '../../features/opportunities/presentation/pages/add_opportunity_page.dart';
import '../../features/opportunities/presentation/pages/edit_opportunity_page.dart';

class AppRoutes {
  // Route names
  static const String splash = '/';
  static const String home = '/home';
  static const String detail = '/detail';
  static const String add = '/add';
  static const String edit = '/edit';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {

      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
        );

      case home:
        return MaterialPageRoute(
          builder: (_) => const OpportunitiesListPage(),
        );

      case detail:
        final args = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => OpportunityDetailPage(opportunity: args),
        );

      case add:
        return MaterialPageRoute(
          builder: (_) => const AddOpportunityPage(),
        );

      case edit:
        final args = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => EditOpportunityPage(opportunity: args),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}