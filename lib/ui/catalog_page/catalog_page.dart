import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:frshbsample/sl.dart';
import 'package:frshbsample/ui/ui_service.dart';

class CatalogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('catalog_page_title'.tr()),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('catalog_page_title'.tr()),
                standardVerticalSizedBox,
                RaisedButton(
                  child: Text('${'load_detail'.tr()}: '),
                  onPressed: () => TheCatalogPageViewModel.showDetailPage(),
                ),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () {
        TheMainPageViewModel.catalogClosed();
        return Future.value(true);
      },
    );
  }
}
