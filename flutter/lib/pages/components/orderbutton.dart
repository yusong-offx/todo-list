import 'package:flutter/material.dart';

class OrderButton {
  static MaterialStatePropertyAll<Color>? backgroundcolor;
  bool on = false;
  String name;
  void Function()? func;

  OrderButton({required this.on, required this.name});

  Widget getButton() {
    return OutlinedButton(
      style: ButtonStyle(backgroundColor: on ? null : backgroundcolor),
      onPressed: () {
        on = !on;
        func!();
      },
      child: const Text("done"),
    );
  }
}

Widget orderButton(BuildContext context, List<OrderButton> items) {
  OrderButton.backgroundcolor =
      MaterialStatePropertyAll<Color>(Theme.of(context).dialogBackgroundColor);

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
    child: ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(width: 10),
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      itemBuilder: (context, index) => items[index].getButton(),
    ),
  );
}
