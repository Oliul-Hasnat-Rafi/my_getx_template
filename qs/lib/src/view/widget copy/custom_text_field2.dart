import 'package:flutter/material.dart';
import 'package:photos/src/view/widget%20copy/custom_text_field1.dart';

import '../../../components.dart';


class CustomTextField2 extends StatelessWidget {
  const CustomTextField2({
    super.key,
    this.textEditingController,
    required this.headingText,
    this.keyboardType = TextInputType.name,
    this.maxLine = 1,
    this.readOnly = false,
    this.hintText,
    this.validator,
    this.onChanged,
    this.initialValue,
  });

  // final ProfileScreenController _controller = Get.find();
  final TextEditingController? textEditingController;
  final String headingText;
  final TextInputType keyboardType;
  final int maxLine;
  final bool readOnly;
  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headingText,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.bold),
        ),
        CustomTextField1(
          initialValue: initialValue,
          readOnly: readOnly,
          keyboardType: keyboardType,
          textEditingController: textEditingController,
          hintText: hintText ?? "",
          maxLine: maxLine,
          boxConstraints: const BoxConstraints(),
          contentPadding: EdgeInsets.symmetric(vertical: defaultPadding / 4),
          border: InputBorder.none,
          validator: validator,
          onChanged: onChanged,
        ),
       
        SizedBox(height: defaultPadding / 2),
      ],
    );
  }
}
