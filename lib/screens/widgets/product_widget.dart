import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/widgets/image_view.dart';
import '../../model/product_model.dart';


class ProductWidget extends StatefulWidget {
  const ProductWidget({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  final Product productModel;

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {

  int carouselIndex = 0;
  final CarouselController controller = CarouselController();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Opacity(
        opacity: widget.productModel.quantity == 0 ? 0.45 : 1,
        child: Column(
          children: [
            Expanded(
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>ImageGallery(images: widget.productModel.images, ),
                    ),
                  );
                },
                child:
                    CarouselSlider(
                      items: widget.productModel.images.length > 4
                          ? widget.productModel.images.sublist(0, 4).map(
                            (item) {
                          return Hero(
                            tag: item.small,
                            child: CachedNetworkImage(
                              fadeOutDuration: const Duration(milliseconds: 0),
                              placeholderFadeInDuration: const Duration(seconds: 0),
                              imageUrl: item.small,
                              fit: BoxFit.fill,
                              placeholder: (context, url) => Image.asset(
                                  'assets/images/product_placeholder.png'),
                              errorWidget: (context, url, error) =>
                                  Image.asset(
                                    'assets/images/product_placeholder.png',
                                  ),
                            ),
                          );
                        },
                      ).toList()
                          : widget.productModel.images.map(
                            (item) {
                          return Hero(
                            tag: item.small,
                            child: CachedNetworkImage(
                              fadeOutDuration: const Duration(milliseconds: 0),
                              placeholderFadeInDuration: const Duration(seconds: 0),
                              imageUrl: item.small,
                              fit: BoxFit.fill,

                            ),
                          );
                        },
                      ).toList(),
                      carouselController: controller,
                      options: CarouselOptions(
                        enableInfiniteScroll: false,
                        height: MediaQuery.of(context).size.height * 0.4,
                        viewportFraction: 1,
                        initialPage: carouselIndex,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index, reason) {
                          setState(
                                () {
                              carouselIndex = index;
                            },
                          );
                        },
                      ),
                    ),


              ),
            ),
            GestureDetector(
              onTap: () async {

              },
              child: Padding(
                padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.productModel.images.length == 1
                        ? const SizedBox()
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: widget.productModel.images.length < 4
                          ? widget.productModel.images
                          .asMap()
                          .entries
                          .map(
                            (entry) {
                          return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () =>
                                controller.animateToPage(entry.key),
                            child: Container(
                              width: carouselIndex == entry.key
                                  ? 8
                                  : 8,
                              height: carouselIndex == entry.key
                                  ? 8
                                  : 8,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 5.0),
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.grey),
                                shape: BoxShape.circle,
                                color: carouselIndex == entry.key
                                    ? Colors.blue
                                    : Colors.white,
                              ),
                            ),
                          );
                        },
                      ).toList()
                          : widget.productModel.images
                          .sublist(0, 4)
                          .asMap()
                          .entries
                          .map(
                            (entry) {
                          return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () =>
                                controller.animateToPage(entry.key),
                            child: Container(
                              width: carouselIndex == entry.key
                                  ? 8
                                  : 8,
                              height: carouselIndex == entry.key
                                  ? 8
                                  : 8,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 5.0),
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.grey),
                                shape: BoxShape.circle,
                                color: carouselIndex == entry.key
                                    ? Colors.blue
                                    : Colors.white,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                    widget.productModel.quantity == 0
                        ? Container(
                      height: 16,
                      padding: const EdgeInsets.all(2),
                      margin: const EdgeInsets.only(bottom: 4),
                      color: Colors.black,
                      child: const Text(
                        'Out of Stock',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                        : const SizedBox.shrink(),
                    widget.productModel.categories.isNotEmpty?
                    Text(
                    widget.productModel.categories.first.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ):const SizedBox.shrink(),
                    Text(
                     widget.productModel.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.productModel.discountedPrice == '0.0'
                            ? Text(
                          widget.productModel.price,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                            : Row(
                          children: [
                            Text(
                              widget.productModel.price,
                              style: const TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.lineThrough,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 2),
                              child: Text(
                                widget.productModel.discountedPrice,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 17, 147, 22),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),


                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
