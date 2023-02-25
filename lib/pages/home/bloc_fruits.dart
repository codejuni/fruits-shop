import 'package:flutter/material.dart';

import '../../models/fruits_model.dart';
import '../../tiles/fruit_tile.dart';
import '../../widgets/staggered_dual_view.dart';
import '../details/details_page.dart';

class FruitsBloc extends StatelessWidget {
  final List<FruitsModel> fruits;
  final bool loading;
  const FruitsBloc({
    Key? key,
    required this.fruits,
    required this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: loading
          ? StaggeredDualView(
              fruits: fruits,
              itemBuilder: (context, index, itemHeight) {
                FruitsModel model = fruits[index];
                return GestureDetector(
                  child: FuitTile(
                    model: model,
                    itemHeight: itemHeight,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 800),
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return FadeTransition(
                              opacity: animation,
                              child: DetailsPage(
                                model: model,
                                tag: '',
                              ),
                            );
                          },
                        ));
                  },
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
