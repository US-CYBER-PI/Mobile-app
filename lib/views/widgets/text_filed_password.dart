import 'package:flutter/material.dart';

class TextFiledPassword extends StatefulWidget {
  TextFiledPassword(
    this.passwordController, {
    Key? key,
  }) : super(key: key);
  TextEditingController passwordController;
  @override
  State<TextFiledPassword> createState() => _TextFiledPasswordState();
}

class _TextFiledPasswordState extends State<TextFiledPassword> {
  bool isCheck = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      obscureText: isCheck,
      style: TextStyle(fontSize: 18),
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Icon(
            Icons.lock_outline,
            size: 22,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(4.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              setState(() {
                isCheck = !isCheck;
              });
            },
            child: Icon(
              isCheck ? Icons.visibility_off : Icons.visibility,
              color: Theme.of(context).colorScheme.tertiary,
              size: 24,
            ),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
