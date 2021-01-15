part of logger_flutter;

class LogConsoleOnShake extends StatefulWidget {
  final Widget child;
  final bool dark;
  final bool enabled;
  final GlobalKey<NavigatorState> navigatorKey;

  LogConsoleOnShake({
    @required this.child,
    @required this.navigatorKey,
    this.dark,
    this.enabled = true,
  });

  @override
  _LogConsoleOnShakeState createState() =>
      _LogConsoleOnShakeState(navigatorKey);
}

class _LogConsoleOnShakeState extends State<LogConsoleOnShake> {
  ShakeDetector _detector;
  bool _open = false;
  final GlobalKey<NavigatorState> navigatorKey;

  _LogConsoleOnShakeState(this.navigatorKey);

  @override
  void initState() {
    super.initState();

    // if (widget.enabled) {
    //   assert(() {
    //     _init();
    //     return true;
    //   }());
    // } else {
    //   _init();
    // }
    if (widget.enabled) _init();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  _init() {
    _detector = ShakeDetector(onPhoneShake: _openLogConsole);
    _detector.startListening();
  }

  _openLogConsole() async {
    if (_open) return;

    _open = true;
    await LogConsole.openWithKey(navigatorKey, dark: widget.dark);
    _open = false;
  }

  @override
  void dispose() {
    _detector.stopListening();
    super.dispose();
  }
}
