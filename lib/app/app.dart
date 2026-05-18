import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/opportunities/presentation/bloc/opportunity_block.dart';
import '../features/opportunities/data/datasources/opportunity_remote_data_source.dart';
import '../features/opportunities/data/repositories/opportunity_repository_impl.dart';
import '../core/network/dio_client.dart';

import 'routes/app_routes.dart';
import 'theme/theme.dart';

class VolunteerLinkApp extends StatelessWidget {
  const VolunteerLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dioClient = DioClient();

    final dataSource = OpportunityRemoteDataSource(
      dioClient: dioClient,
    );

    final repository = OpportunityRepositoryImpl(
      remoteDataSource: dataSource,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => OpportunityBloc(
            repository: repository,
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: appRouter,
      ),
    );
  }
}