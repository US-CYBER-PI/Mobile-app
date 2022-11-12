import 'package:barcode_widget/barcode_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:qiwi_mobile_app/controllers/pay_view_controller.dart';
import 'package:qiwi_mobile_app/locator_service.dart';

import 'package:qiwi_mobile_app/views/widgets/reusable_card.dart';

class PayView extends StatefulWidget {
  const PayView({Key? key}) : super(key: key);

  @override
  State<PayView> createState() => _PayViewState();
}

class _PayViewState extends State<PayView> {
  ResponseCodes responseCodes = ResponseCodes.error;
  final c = Get.put(PayViewController(ls<Dio>));

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
                color: Theme.of(context)
                    .colorScheme
                    .secondary, //TODO parse from theme
                child: Obx(
                  () => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: BarcodeWidget(
                      color: Theme.of(context).colorScheme.tertiary,
                      barcode: Barcode.qrCode(), // Barcode type and settings
                      data: c.payToken.toString(),
                      // 'https://www.youtube.com/watch?v=dQw4w9WgXcQ&ab_channel=RickAstley', // Content // Надо добавиить ссылку на запрос
                      width: 300, //Это тоже скейлить надо (ˉ﹃ˉ)
                      height: 300,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              OutlinedButton.icon(
                  onPressed: () async {
                    responseCodes = await c.updateToken();
                    if (responseCodes == ResponseCodes.sms) {
                      Get.dialog(
                        Container(
                          height: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlutterLogo(
                                size: 150,
                              ),
                              Text(
                                "This is a Custom Dialog",
                                style: TextStyle(fontSize: 20),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Close"))
                            ],
                          ),
                        ),
                      );
                    } else {
                      Get.defaultDialog(
                        title: "Alert!",
                        content: Text("Error"),
                      );
                    }
                  },
                  icon: Icon(Ionicons.add_circle),
                  label: Text('Обновить')),
              TextField(
                decoration: InputDecoration(
                  labelText: "Введите сумму", //TODO localization
                  labelStyle: Theme.of(context).textTheme.button,

                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 10.0,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),

                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 10.0,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
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
