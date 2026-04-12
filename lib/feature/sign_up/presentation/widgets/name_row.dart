import 'package:flutter/material.dart';

import '../../../../core/values/app_strings.dart';

class NameRowFormField extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  const NameRowFormField({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: firstNameController,
            textInputAction: TextInputAction.next,
            validator: (v) =>
                v?.isEmpty ?? true ? AppStrings.firstNameRequired : null,
            decoration: const InputDecoration(labelText: AppStrings.firstName),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            controller: lastNameController,
            textInputAction: TextInputAction.next,
            validator: (v) =>
                v?.isEmpty ?? true ? AppStrings.lastNameRequired : null,
            decoration: const InputDecoration(labelText: AppStrings.lastName),
          ),
        ),
      ],
    );
  }
}
