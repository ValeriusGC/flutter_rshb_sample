import 'package:flutter/material.dart';

abstract class UiConst {
  static const minPaddingSize = 4.0;
  static const stdPaddingSize = 8.0;
  static const dblPaddingSize = 16.0;
  static const minGapVerticalSize = 8.0;
  static const stdGapVerticalSize = 24.0;

  static const fontSize = 10.0;

  //
  static const fruitsCategoryImagePath = 'assets/images/categories/fruit.png';
  static const meatCategoryImagePath = 'assets/images/categories/meat.png';
  static const milkCategoryImagePath = 'assets/images/categories/milk.png';

  static const comingSoonImagePath = 'assets/images/products/photo-coming-soon.jpg';

  static const minimalVerticalSizedBox = SizedBox(height: UiConst.minGapVerticalSize);
  static const standardVerticalSizedBox = SizedBox(height: UiConst.stdGapVerticalSize);
  static const circularProgressIndicator = CircularProgressIndicator();
  static const centerCircularProgressIndicator = Center(child: CircularProgressIndicator());

  static const brandMainColor = Colors.green;
  static const brandMainBackgroundColor = Colors.lightGreen;
}

