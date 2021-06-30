import 'package:pilll/analytics.dart';
import 'package:pilll/components/atoms/color.dart';
import 'package:pilll/components/atoms/font.dart';
import 'package:pilll/components/atoms/text_color.dart';
import 'package:pilll/inquiry/inquiry.dart';
import 'package:flutter/material.dart';

class _InheritedWidget extends InheritedWidget {
  _InheritedWidget({
    Key? key,
    required Widget child,
    required this.state,
  }) : super(key: key, child: child);

  final _UniversalErrorPageState state;

  @override
  bool updateShouldNotify(covariant _InheritedWidget oldWidget) {
    return false;
  }
}

class UniversalErrorPage extends StatefulWidget {
  final Object? error;
  final Widget? child;
  final VoidCallback? reload;

  const UniversalErrorPage({
    Key? key,
    required this.error,
    required this.child,
    required this.reload,
  }) : super(key: key);

  @override
  _UniversalErrorPageState createState() => _UniversalErrorPageState();
}

class _UniversalErrorPageState extends State<UniversalErrorPage> {
  Object? _error;
  showError(Object error) {
    setState(() {
      _error = error;
    });
  }

  Object? get error => _error ?? widget.error;

  @override
  Widget build(BuildContext context) {
    final child = this.widget.child;
    final error = this.error;
    return _InheritedWidget(
      state: this,
      child: Stack(
        children: [
          if (child != null) child,
          if (error != null)
            Scaffold(
              backgroundColor: PilllColors.background,
              body: Center(
                child: Container(
                  width: 300,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "images/universal_error.png",
                        width: 200,
                        height: 190,
                      ),
                      SizedBox(height: 25),
                      Text(error.toString(),
                          style: FontType.assisting.merge(TextColorStyle.main)),
                      SizedBox(height: 25),
                      TextButton.icon(
                        icon: const Icon(
                          Icons.refresh,
                          size: 20,
                        ),
                        label: Text("画面を再読み込み",
                            style:
                                FontType.assisting.merge(TextColorStyle.black)),
                        onPressed: () {
                          analytics.logEvent(name: "reload_button_pressed");
                          final reload = this.widget.reload;
                          if (reload != null) {
                            reload();
                          }
                        },
                      ),
                      TextButton.icon(
                        icon: const Icon(
                          Icons.mail,
                          size: 20,
                        ),
                        label: Text("解決しない場合はこちら",
                            style:
                                FontType.assisting.merge(TextColorStyle.black)),
                        onPressed: () {
                          analytics.logEvent(
                              name: "problem_unresolved_button_pressed");
                          inquiry();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
