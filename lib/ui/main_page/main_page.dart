import 'package:flutter/material.dart';
import 'package:frshbsample/sl.dart';
import 'package:frshbsample/ui/ui_service.dart';
import 'package:easy_localization/easy_localization.dart';

const _logoSize = 64.0;

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
        color: brandMainBackgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                width: _logoSize,
                height: _logoSize,
              ),
              standardVerticalSizedBox,
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
