import 'package:flutter/material.dart';

import '../models/fruits_model.dart';

class FuitTile extends StatelessWidget {
  const FuitTile({
    super.key,
    required this.model,
    required this.itemHeight,
  });

  final FruitsModel model;
  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: Colors.black26,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: itemHeight / 3,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Hero(
              tag: model.name,
              child: Image.asset(
                model.image,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            model.name,
            maxLines: 2,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '1000g',
            maxLines: 2,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            '\$${model.price.toStringAsFixed(2)}',
            maxLines: 2,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
