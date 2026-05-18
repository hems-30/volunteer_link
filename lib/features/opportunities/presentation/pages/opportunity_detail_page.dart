import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/opportunity_block.dart';
import '../bloc/opportunity_event.dart';
import '../bloc/opportunity_state.dart';
import '../../domain/entities/opportunity.dart';

class OpportunityDetailPage extends StatelessWidget {
  final Opportunity opportunity;

  const OpportunityDetailPage({
    super.key,
    required this.opportunity,
  });

  void _confirmDelete(BuildContext context) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Delete Opportunity"),
        content: const Text(
          "Are you sure you want to delete this opportunity?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);

              context.read<OpportunityBloc>().add(
                    DeleteOpportunity(opportunity.id!),
                  );
            },
            child: Text(
              "Delete",
              style: TextStyle(color: theme.colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<OpportunityBloc, OpportunityState>(
      listener: (context, state) {
        if (state is OpportunitySuccess) {
          context.read<OpportunityBloc>().add(LoadOpportunities());
          context.go('/home');
        }

        if (state is OpportunityError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Opportunity Details"),
        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 180,
                width: double.infinity,
                color: theme.colorScheme.primary.withOpacity(0.15),
                child: Center(
                  child: Icon(
                    Icons.volunteer_activism,
                    size: 60,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      opportunity.title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      opportunity.organization,
                      style: theme.textTheme.bodyMedium,
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 18,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(opportunity.location),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        opportunity.category,
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 6),
                        Text(opportunity.date),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Text(
                      "Description",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      opportunity.description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          context.push('/edit', extra: opportunity);
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text("Edit Opportunity"),
                      ),
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () => _confirmDelete(context),
                        icon: Icon(
                          Icons.delete,
                          color: theme.colorScheme.error,
                        ),
                        label: Text(
                          "Delete Opportunity",
                          style: TextStyle(color: theme.colorScheme.error),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}