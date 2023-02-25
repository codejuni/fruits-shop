import 'package:flutter/material.dart';

class StaggeredDualView extends StatelessWidget {
  const StaggeredDualView({
    super.key,
    required this.fruits,
    this.crossAxisCount = 2,
    this.childAspectRatio = 0.55,
    this.spacing = 20,
    required this.itemBuilder,
  });

  final List<dynamic> fruits;
  final int? crossAxisCount;
  final double? childAspectRatio;
  final double? spacing;
  final Widget? Function(BuildContext, int, double) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constains) {
      double width = MediaQuery.of(context).size.width;
      double itemHeight = (width * 0.5) / childAspectRatio!;
      return GridView.builder(
        itemCount: fruits.length,
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount!,
          childAspectRatio: childAspectRatio!,
          crossAxisSpacing: spacing!,
          mainAxisSpacing: spacing!,
        ),
        padding: EdgeInsets.only(
          top: 120 + spacing!,
          right: spacing!,
          left: spacing!,
          bottom:
              fruits.length.isOdd ? spacing! : spacing! + (itemHeight * 0.3),
        ),
        itemBuilder: (context, index) {
          return Transform.translate(
            offset: Offset(0.0, index.isOdd ? itemHeight * 0.3 : 0),
            child: itemBuilder(context, index, itemHeight),
          );
        },
      );
    });
  }
}
