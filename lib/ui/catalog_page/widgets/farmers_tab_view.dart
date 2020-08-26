import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class FarmersTabView extends StatelessWidget {

  const FarmersTabView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('empty_content'.tr())),
    );
  }
}
