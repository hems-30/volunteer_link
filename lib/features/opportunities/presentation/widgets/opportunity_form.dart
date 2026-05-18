import 'package:flutter/material.dart';
import '../../../../app/theme/theme.dart';

class OpportunityForm extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController orgController;
  final TextEditingController locationController;
  final TextEditingController descriptionController;

  final String selectedCategory;
  final Function(String) onCategoryChanged;

  final DateTime? selectedDate;
  final Function(DateTime) onDatePicked;

  final VoidCallback onSubmit;
  final String buttonText;
  final bool isLoading;

  const OpportunityForm({
    super.key,
    required this.titleController,
    required this.orgController,
    required this.locationController,
    required this.descriptionController,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.selectedDate,
    required this.onDatePicked,
    required this.onSubmit,
    required this.buttonText,
    required this.isLoading,
  });

  @override
  State<OpportunityForm> createState() => _OpportunityFormState();
}

class _OpportunityFormState extends State<OpportunityForm> {
  static const List<String> _categories = [
    'Education',
    'Environment',
    'Health',
    'Food',
    'Animals',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: widget.titleController,
            decoration: const InputDecoration(labelText: "Title"),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: widget.orgController,
            decoration: const InputDecoration(labelText: "Organization"),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: widget.locationController,
            decoration: const InputDecoration(labelText: "Location"),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: widget.selectedCategory,
            decoration: const InputDecoration(labelText: "Category"),
            dropdownColor: theme.colorScheme.surface,
            items: _categories.map((cat) {
              return DropdownMenuItem<String>(
                value: cat,
                child: Text(cat, style: theme.textTheme.bodyMedium),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) widget.onCategoryChanged(value);
            },
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.border),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, size: 18, color: theme.colorScheme.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.selectedDate == null
                        ? "Select Date"
                        : widget.selectedDate!.toLocal().toString().split(" ")[0],
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: widget.selectedDate ?? DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      widget.onDatePicked(picked);
                    }
                  },
                  child: const Text("Pick"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: widget.descriptionController,
            maxLines: 4,
            decoration: const InputDecoration(labelText: "Description"),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: widget.isLoading ? null : widget.onSubmit,
              child: widget.isLoading
                  ? SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        color: theme.colorScheme.onPrimary,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(widget.buttonText),
            ),
          ),
        ],
      ),
    );
  }
}