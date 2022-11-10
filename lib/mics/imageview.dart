import 'package:lostfoundapp/mics/packages.dart';

class ImageNetworkViewer extends StatefulWidget {
  final String mediaURl;
  const ImageNetworkViewer({super.key, required this.mediaURl});

  @override
  State<ImageNetworkViewer> createState() => _ImageNetworkViewerState();
}

class _ImageNetworkViewerState extends State<ImageNetworkViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorblack,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InteractiveViewer(
            clipBehavior: Clip.none,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                widget.mediaURl,
                fit: BoxFit.cover,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  return child;
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return const SizedBox(
                      height: 70,
                      width: 70,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
