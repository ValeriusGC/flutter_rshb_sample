import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:frshbsample/core/api/remote_provider.dart';
import 'package:frshbsample/core/common/funcs.dart';
import 'package:frshbsample/core/domain/product.dart';
import 'package:frshbsample/core/model/catalog_data.dart';
import 'package:frshbsample/core/model/model.dart';
import 'package:frshbsample/sl.dart';
import 'package:frshbsample/ui/ui_service.dart';

import '../catalog_page_view_model.dart';

const imageHeight = 100.0;
const imageWidth = 200.0;

class ProductsTabView extends StatelessWidget {
  final String text;

  const ProductsTabView({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _Items(
        model: TheCatalogPageViewModel,
      ),
    );
  }
}

class _Items extends StatelessWidget {
  final CatalogPageViewModel model;
  final int index;

  const _Items({Key key, this.model, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ModelState<CatalogData>>(
        initialData: model.value,
        stream: model.onDataChanged,
        builder: (context, snapshot) {
          final d = snapshot.data;
          if (d.isLoading) {
            return UiConst.centerCircularProgressIndicator;
          }
          if (d.data.products.length == 0 || model.affectedData.length == 0) {
            return Center(child: Text('empty_catalog_title'.tr()));
          }

          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1 / 2,
            children: List<_Item>.generate(
              model.affectedData.length,
              (idx) => _Item(
                index: idx,
                model: model,
                product: model.affectedData[idx],
              ),
            ),
          );
        });
  }
}

class _Item extends StatelessWidget {
  final CatalogPageViewModel model;
  final Product product;
  final int index;

  const _Item({Key key, this.model, this.index, this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Card(
      idx: index,
      model: model,
      product: product,
    );
  }
}

class _Card extends StatelessWidget {
  final int idx;
  final CatalogPageViewModel model;
  final Product product;

  const _Card({Key key, this.idx, this.model, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rating = 'rating'.plural(product.ratingCount);
    return GestureDetector(
      onTap: () => model.loadDetail(product),
      child: Container(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(UiConst.stdPaddingSize),
            ),
            side: BorderSide(width: 1, color: Colors.grey),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(UiConst.stdPaddingSize)),
                    child: StreamBuilder<Map<int, Image>>(
                        initialData: model.images,
                        stream: model.onImageLoaded,
                        builder: (context, snapshot) {
                          final d = snapshot.data.containsKey(product.id);
                          return d
                              ? Image(
                                  image: snapshot.data[product.id].image,
                                  fit: BoxFit.fitWidth,
                                  height: imageHeight,
                                  width: imageWidth,
                                )
                              : Image.asset(
                                  UiConst.comingSoonImagePath,
                                  fit: BoxFit.fitWidth,
                                  height: imageHeight,
                                  width: imageWidth,
                                );
                        }),
                  ),
                  Positioned(
                    top: 0,
                    right: -20,
                    child: RawMaterialButton(
                      child: GestureDetector(
                        onTap: () => model.markFavorite(
                            product.id, !model.favorites.contains(product.id)),
                        child: StreamBuilder<List<int>>(
                            initialData: model.favorites,
                            stream: model.onFavoriteChanged,
                            builder: (context, snapshot) {
                              final d = snapshot.data.contains(product.id);
                              return Icon(
                                d ? Icons.favorite : Icons.favorite_border,
                                color: Colors.blueAccent,
                              );
                            }),
                      ),
                      shape: CircleBorder(
                        side: BorderSide(width: 1, color: Colors.grey),
                      ),
                      fillColor: Colors.white,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(UiConst.stdPaddingSize),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        product.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Text(
                      ' / ${product.unit}',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: UiConst.stdPaddingSize,
                  right: UiConst.stdPaddingSize,
                  top: UiConst.dblPaddingSize,
                  bottom: UiConst.stdPaddingSize,
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(UiConst.stdPaddingSize),
                        color: product.totalRating > 3.9
                            ? Colors.green
                            : Colors.orange,
                      ),
                      padding: EdgeInsets.all(UiConst.stdPaddingSize),
                      child: Text('${product.totalRating}'),
                    ),
                    Text(' $rating',
                        style: TextStyle(fontWeight: FontWeight.w300)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(UiConst.stdPaddingSize),
                child: Text(product.shortDescription,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w300)),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.all(UiConst.stdPaddingSize),
                child: Text(
                  product.farmer.title,
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.all(UiConst.stdPaddingSize),
                child: Text(
                  '${product.price.toInt()} р',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
