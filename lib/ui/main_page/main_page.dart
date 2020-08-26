import 'package:flutter/material.dart';
import 'package:frshbsample/sl.dart';
import 'package:frshbsample/ui/ui_service.dart';
import 'package:easy_localization/easy_localization.dart';

const _logoSize = 64.0;

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    TheMainPageViewModel.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('main_title'.tr()),
      ),
      body: Container(
        color: UiConst.brandMainBackgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                width: _logoSize,
                height: _logoSize,
              ),
              UiConst.standardVerticalSizedBox,
              RaisedButton(
                child: StreamBuilder<int>(
                    initialData: TheMainPageViewModel.onTick.value,
                    stream: TheMainPageViewModel.onTick,
                    builder: (context, snapshot) {
                      return Text('${'load_catalog'.tr()}: ${snapshot.data}');
                    }),
                onPressed: () => TheMainPageViewModel.showCatalogPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
