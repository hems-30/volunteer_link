import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/opportunity.dart';
import '../bloc/opportunity_block.dart';
import '../bloc/opportunity_event.dart';
import '../bloc/opportunity_state.dart';

import '../widgets/opportunity_form.dart';

class AddOpportunityPage extends StatefulWidget {
  const AddOpportunityPage({super.key});

  @override
  State<AddOpportunityPage> createState() =>
      _AddOpportunityPageState();
}

class _AddOpportunityPageState extends State<AddOpportunityPage> {
  final titleController = TextEditingController();
  final orgController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();

  String selectedCategory = "Education";
  DateTime? selectedDate;

  void _submit() {
    if (selectedDate == null) return;

    final opportunity = Opportunity(
      title: titleController.text,
      organization: orgController.text,
      location: locationController.text,
      category: selectedCategory,
      description: descriptionController.text,
      date: selectedDate!.toIso8601String(),
    );

    context.read<OpportunityBloc>().add(
          CreateOpportunity(opportunity),
        );
  }

  @override
  void dispose() {
    titleController.dispose();
    orgController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Opportunity"),
      ),

      body: BlocConsumer<OpportunityBloc, OpportunityState>(
        listener: (context, state) {
          if (state is OpportunitySuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content:
                    Text("Opportunity created successfully"),
              ),
            );
            context.read<OpportunityBloc>().add(LoadOpportunities());
            context.go('/home');
          }

          if (state is OpportunityError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },

        builder: (context, state) {
          final isLoading = state is OpportunityLoading;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: OpportunityForm(
                titleController: titleController,
                orgController: orgController,
                locationController: locationController,
                descriptionController: descriptionController,
                selectedCategory: selectedCategory,
                onCategoryChanged: (value) {
                  setState(() => selectedCategory = value);
                },
                selectedDate: selectedDate,
                onDatePicked: (date) {
                  setState(() => selectedDate = date);
                },
                onSubmit: _submit,
                buttonText: "Create Opportunity",
                isLoading: isLoading,
              ),
            ),
          );
        },
      ),
    );
  }
}