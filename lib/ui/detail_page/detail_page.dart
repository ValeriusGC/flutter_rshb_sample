import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:frshbsample/core/domain/product.dart';
import 'package:frshbsample/ui/ui_service.dart';

class DetailPage extends StatelessWidget {
  final Product product;

  const DetailPage({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('detail_page_title'.tr()),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('detail_page_title'.tr()),
                standardVerticalSizedBox,
              ],
            ),
          ),
        ),
      ),
      onWillPop: () {
        return Future.value(true);
      },
    );
  }
}
