import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qiwi_mobile_app/utilis/reusable_card.dart';

class PayView extends StatelessWidget {
  const PayView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        
        child: Padding(
          padding: EdgeInsets.all(30), //TODO make it dynamic
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ReusableCard(
                color: Theme.of(context).colorScheme.secondary, //TODO parse from theme
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: BarcodeWidget(
                    color: Theme.of(context).colorScheme.tertiary,
                    barcode: Barcode.qrCode(), // Barcode type and settings
                    data:
                        'https://www.youtube.com/watch?v=dQw4w9WgXcQ&ab_channel=RickAstley', // Content // Надо добавиить ссылку на запрос
                    width: 300, //Это тоже скейлить надо (ˉ﹃ˉ)
                    height: 300,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(
                    labelText: "Введите сумму", //TODO localization
                    // focusColor: Theme.of(context).colorScheme.primary, 
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 10.0),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)))),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], // Only numbers can be entered
              ),
            ],
          ),
        ),
      ),
    );
  }
}
