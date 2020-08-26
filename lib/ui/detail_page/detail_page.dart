import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:frshbsample/core/domain/product.dart';
import 'package:frshbsample/ui/ui_service.dart';
import 'package:rxdart/rxdart.dart';

final double infoHeight = 364.0;

final onCollapsed = BehaviorSubject.seeded(true);

class DetailPage extends StatelessWidget {
  final Product product;

  const DetailPage({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        124.0;

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
                          aspectRatio: 1.2,
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
                  top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
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
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, top: 16),
                      child: SingleChildScrollView(
                        child: StreamBuilder<bool>(
                            initialData: onCollapsed.value,
                            stream: onCollapsed,
                            builder: (context, snapshot) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 32.0, left: 18, right: 16),
                                    child: Text(
                                      '${product.title}',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22,
                                        letterSpacing: 0.27,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        bottom: 8,
                                        top: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '${product.price}',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 22,
                                            letterSpacing: 0.27,
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                '4.3',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 22,
                                                  letterSpacing: 0.27,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.green[300],
                                                size: 24,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Text('${product.description}'),
                                  standardVerticalSizedBox,
                                  ...<Widget>[
                                    ...List.generate(
                                      snapshot.data
                                          ? 2
                                          : product.characteristics.length,
                                      (i) {
                                        return Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${product.characteristics[i]['title']}',
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                Text(
                                                    '${product.characteristics[i]['value']}'),
                                              ],
                                            ),
                                            minimalVerticalSizedBox,
                                          ],
                                        );
                                      },
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          snapshot.data ? 'показать' : 'скрыть',
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            onCollapsed.value
                                                ? Icons.keyboard_arrow_right
                                                : Icons.keyboard_arrow_up,
                                            color: Colors.green,
                                          ),
                                          onPressed: () => onCollapsed
                                              .add(!onCollapsed.value),
                                        ),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                    ),
                                  ],

//                              Expanded(
//                                child: StreamBuilder<bool>(
//                                    initialData: onCollapsed.value,
//                                    stream: onCollapsed,
//                                    builder: (context, snapshot) {
//                                      final d = snapshot.data;
//                                      return Column(
//                                        children: [
//                                          ...List.generate(
//                                            d
//                                                ? 2
//                                                : product
//                                                    .characteristics.length,
//                                            (i) {
//                                              return Row(
//                                                mainAxisAlignment:
//                                                    MainAxisAlignment
//                                                        .spaceBetween,
//                                                children: [
//                                                  Text(
//                                                      '${product.characteristics[i]['title']}'),
//                                                  Text(
//                                                      '${product.characteristics[i]['value']}'),
//                                                ],
//                                              );
//                                            },
//                                          ),
//                                          Row(
//                                            children: [
//                                              Text(d ? 'показать' : 'скрыть'),
//                                              IconButton(
//                                                icon: Icon(onCollapsed.value
//                                                    ? Icons.keyboard_arrow_right
//                                                    : Icons.keyboard_arrow_up),
//                                                onPressed: () => onCollapsed
//                                                    .add(!onCollapsed.value),
//                                              ),
//                                            ],
//                                            mainAxisAlignment: MainAxisAlignment.start,
//                                          ),
//                                        ],
//                                      );
//                                    }),
//                              ),
                                ],
                              );
                            }),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: SizedBox(
                    width: AppBar().preferredSize.height,
                    height: AppBar().preferredSize.height,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(
                            AppBar().preferredSize.height),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.red,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                )
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

//class _Item extends StatelessWidget {
//  final
//  @override
//  Widget build(BuildContext context) {
//    return Container();
//  }
//}
