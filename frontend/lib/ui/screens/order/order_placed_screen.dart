import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/theme.dart';
import 'package:frontend/ui/widgets/gap_widget.dart';

class OrderPlacedScreen extends StatelessWidget {
  const OrderPlacedScreen({super.key});

  static const routeName = "order-placed-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Placed!"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.cube_box_fill,
                  color: AppColors.textLight, size: 100),
              const GapWidget(size: -8),
              Text(
                "Order Placed!",
                style: TextStyles.heading3.copyWith(color: AppColors.textLight),
              ),
              const GapWidget(size: -5),
              Text(
                "You can check out the status by going to Profile > My Orders",
                style: TextStyles.body2.copyWith(color: AppColors.textLight),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
