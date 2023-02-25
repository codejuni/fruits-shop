// ignore_for_file: depend_on_referenced_packages, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/controller.dart';
import '../../enum/fruits_enum.dart';
import '../../models/cart_model.dart';
import '../../tiles/cartbar_tile.dart';
import 'bloc_cart.dart';
import 'bloc_fruits.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> globalKey = GlobalKey();
  double cartBarHeight = 120;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<FruitsController>(context, listen: false).getList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    FruitsController bloc = Provider.of<FruitsController>(context);

    Duration _duration = const Duration(milliseconds: 1600);
    return AnimatedBuilder(
      animation: bloc,
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: Colors.grey[900],
          key: globalKey,
          endDrawer: Drawer(
            child: SafeArea(
              child: Column(
                children: [
                  const ListTile(
                    leading: BackButton(),
                    title: Text('Back'),
                  ),
                  const SizedBox(height: 30),
                  ListView.builder(
                    itemCount: bloc.sort.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(bloc.sort[index]),
                        onTap: () {
                          bloc.filterSort(index);
                          Navigator.pop(context);
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          appBar: AppBar(
            title: const Text('Sale of fruits'),
            actions: [
              IconButton(
                onPressed: () {
                  globalKey.currentState!.openEndDrawer();
                },
                icon: const Icon(
                  Icons.filter_list,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              AnimatedPositioned(
                duration: _duration,
                left: 0,
                right: 0,
                curve: Curves.decelerate,
                top: topForFruitsBloc(bloc.blocState, size),
                height: size.height - kToolbarHeight,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                  child: FruitsBloc(
                    fruits: bloc.fruits,
                    loading: bloc.loading,
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: _duration,
                left: 0,
                right: 0,
                curve: Curves.decelerate,
                top: topForCartBloc(bloc.blocState, size),
                height: size.height,
                child: GestureDetector(
                  onVerticalDragUpdate: onVerticalDragUpdate,
                  child: Column(
                    children: [
                      AnimatedSwitcher(
                        duration: _duration,
                        child: bloc.blocState == BlocState.normal
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                height: cartBarHeight - 40,
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Cart',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Expanded(
                                      child: bloc.loading
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                              ),
                                              child: ListView.separated(
                                                itemCount: bloc.cart.length,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 7,
                                                ),
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                separatorBuilder: (context,
                                                        index) =>
                                                    const SizedBox(width: 10),
                                                itemBuilder: (context, index) {
                                                  CartModel model =
                                                      bloc.cart[index];
                                                  return CartBarTile(
                                                    model: model,
                                                  );
                                                },
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                    ),
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: const Color(0XFFF4C459),
                                      child: Text(
                                        bloc.quantityItems.toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: _duration,
                          child: bloc.blocState == BlocState.cart
                              ? const CartBloc()
                              : const SizedBox.shrink(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  double topForFruitsBloc(BlocState state, Size size) {
    if (state == BlocState.normal) {
      return -cartBarHeight;
    } else if (state == BlocState.cart) {
      return -(size.height - kToolbarHeight - cartBarHeight / 2);
    }
    return 0;
  }

  double topForCartBloc(BlocState state, Size size) {
    if (state == BlocState.normal) {
      return size.height - kToolbarHeight - cartBarHeight;
    } else if (state == BlocState.cart) {
      return cartBarHeight / 2;
    }
    return 0;
  }

  void onVerticalDragUpdate(DragUpdateDetails details) {
    if (details.primaryDelta! < -7) {
      Provider.of<FruitsController>(context, listen: false).changeToCart();
    } else if (details.primaryDelta! > 12) {
      Provider.of<FruitsController>(context, listen: false).changeToNormal();
    }
  }
}
