import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:qiwi_mobile_app/common/colors.dart';

class TextFieldPhone extends StatelessWidget {
  const TextFieldPhone(
    this.loginController, {
    Key? key,
  }) : super(key: key);

  final TextEditingController loginController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: loginController,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        MaskedInputFormatter('(###) ###-##-##'),
      ],
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
        isDense: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "+7",
            style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
          ),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        hintText: '(999) 999-99-99',
        border: const OutlineInputBorder(),
      ),
    );
  }
}
