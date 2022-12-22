import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../model/product_model.dart';

class ImageGallery extends StatefulWidget {
  final List<Images> images;

  const ImageGallery({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  int currentPosition = 0;
  late PageController controller;
  PhotoViewController photoController = PhotoViewController();
  ScrollController controllerBottom = ScrollController();

  @override
  void initState() {
    controller = PageController();
    controllerBottom = ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Dismissible(
      key: const Key('key'),
      onUpdate: (_) {
        Navigator.pop(
          context,
        );
      },
      direction: DismissDirection.down,
      onDismissed: (_) => Navigator.pop(
        context,
      ),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ))
          ],
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text(
            "image View",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: false,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Center(
              child: Text(
                "${currentPosition + 1} of ${widget.images.length}",
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(
                  color: Colors.white,
                  child: PhotoViewGallery.builder(
                    onPageChanged: (int pos) {
                      controllerBottom.animateTo((width * 0.2 * pos),
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear);
                      setState(() {
                        currentPosition = pos;
                      });
                    },
                    pageController: controller,
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    scrollPhysics: const PageScrollPhysics(),
                    builder: (BuildContext context, int index) {
                      return PhotoViewGalleryPageOptions(
                        tightMode: false,
                        scaleStateCycle: (actual) {
                          if (actual == PhotoViewScaleState.initial) {
                            return defaultScaleStateCycle(
                                PhotoViewScaleState.covering);
                          } else {
                            return defaultScaleStateCycle(
                                PhotoViewScaleState.originalSize);
                          }
                        },
                        maxScale: PhotoViewComputedScale.contained * 2.5,
                        minScale: PhotoViewComputedScale.contained,
                        imageProvider: CachedNetworkImageProvider(
                            widget.images[index].large),
                        initialScale: PhotoViewComputedScale.contained,
                        heroAttributes: const PhotoViewHeroAttributes(
                            tag: "photo", transitionOnUserGestures: true),
                      );
                    },
                    itemCount: widget.images.length,
                    loadingBuilder: (context, event) => const Center(
                      child: SizedBox(
                          width: 20.0,
                          height: 20.0,
                          child: CircularProgressIndicator()),
                    ),
                  )),
            ),
            SizedBox(
              height: height * 0.13,
              child: ListView.builder(
                controller: controllerBottom,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: widget.images.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      currentPosition = index;
                      setState(() {});
                      controller.jumpToPage(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: currentPosition == index
                                ? Border.all(color: Colors.blueAccent)
                                : null),
                        child: Hero(
                          tag: widget.images[index].small,
                          child: CachedNetworkImage(
                            fadeOutDuration: const Duration(milliseconds: 0),
                            placeholderFadeInDuration:
                                const Duration(seconds: 0),
                            imageUrl: widget.images[index].extraSmall,
                          ),
                        ),

                        // CachedNetworkImage(
                        // fadeOutDuration: Duration(milliseconds: 0),
                        // placeholderFadeInDuration: const Duration(seconds: 0),
                        //   imageUrl: widget.images[index].high,
                        // ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
