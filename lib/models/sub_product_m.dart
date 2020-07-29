import 'package:flutter/foundation.dart';

class SubProduct {
  final int id;
  final int productId;
  final String name;
  final String description;
  final String image1Path;
  final String image2Path;
  final String image3Path;
  final String image4Path;
  final String image1Description;
  final String image2Description;
  final String image3Description;
  final String image4Description;

  SubProduct({
    @required this.id,
    @required this.productId,
    @required this.name,
    @required this.description,
    @required this.image1Path,
    @required this.image2Path,
    @required this.image3Path,
    @required this.image4Path,
    @required this.image1Description,
    @required this.image2Description,
    @required this.image3Description,
    @required this.image4Description,
  });
}
