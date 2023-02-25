// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../assets/app_images.dart';
import '../../controllers/controller.dart';
import '../details/details_page.dart';

class CartBloc extends StatelessWidget {
  const CartBloc({Key? key}) : super(key: key);

  final double delivery = 10;

  @override
  Widget build(BuildContext context) {
    FruitsController controller = Provider.of<FruitsController>(context);
    return Container(
      color: Colors.grey[900],
      padding: const EdgeInsets.only(bottom: 155),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Cart',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: controller.cart.length + 1,
              padding: const EdgeInsets.symmetric(vertical: 10),
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                return index == controller.cart.length
                    ? ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.grey,
                          child: Image.asset(
                            AppImages.delivery,
                            color: Colors.white,
                          ),
                        ),
                        title: const Text(
                          'Delivery',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          'All adres of \$40 or more qualify for  free delivery',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        trailing: Text(
                          '\$${delivery.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : CartTile(controller: controller, index: index);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total :',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${(controller.totalPrice() + delivery).toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(
                      Color(0XFFF4C459),
                    ),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)))),
                child: const Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartTile extends StatelessWidget {
  const CartTile({
    super.key,
    required this.controller,
    required this.index,
  });

  final FruitsController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 800),
              pageBuilder: (context, animation, secondaryAnimation) {
                return FadeTransition(
                  opacity: animation,
                  child: DetailsPage(
                    model: controller.cart[index].fruit,
                    tag: '/details',
                  ),
                );
              },
            ));
      },
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Hero(
            tag: '${controller.cart[index].fruit.name}/details',
            child: Image.asset(
              controller.cart[index].fruit.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      title: Text(
        '${controller.cart[index].count}  x  ${controller.cart[index].fruit.name}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Text(
        '\$${(controller.cart[index].count * controller.cart[index].fruit.price).toStringAsFixed(2)}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
