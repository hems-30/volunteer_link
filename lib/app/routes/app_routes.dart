import 'package:go_router/go_router.dart';

import '../../features/opportunities/domain/entities/opportunity.dart';
import '../../features/opportunities/presentation/pages/splash_page.dart';
import '../../features/opportunities/presentation/pages/opportunities_list_page.dart';
import '../../features/opportunities/presentation/pages/opportunity_detail_page.dart';
import '../../features/opportunities/presentation/pages/add_opportunity_page.dart';
import '../../features/opportunities/presentation/pages/edit_opportunity_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [

    // Splash
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),

    // Home
    GoRoute(
      path: '/home',
      builder: (context, state) => const OpportunitiesListPage(),
    ),

    // Detail
    GoRoute(
      path: '/detail',
      builder: (context, state) {
        final opportunity = state.extra as Opportunity;
        return OpportunityDetailPage(opportunity: opportunity);
      },
    ),

    // Add
    GoRoute(
      path: '/add',
      builder: (context, state) => const AddOpportunityPage(),
    ),

    // Edit
    GoRoute(
      path: '/edit',
      builder: (context, state) {
        final opportunity = state.extra as Opportunity;
        return EditOpportunityPage(opportunity: opportunity);
      },
    ),
  ],
);