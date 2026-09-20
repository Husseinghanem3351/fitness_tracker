import 'dart:ui';
import 'package:flutter/material.dart';
import '../cubit/cubit.dart';

class GradiantWidget extends StatelessWidget {
  const GradiantWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        HomeCubit.get(context).changeAddButtonState();
        return false;
      },
      child: GestureDetector(
        onTap: () => HomeCubit.get(context).changeAddButtonState(),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withOpacity(0.4),
          ),
        ),
      ),
    );
  }
}
