import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:frshbsample/core/api/remote_provider.dart';
import 'package:frshbsample/sl.dart';
import 'package:frshbsample/ui/catalog_page/widgets/tab_widget.dart';
import 'package:frshbsample/ui/ui_service.dart';

import 'widgets/farmers_tab_view.dart';
import 'widgets/products_tab_view.dart';
import 'widgets/tours_tab_view.dart';

const _tabLength = 3;
const _toolHeight = 150.0;
const _iconHeight = 72.0;

class CatalogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('catalog_page_title'.tr()),
          ),
          body: DefaultTabController(
            length: _tabLength,
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    leading: Container(),
                    expandedHeight: _toolHeight,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        padding: const EdgeInsets.all(UiConst.stdPaddingSize),
                        color: Colors.white,
                        child: _Top(),
                      ),
                    ),
                  ),
                ];
              },
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
        ),
      ),
      onWillPop: () {
        TheMainPageViewModel.catalogClosed();
        return Future.value(true);
      },
    );
  }
}

///
class _Top extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(UiConst.stdPaddingSize),
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            color: Colors.black12,
          ),
          child: TabBar(
            labelPadding: EdgeInsets.symmetric(horizontal: 0),
            unselectedLabelColor: Colors.green,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: UiConst.brandMainColor,
            ),
            tabs: [
              Tab(child: TabWidget(text: 'products_title'.tr())),
              Tab(child: TabWidget(text: 'farmers_title'.tr())),
              Tab(child: TabWidget(text: 'tours_title'.tr())),
            ],
          ),
        ),
        _Horiz(),
      ],
    );
  }
}

///
class _Horiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: UiConst.minPaddingSize),
      height: _iconHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder<bool>(
              initialData: TheCatalogPageViewModel.sortByPrice,
              stream: TheCatalogPageViewModel.onSortByPrice,
              builder: (context, snapshot) {
                return IconButton(
                  icon: Icon(
                    Icons.sort,
                    color: snapshot.data ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () => TheCatalogPageViewModel.doSortByPrice(
                      !TheCatalogPageViewModel.sortByPrice),
                );
              }),
          IconButton(
            icon: Stack(
              overflow: Overflow.visible,
              children: [
                StreamBuilder<bool>(
                    initialData: TheCatalogPageViewModel.favoriteFilter,
                    stream: TheCatalogPageViewModel.onFavoriteFilter,
                    builder: (context, snapshot) {
                      return Icon(
                        Icons.favorite,
                        color: snapshot.data ? Colors.blue : Colors.grey,
                      );
                    }),
                Positioned(
                  top: -7,
                  right: -7,
                  child: StreamBuilder<List<int>>(
                      initialData: TheCatalogPageViewModel.favorites,
                      stream: TheCatalogPageViewModel.onFavoriteChanged,
                      builder: (context, snapshot) {
                        return Text('${snapshot.data.length}');
                      }),
                ),
              ],
            ),
            onPressed: () => TheCatalogPageViewModel.filterFavorite(
                !TheCatalogPageViewModel.favoriteFilter),
          ),
          _CategoryFilterButton(
            imagePath: UiConst.fruitsCategoryImagePath,
            titleValue: ApiConst.categoryFruitTitleValue,
          ),
          _CategoryFilterButton(
            imagePath: UiConst.meatCategoryImagePath,
            titleValue: ApiConst.categoryMeatTitleValue,
          ),
          _CategoryFilterButton(
            imagePath: UiConst.milkCategoryImagePath,
            titleValue: ApiConst.categoryMilkTitleValue,
          ),
        ],
      ),
    );
  }
}

///
class _CategoryFilterButton extends StatelessWidget {
  final String imagePath;
  final String titleValue;

  const _CategoryFilterButton({
    Key key,
    @required this.imagePath,
    @required this.titleValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _w = MediaQuery.of(context).size.width / 5 - 12;
    return StreamBuilder<List<String>>(
        initialData: TheCatalogPageViewModel.categoriesFilter,
        stream: TheCatalogPageViewModel.onCategoriesFilter,
        builder: (context, snapshot) {
          return IntrinsicWidth(
            child: Container(
              width: _w,
              child: Column(
                children: [
                  IconButton(
                      icon: ImageIcon(
                        AssetImage(imagePath),
                        color: snapshot.data.contains(titleValue)
                            ? Colors.blue
                            : Colors.black,
                      ),
                      onPressed: () => TheCatalogPageViewModel.filterByCategory(
                          titleValue,
                          !TheCatalogPageViewModel.categoriesFilter
                              .contains(titleValue))),
                  Text(
                    titleValue,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 10,
                      color: snapshot.data.contains(titleValue)
                          ? Colors.blue
                          : Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
