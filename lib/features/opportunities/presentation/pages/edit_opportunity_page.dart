import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/opportunity.dart';
import '../bloc/opportunity_block.dart';
import '../bloc/opportunity_event.dart';
import '../bloc/opportunity_state.dart';

import '../widgets/opportunity_form.dart';

class EditOpportunityPage extends StatefulWidget {
  final Opportunity opportunity;

  const EditOpportunityPage({
    super.key,
    required this.opportunity,
  });

  @override
  State<EditOpportunityPage> createState() =>
      _EditOpportunityPageState();
}

class _EditOpportunityPageState extends State<EditOpportunityPage> {
  late TextEditingController titleController;
  late TextEditingController orgController;
  late TextEditingController locationController;
  late TextEditingController descriptionController;

  late String selectedCategory;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();

    final op = widget.opportunity;

    titleController = TextEditingController(text: op.title);
    orgController = TextEditingController(text: op.organization);
    locationController = TextEditingController(text: op.location);
    descriptionController = TextEditingController(text: op.description);

    selectedCategory = op.category;
    selectedDate = DateTime.tryParse(op.date);
  }

  @override
  void dispose() {
    titleController.dispose();
    orgController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    final updated = Opportunity(
      id: widget.opportunity.id,
      title: titleController.text,
      organization: orgController.text,
      location: locationController.text,
      category: selectedCategory,
      description: descriptionController.text,
      date: selectedDate?.toIso8601String() ?? "",
    );

    context.read<OpportunityBloc>().add(
          UpdateOpportunity(updated),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Opportunity"),
      ),

      body: BlocConsumer<OpportunityBloc, OpportunityState>(
        listener: (context, state) {
          if (state is OpportunitySuccess) {

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Opportunity updated successfully",
                ),
              ),
            );
            context.read<OpportunityBloc>().add(
                  LoadOpportunities(),
                );

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
                  setState(() {
                    selectedCategory = value;
                  });
                },
                selectedDate: selectedDate,
                onDatePicked: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
                onSubmit: _submit,
                buttonText: "Update Opportunity",
                isLoading: isLoading,
              ),
            ),
          );
        },
      ),
    );
  }
}