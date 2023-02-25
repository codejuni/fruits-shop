import 'package:flutter/material.dart';

import '../models/cart_model.dart';
import '../pages/details/details_page.dart';

class CartBarTile extends StatelessWidget {
  const CartBarTile({
    super.key,
    required this.model,
  });

  final CartModel model;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 800),
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return FadeTransition(
                          opacity: animation,
                          child: DetailsPage(
                            model: model.fruit,
                            tag: '/details',
                          ),
                        );
                      },
                    ));
              },
              child: CircleAvatar(
                radius: 23,
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Hero(
                    tag: '${model.fruit.name}/details',
                    child: Image.asset(
                      model.fruit.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          CircleAvatar(
            radius: 14,
            backgroundColor: const Color(0XFFF4C459),
            child: Text(
              model.count.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}
