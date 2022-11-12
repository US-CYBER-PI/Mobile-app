import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:qiwi_mobile_app/common/colors.dart';

class TextFieldPhone extends StatelessWidget {
  const TextFieldPhone({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      inputFormatters: [MaskedInputFormatter('(###) ###-##-##')],
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
        isDense: true,
        prefixIcon: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("+7"),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        hintText: '(999) 999-99-99',
        border: const OutlineInputBorder(),
      ),
    );
  }
}
