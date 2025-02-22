abstract class Sizes {
  static final web = _WebSizes();
}

class _WebSizes {
  _WebSizes();

  final double kLayoutMaxWidth = 1400;
  // 1600; //1400 perfect fit
  final double kAppBarHeight = 80;
  final double kLayoutPadding = 16;
  final double kDefaultSpace = 16;

  double get fieldWidth => kLayoutMaxWidth / 5;
}
