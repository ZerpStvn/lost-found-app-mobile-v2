import 'dart:io' as io;
import 'package:lostfoundapp/mics/packages.dart';

class ListImages extends StatefulWidget {
  final List<XFile> images;
  const ListImages({
    super.key,
    required this.images,
  });

  @override
  State<ListImages> createState() => _ListImagesState();
}

class _ListImagesState extends State<ListImages> {
  final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                onPressed: widget.images.length <= 2 ? selectimage : null,
                child: const TextViewPoppins(
                    title: "Select another image",
                    fontsize: 14,
                    fontcolor: colorWhite)),
          ),
          const SizedBox(
            height: 14,
          ),
          widget.images.isEmpty
              ? Container()
              : Flexible(
                  fit: FlexFit.loose,
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.images.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 5,
                              crossAxisCount: 2,
                              mainAxisSpacing: 5),
                      itemBuilder: (context, index) {
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.file(io.File(widget.images[index].path),
                                fit: BoxFit.cover),
                            Positioned(
                              top: 13,
                              right: 15,
                              child: GestureDetector(
                                onTap: () {
                                  removeimage(index);
                                },
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromARGB(111, 83, 83, 83)),
                                  child: const Center(
                                    child: TextViewPoppins(
                                        title: "X",
                                        fontsize: 10,
                                        fontcolor: colorWhite),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      }))
        ],
      ),
    );
  }

  void selectimage() async {
    final List<XFile> selectedimage = await imagePicker.pickMultiImage();

    setState(() {
      widget.images.addAll(selectedimage);
    });
  }

  void removeimage(int index) async {
    if (widget.images.isNotEmpty) {
      setState(() {
        widget.images.removeAt(index);
      });
    }
  }
}
