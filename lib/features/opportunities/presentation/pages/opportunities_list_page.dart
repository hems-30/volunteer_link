import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/theme.dart';

import '../bloc/opportunity_block.dart';
import '../bloc/opportunity_event.dart';
import '../bloc/opportunity_state.dart';

import '../widgets/opportunity_card.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/empty_widget.dart';

class OpportunitiesListPage extends StatefulWidget {
  const OpportunitiesListPage({super.key});

  @override
  State<OpportunitiesListPage> createState() => _OpportunitiesListPageState();
}

class _OpportunitiesListPageState extends State<OpportunitiesListPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<OpportunityBloc>().add(LoadOpportunities());
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.volunteer_activism,
              color: theme.colorScheme.primary,
              size: 22,
            ),
            const SizedBox(width: 8),
            Text(
              "Volunteer Link",
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<OpportunityBloc>().add(LoadOpportunities());
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add'),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search opportunities...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: theme.colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),

          Expanded(
            child: BlocBuilder<OpportunityBloc, OpportunityState>(
              builder: (context, state) {
                if (state is OpportunityLoading) {
                  return const LoadingWidget();
                }

                if (state is OpportunityError) {
                  return ErrorWidgetCustom(
                    message: state.message,
                    onRetry: () {
                      context.read<OpportunityBloc>().add(LoadOpportunities());
                    },
                  );
                }

                if (state is OpportunityLoaded) {
                  final query = searchController.text.toLowerCase();

                  final filtered = state.opportunities.where((item) {
                    final title = item.title.toLowerCase();
                    final org = item.organization.toLowerCase();
                    final location = item.location.toLowerCase();

                    return title.contains(query) ||
                        org.contains(query) ||
                        location.contains(query);
                  }).toList();

                  if (filtered.isEmpty) {
                    return const EmptyWidget(
                      message: "No opportunities found",
                      subtitle: "Try a different search",
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final item = filtered[index];

                      return OpportunityCard(
                        title: item.title,
                        organization: item.organization,
                        location: item.location,
                        category: item.category,
                        description: item.description,
                        onTap: () {
                          context.push(
                            '/detail',
                            extra: item,
                          );
                        },
                      );
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}