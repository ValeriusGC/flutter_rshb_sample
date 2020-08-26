import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:frshbsample/core/api/remote_provider.dart';
import 'package:frshbsample/core/domain/product.dart';
import 'package:frshbsample/sl.dart';
import 'package:frshbsample/ui/ui_service.dart';
import 'package:rxdart/rxdart.dart';

final _onCollapsed = BehaviorSubject.seeded(true);

const _aspectRatio = 1.2;
const _topIndent = 24.0;

class DetailPage extends StatelessWidget {
  final Product product;

  const DetailPage({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: SafeArea(
        child: Container(
          child: Scaffold(
            body: Stack(
              children: [
                Column(
                  children: [
                    Column(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: _aspectRatio,
                          child: Image.asset(
                            product.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  top: _topIndent,
                  right: 0,
                  child: _FavButton(
                    product: product,
                  ),
                ),
                Positioned(
                  top: _topIndent,
                  left: 0,
                  child: _BackButton(),
                ),
                Positioned(
                  top: (MediaQuery.of(context).size.width / 1.2) - _topIndent,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(32.0),
                          topRight: Radius.circular(32.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            offset: const Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: UiConst.stdPaddingSize,
                        right: UiConst.stdPaddingSize,
                        top: UiConst.dblPaddingSize,
                      ),
                      child: _DetailList(
                        product: product,
                      ),
                    ),
                  ),
                ),
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

///
class _FavButton extends StatelessWidget {
  final Product product;

  const _FavButton({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: GestureDetector(
        onTap: () => TheCatalogPageViewModel.markFavorite(product.id,
            !TheCatalogPageViewModel.favorites.contains(product.id)),
        child: StreamBuilder<List<int>>(
            initialData: TheCatalogPageViewModel.favorites,
            stream: TheCatalogPageViewModel.onFavoriteChanged,
            builder: (context, snapshot) {
              final d = snapshot.data.contains(product.id);
              return Icon(
                d ? Icons.favorite : Icons.favorite_border,
                color: UiConst.brandMainColor,
              );
            }),
      ),
      shape: CircleBorder(
        side: BorderSide(width: 1, color: Colors.grey),
      ),
      fillColor: Colors.white,
      onPressed: () {},
    );
  }
}

///
class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(
          Icons.arrow_back,
          color: Colors.blueGrey,
        ),
      ),
      shape: CircleBorder(
        side: BorderSide(width: 1, color: Colors.grey),
      ),
      fillColor: Colors.white,
      onPressed: () => Navigator.pop(context),
    );
  }
}

///
class _DetailList extends StatelessWidget {
  final Product product;

  const _DetailList({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rating = 'rating'.plural(product.ratingCount);
    return SingleChildScrollView(
      child: StreamBuilder<bool>(
          initialData: _onCollapsed.value,
          stream: _onCollapsed,
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: UiConst.dblPaddingSize,
                    left: UiConst.stdPaddingSize,
                    right: UiConst.stdPaddingSize,
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          product.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      Text(
                        ' / ${product.unit}',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              fontWeight: FontWeight.w300,
                            ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: UiConst.dblPaddingSize,
                    left: UiConst.dblPaddingSize,
                    right: UiConst.dblPaddingSize,
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
                Padding(
                  padding: const EdgeInsets.only(
                    left: UiConst.dblPaddingSize,
                    right: UiConst.dblPaddingSize,
                    bottom: UiConst.stdPaddingSize,
                    top: UiConst.dblPaddingSize,
                  ),
                  child: Text(
                    '${product.price} \u20BD',
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.w800),
                  ),
                ),
                Text('${product.description}'),
                UiConst.standardVerticalSizedBox,
                ...<Widget>[
                  ...List.generate(
                    snapshot.data ? 2 : product.characteristics.length,
                    (i) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${product.characteristics[i][ApiConst.characteristicKey]}',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                  '${product.characteristics[i][ApiConst.characteristicValue]}'),
                            ],
                          ),
                          UiConst.minimalVerticalSizedBox,
                        ],
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: () => _onCollapsed.add(!_onCollapsed.value),
                    child: Row(
                      children: [
                        Text(
                          snapshot.data
                              ? 'show_characteristics'.tr()
                              : 'hide_characteristics'.tr(),
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          _onCollapsed.value
                              ? Icons.keyboard_arrow_right
                              : Icons.keyboard_arrow_up,
                          color: Colors.green,
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    ),
                  ),
                ],
              ],
            );
          }),
    );
  }
}
