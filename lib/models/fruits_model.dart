import '../assets/app_images.dart';

class FruitsModel {
  String id;
  String name;
  String image;
  String description;
  double price;
  FruitsModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
  });

  factory FruitsModel.formJson(Map<String, dynamic> value, String id) =>
      FruitsModel(
        id: id,
        name: value['name'],
        image: value['image'],
        price: value['price'],
        description: value['description'],
      );

  static List<FruitsModel> list = [
    FruitsModel(
      id: '01',
      name: 'Cereza',
      image: AppImages.cereza,
      description: 'description',
      price: 15,
    ),
    FruitsModel(
      id: '02',
      name: 'Mango',
      image: AppImages.mango,
      description: 'description',
      price: 11.4,
    ),
    FruitsModel(
      id: '03',
      name: 'Manzana',
      image: AppImages.manzana,
      description: 'description',
      price: 9.8,
    ),
    FruitsModel(
      id: '04',
      name: 'Naranja',
      image: AppImages.naranja,
      description: 'description',
      price: 7.6,
    ),
    FruitsModel(
      id: '05',
      name: 'Pera',
      image: AppImages.pera,
      description: 'description',
      price: 11,
    ),
    FruitsModel(
      id: '06',
      name: 'Piña',
      image: AppImages.pina,
      description: 'description',
      price: 12.8,
    ),
    FruitsModel(
      id: '07',
      name: 'Platano',
      image: AppImages.platano,
      description: 'description',
      price: 15,
    ),
  ];
}
