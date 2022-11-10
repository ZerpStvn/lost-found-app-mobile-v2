// ignore_for_file: file_names

import 'package:lostfoundapp/mics/packages.dart';

class NetWorkCacheImageView extends StatelessWidget {
  final Widget widget;
  final String photoURL;
  const NetWorkCacheImageView(this.photoURL, {super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      photoURL,
      fit: BoxFit.cover,
      color: const Color.fromARGB(141, 66, 73, 69),
      colorBlendMode: BlendMode.multiply,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        return child;
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return widget;
        }
      },
    );
  }
}
