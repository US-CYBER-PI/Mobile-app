import 'package:get/get.dart';

//Хотел сделать переворот Qr кода чтобы показывать было удобнее, но выглядит странно :/
class PayViewController extends GetxController { 
  RxInt turns = 0.obs;
  bool isHorizontal = true;
  flip() {
    if (isHorizontal) {
      turns = turns + 2;
      isHorizontal = !isHorizontal;
    } else {
      turns = turns - 2;
      isHorizontal = !isHorizontal;
    }
  }
}
