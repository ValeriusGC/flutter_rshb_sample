import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:frshbsample/sl.dart';
import 'package:frshbsample/ui/catalog_page/widgets/tab_widget.dart';
import 'package:frshbsample/ui/ui_service.dart';

import 'widgets/farmers_tab_view.dart';
import 'widgets/products_tab_view.dart';
import 'widgets/tours_tab_view.dart';

const tabLength = 3;
const toolHeight = 192.0;
const iconHeight = 96.0;
const iconSize = 36.0;

class CatalogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabLength,
      child: WillPopScope(
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text('catalog_page_title'.tr()),
              bottom: TabBar(
                tabs: [
                  Tab(child: TabWidget(text: 'products_title'.tr())),
                  Tab(child: TabWidget(text: 'farmers_title'.tr())),
                  Tab(child: TabWidget(text: 'tours_title'.tr())),
                ],
              ),
            ),
            body: Container(
              padding: const EdgeInsets.all(UiConst.stdPaddingSize),
              child: TabBarView(
                children: [
                  ProductsTabView(text: 'products_title'.tr()),
                  FarmersTabView(),
                  ToursTabView(),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () {
          TheMainPageViewModel.catalogClosed();
          return Future.value(true);
        },
      ),
    );
  }
}
