import 'package:flutter/material.dart';

class CustamTextFormFiled extends StatelessWidget {
  const CustamTextFormFiled({
    super.key,
    required this.controllar,
    required this.hintText,
    required this.title,
    this.maxLines,
    this.validator,
  });

  final TextEditingController controllar;
  final String hintText;
  final String title;
  final int? maxLines;
  final Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.displaySmall!.copyWith(fontSize: 20),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controllar,
          validator: validator != null
              ? (String? value) => validator!(value)
              : null,

          maxLines: maxLines ?? 1,
          decoration: InputDecoration(hintText: hintText),
          cursorErrorColor: Colors.red,
          cursorWidth: 3,

          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
