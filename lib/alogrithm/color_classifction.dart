// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';

// typedef BuilderFromImage = Widget Function(
//     BuildContext context, ImgDetails img);

// class ImgDetails {
//   final int? width;

//   final int? height;

//   final Color Function(int x, int y)? pixelColorAt;

//   final Color Function(Alignment alignment)? pixelColorAtAlignment;

//   final ui.Image? uiImage;

//   final ByteData? byteData;

//   bool get hasImage => uiImage != null;

//   ImgDetails({
//     this.width,
//     this.height,
//     this.uiImage,
//     this.byteData,
//     this.pixelColorAt,
//     this.pixelColorAtAlignment,
//   });
// }

// class ImagePixels extends StatefulWidget {
//   //
//   final ImageProvider? imageProvider;
//   final Color defaultColor;
//   final BuilderFromImage builder;

//   // ignore: use_key_in_widget_constructors
//   const ImagePixels({
//     required this.imageProvider,
//     this.defaultColor = Colors.grey,
//     required this.builder,
//   });
//   ImagePixels.container({
//     super.key,
//     required this.imageProvider,
//     this.defaultColor = Colors.grey,
//     Alignment colorAlignment = Alignment.topLeft,
//     Widget? child,
//   }) : builder = _color(colorAlignment, child, defaultColor);

//   static BuilderFromImage _color(
//     Alignment colorAlignment,
//     Widget? child,
//     Color defaultColor,
//   ) =>
//       (context, img) => Container(
//             color: img.hasImage
//                 ? img.pixelColorAtAlignment!(colorAlignment)
//                 : defaultColor,
//             child: child,
//           );

//   @override
//   // ignore: library_private_types_in_public_api
//   _ImagePixelsState createState() => _ImagePixelsState();
// }

// class _ImagePixelsState extends State<ImagePixels> {
//   //
//   ui.Image? image;
//   ByteData? byteData;
//   int? width;
//   int? height;

//   ImageProvider? get imageProvider => widget.imageProvider;

//   Color get defaultColor => widget.defaultColor;

//   @override
//   void initState() {
//     super.initState();
//     if (imageProvider == null) return;

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) _refreshImage();
//     });
//   }

//   @override
//   void didUpdateWidget(ImagePixels oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (imageProvider != oldWidget.imageProvider) _refreshImage();
//   }

//   void _refreshImage() {
//     // ignore: no_leading_underscores_for_local_identifiers
//     var _imageProvider = imageProvider;

//     if (_imageProvider == null) {
//       _toByteData(null);
//     }
//     //
//     else {
//       _GetImage(
//         imageProvider: _imageProvider,
//         loadCallback: _loadCallback,
//         buildContext: context,
//       ).run();
//     }
//   }

//   void _loadCallback(ui.Image image) {
//     if (mounted) {
//       setState(() {
//         _toByteData(image);
//       });
//     }
//   }

//   void _toByteData(ui.Image? image) {
//     //
//     if (image == null) {
//       this.image = null;
//       byteData = null;
//       width = null;
//       height = null;
//     }
//     //
//     else {
//       Future(() async {
//         this.image = image;
//         width = image.width;
//         height = image.height;
//         byteData = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
//         if (mounted) setState(() {});
//       });
//     }
//   }

//   /// Pixel coordinates
//   Color pixelColorAt(int x, int y) {
//     if (byteData == null ||
//         width == null ||
//         height == null ||
//         x < 0 ||
//         x >= width! ||
//         y < 0 ||
//         y >= height!)
//       // ignore: curly_braces_in_flow_control_structures
//       return defaultColor;
//     else {
//       var byteOffset = 4 * (x + (y * width!));
//       return _colorAtByteOffset(byteOffset);
//     }
//   }

//   /// Pixel coordinates: (-1, -1) → (1, 1).
//   Color pixelColorAtAlignment(Alignment? alignment) {
//     if (byteData == null ||
//         width == null ||
//         height == null ||
//         alignment == null ||
//         alignment.x < -1.0 ||
//         alignment.x > 1.0 ||
//         alignment.y < -1.0 ||
//         alignment.y > 1.0) return defaultColor;

//     Offset offset = alignment
//         .alongSize(Size(width!.toDouble() - 1.0, height!.toDouble() - 1.0));
//     return pixelColorAt(offset.dx.round(), offset.dy.round());
//   }

//   Color _colorAtByteOffset(int byteOffset) =>
//       Color(_rgbaToArgb(byteData!.getUint32(byteOffset)));

//   int _rgbaToArgb(int rgbaColor) {
//     int a = rgbaColor & 0xFF;
//     int rgb = rgbaColor >> 8;
//     return rgb + (a << 24);
//   }

//   @override
//   Widget build(BuildContext context) => widget.builder(
//         context,
//         ImgDetails(
//           width: width,
//           height: height,
//           uiImage: image,
//           byteData: byteData,
//           pixelColorAt: pixelColorAt,
//           pixelColorAtAlignment: pixelColorAtAlignment,
//         ),
//       );
// }

// class _GetImage {
//   _GetImage({
//     required this.imageProvider,
//     required this.loadCallback,
//     required this.buildContext,
//   });

//   final ImageProvider imageProvider;

//   final void Function(ui.Image) loadCallback;

//   final BuildContext buildContext;

//   Future<void> run() async {
//     ImageConfiguration imageConfiguration =
//         createLocalImageConfiguration(buildContext);

//     Object key = await imageProvider.obtainKey(imageConfiguration);

//     final ImageStreamCompleter? completer =
//         PaintingBinding.instance.imageCache.putIfAbsent(
//       key,
//       // ignore: deprecated_member_use, invalid_use_of_protected_member
//       () => imageProvider.load(key, _decoder),
//       onError: null,
//     );

//     if (completer != null) {
//       //
//       _ListenerManager listenerManager = _ListenerManager(loadCallback);

//       ImageListener onImage = listenerManager.onImage;
//       ImageErrorListener onError = listenerManager.onError;

//       ImageStreamListener listener = ImageStreamListener(
//         onImage,
//         onError: onError,
//         onChunk: null,
//       );

//       listenerManager.removeListener = () {
//         completer.removeListener(listener);
//       };

//       completer.addListener(listener);
//     }
//   }

//   Future<ui.Codec> _decoder(
//     Uint8List bytes, {
//     bool? allowUpscaling,
//     int? cacheWidth,
//     int? cacheHeight,
//   }) =>
//       // ignore: deprecated_member_use
//       PaintingBinding.instance.instantiateImageCodec(bytes,
//           cacheWidth: cacheWidth, cacheHeight: cacheHeight);
// }

// class _ListenerManager {
//   _ListenerManager(this.loadCallback);

//   late VoidCallback removeListener;

//   final void Function(ui.Image) loadCallback;

//   void onImage(ImageInfo image, bool synchronousCall) {
//     loadCallback(image.image);
//     removeListener();
//   }

//   void onError(dynamic exception, StackTrace? stackTrace) {
//     removeListener();
//   }
// }
