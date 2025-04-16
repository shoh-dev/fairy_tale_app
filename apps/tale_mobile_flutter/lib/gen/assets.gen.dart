/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsStaticGen {
  const $AssetsStaticGen();

  /// File path: assets/static/bg.jpg
  AssetGenImage get bg => const AssetGenImage('assets/static/bg.jpg');

  /// File path: assets/static/bg1.jpg
  AssetGenImage get bg1 => const AssetGenImage('assets/static/bg1.jpg');

  /// File path: assets/static/bg10.jpg
  AssetGenImage get bg10 => const AssetGenImage('assets/static/bg10.jpg');

  /// File path: assets/static/bg11.jpg
  AssetGenImage get bg11 => const AssetGenImage('assets/static/bg11.jpg');

  /// File path: assets/static/bg12.jpg
  AssetGenImage get bg12 => const AssetGenImage('assets/static/bg12.jpg');

  /// File path: assets/static/bg13.jpg
  AssetGenImage get bg13 => const AssetGenImage('assets/static/bg13.jpg');

  /// File path: assets/static/bg14.jpg
  AssetGenImage get bg14 => const AssetGenImage('assets/static/bg14.jpg');

  /// File path: assets/static/bg2.jpg
  AssetGenImage get bg2 => const AssetGenImage('assets/static/bg2.jpg');

  /// File path: assets/static/bg3.jpg
  AssetGenImage get bg3 => const AssetGenImage('assets/static/bg3.jpg');

  /// File path: assets/static/bg4.jpg
  AssetGenImage get bg4 => const AssetGenImage('assets/static/bg4.jpg');

  /// File path: assets/static/bg5.jpg
  AssetGenImage get bg5 => const AssetGenImage('assets/static/bg5.jpg');

  /// File path: assets/static/bg6.jpg
  AssetGenImage get bg6 => const AssetGenImage('assets/static/bg6.jpg');

  /// File path: assets/static/bg7.jpg
  AssetGenImage get bg7 => const AssetGenImage('assets/static/bg7.jpg');

  /// File path: assets/static/bg8.jpg
  AssetGenImage get bg8 => const AssetGenImage('assets/static/bg8.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [
    bg,
    bg1,
    bg10,
    bg11,
    bg12,
    bg13,
    bg14,
    bg2,
    bg3,
    bg4,
    bg5,
    bg6,
    bg7,
    bg8,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsStaticGen static = $AssetsStaticGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
