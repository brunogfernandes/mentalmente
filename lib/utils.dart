import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart' show Flushbar, FlushbarPosition;

class Utils {
  static final List<Flushbar> flushBars = [];

  static void showSnackBar(
    BuildContext context, {
    required String text,
    required Color color,
  }) =>
  _show(
    context,
    Flushbar(
      //padding: EdgeInsets.all(24),
      messageText: Center(
          child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 24),
      )),
      duration: const Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: color,
      animationDuration: const Duration(microseconds: 0),
    ),
  );

  static Future _show(BuildContext context, Flushbar newFlushBar) async {
    await Future.wait(flushBars.map((flushBar) => flushBar.dismiss()).toList());
    flushBars.clear();

    // ignore: use_build_context_synchronously
    newFlushBar.show(context);
    flushBars.add(newFlushBar);
  }
}
