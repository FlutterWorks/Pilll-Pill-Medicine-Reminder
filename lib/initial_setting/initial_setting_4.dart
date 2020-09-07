import 'package:Pilll/main/application/router.dart';
import 'package:Pilll/model/auth_user.dart';
import 'package:Pilll/model/setting.dart';
import 'package:Pilll/theme/color.dart';
import 'package:Pilll/theme/font.dart';
import 'package:Pilll/theme/text_color.dart';
import 'package:Pilll/util/shared_preference/toolbar/picker_toolbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InitialSetting4 extends StatefulWidget {
  @override
  _InitialSetting4State createState() => _InitialSetting4State();
}

class _InitialSetting4State extends State<InitialSetting4> {
  @override
  void initState() {
    var model = Provider.of<AuthUser>(context, listen: false).user.setting;
    if (_notYetSetTime(model)) {
      model.hour = 22;
      model.minute = 0;
    }
    super.initState();
  }

  bool _notYetSetTime(Setting model) {
    return model.minute == null || model.hour == null;
  }

  DateTime _dateTime(BuildContext context) {
    var model = Provider.of<AuthUser>(context, listen: false).user.setting;
    var t = DateTime.now().toLocal();
    return DateTime(t.year, t.month, t.day, model.hour, model.minute, t.second,
        t.millisecond, t.microsecond);
  }

  Widget _time(BuildContext context) {
    var formatter = NumberFormat("00");
    var dateTime = _dateTime(context);
    return Text(
      formatter.format(dateTime.hour) + ":" + formatter.format(dateTime.minute),
      style: FontType.largeNumber.merge(
        TextStyle(
          decoration: TextDecoration.underline,
          color: TextColor.black,
        ),
      ),
    );
  }

  void _showDurationModalSheet(BuildContext context) {
    var model = Provider.of<AuthUser>(context, listen: false).user.setting;
    var selectedHour = _dateTime(context).hour;
    var selectedMinute = _dateTime(context).minute;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            PickerToolbar(
              done: (() {
                setState(() {
                  model.hour = selectedHour;
                  model.minute = selectedMinute;
                  Navigator.pop(context);
                });
              }),
              cancel: (() => Navigator.pop(context)),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CupertinoDatePicker(
                    use24hFormat: true,
                    minuteInterval: 10,
                    initialDateTime: _dateTime(context),
                    mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: (DateTime value) {
                      selectedHour = value.hour;
                      selectedMinute = value.minute;
                    },
                  )),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PilllColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "4/4",
          style: TextStyle(color: TextColor.black),
        ),
        backgroundColor: PilllColors.background,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 24),
              Text(
                "ピルの飲み忘れ通知",
                style: FontType.title.merge(TextColorStyle.standard),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              Container(
                height: 77,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("通知時刻"),
                    GestureDetector(
                      onTap: () {
                        _showDurationModalSheet(context);
                      },
                      child: _time(context),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Wrap(
                direction: Axis.vertical,
                spacing: 8,
                children: <Widget>[
                  RaisedButton(
                    child: Text(
                      "設定",
                    ),
                    onPressed: () {
                      var model = Provider.of<AuthUser>(context, listen: false)
                          .user
                          .setting;
                      model.isOnReminder = true;
                      model
                          .register()
                          .then((_) => Router.endInitialSetting(context));
                    },
                  ),
                  FlatButton(
                    child: Text("スキップ"),
                    textColor: TextColor.gray,
                    onPressed: () {
                      var model = Provider.of<AuthUser>(context, listen: false)
                          .user
                          .setting;
                      model.isOnReminder = false;
                      model
                          .register()
                          .then((_) => Router.endInitialSetting(context));
                    },
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
