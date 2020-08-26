import 'package:Pilll/main/record/pill_sheet_model.dart';
import 'package:Pilll/model/pill_sheet_type.dart';
import 'package:Pilll/settings/settings.dart';
import 'package:Pilll/theme/color.dart';
import 'package:Pilll/initial_setting/initial_setting.dart';
import 'package:Pilll/initial_setting/initial_setting_1.dart';
import 'package:Pilll/main/record/pill_sheet.dart';
import 'package:Pilll/main/record/record_taken_information.dart';
import 'package:Pilll/theme/text_color.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:Pilll/util/shared_preference/keys.dart';
import 'package:Pilll/util/shared_preference/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() {
  initializeDateFormatting('ja_JP');
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics analytics = FirebaseAnalytics();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<InitialSettingModel>(
          create: (_) => InitialSettingModel(),
        ),
        ChangeNotifierProvider<PillSheetModel>(
          create: (_) => MainPillSheetModel(PillSheetType.pillsheet_21),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
        theme: ThemeData(
          primaryColor: PilllColors.primary,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          accentColor: PilllColors.accent,
          buttonTheme: ButtonThemeData(
            minWidth: 180,
            height: 44,
            buttonColor: PilllColors.enable,
            disabledColor: PilllColors.disable,
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        home: Main(),
      ),
    );
  }
}

class Main extends StatefulWidget {
  Main({Key key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SharedPreferencesBuilder<bool>(
        preferenceKey: BoolKey.didEndInitialSetting,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          // TODO:
          // if (!snapshot.hasData) {
          //   return InitialSetting();
          // }
          // if (!snapshot.data) {
          //   return InitialSetting();
          // }
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              backgroundColor: PilllColors.background,
              appBar: AppBar(
                title: Text('Pilll'),
                backgroundColor: PilllColors.primary,
              ),
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 1, color: PilllColors.border)),
                ),
                child: Ink(
                  color: PilllColors.bottomBar,
                  child: SafeArea(
                    child: TabBar(
                      controller: _tabController,
                      labelColor: PilllColors.primary,
                      indicatorColor: Colors.transparent,
                      unselectedLabelColor: TextColor.gray,
                      tabs: <Tab>[
                        Tab(
                            text: "ピル",
                            icon: SvgPicture.asset("images/tab_icon_pill.svg",
                                color: _tabController.index == 0
                                    ? PilllColors.primary
                                    : TextColor.gray)),
                        Tab(
                            text: "2020/07",
                            icon: SvgPicture.asset(
                                "images/tab_icon_calendar.svg",
                                color: _tabController.index == 1
                                    ? PilllColors.primary
                                    : TextColor.gray)),
                        Tab(
                            text: "設定",
                            icon: SvgPicture.asset(
                                "images/tab_icon_setting.svg",
                                color: _tabController.index == 2
                                    ? PilllColors.primary
                                    : TextColor.gray)),
                      ],
                    ),
                  ),
                ),
              ),
              body: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  Settings(),
                  _recordView(),
                  _recordView(),
                  // Settings(),
                ],
              ),
            ),
          );
        });
  }

  Center _recordView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 60),
          RecordTakenInformation(),
          SizedBox(height: 24),
          PillSheet(),
          SizedBox(height: 24),
          Container(
            height: 44,
            width: 180,
            child: RaisedButton(
              child: Text("飲んだ"),
              color: PilllColors.primary,
              textColor: Colors.white,
              onPressed: () {},
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
