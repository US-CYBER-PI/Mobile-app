import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:qiwi_mobile_app/common/colors.dart';

class TextFieldPhone extends StatelessWidget {
  const TextFieldPhone({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorsCustom.secondary)),
      child: Row(
        children: [
          const Text(
            '+7',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 2),
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.phone,
              inputFormatters: [MaskedInputFormatter('(###) ###-##-##')],
              decoration: const InputDecoration(
                hintText: '(999) 999-99-99',
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
