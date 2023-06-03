// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:head_phone_ashissh/data.dart';
import 'package:head_phone_ashissh/reuseable_code/widgets.dart';

class AnimatedProductPage extends StatefulWidget {
  const AnimatedProductPage({super.key});

  @override
  State<AnimatedProductPage> createState() => _AnimatedProductPageState();
}

class _AnimatedProductPageState extends State<AnimatedProductPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _slideAnimationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _slideAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);
    _slideAnimation =
        Tween<Offset>(begin: Offset(0, -0.15), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _slideAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  int currentImageIndex = 0;
  final Product currentProduct = Product(
      title: "boAt Rockerz 450 with Upto 15 Hours Playback Bluetooth Headset",
      images: [blackVariation, beigeVariation, blueVariation],
      relatedProducts: relatedProducts,
      description: description,
      highlights: highlights,
      priceBefore: 300000,
      price: 199000,
      rating: 4.8);

  @override
  void dispose() {
    _slideAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: appbar(),
        body: Stack(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                  height: 350,
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      )),
                  child: AnimatedBuilder(
                    animation: _slideAnimationController,
                    child: Center(
                        child: AnimatedSwitcher(
                      duration: Duration(seconds: 2),
                      child: Image.asset(
                        currentProduct.images[currentImageIndex].images[0],
                        key: Key(currentImageIndex.toString()),
                      ),
                    )),
                    builder: (context, child) {
                      return SlideTransition(
                        position: _slideAnimation,
                        child: child,
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title
                      ProductTitle(title: currentProduct.title),

                      /// Price and Rating
                      PriceAndRatingRow(
                          previousPrice: currentProduct.priceBefore,
                          price: currentProduct.price,
                          rating: currentProduct.rating),

                      /// Colors Box
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 4),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        margin: EdgeInsets.only(top: 10),
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              " 3 Available Colors :  ",
                              textScaleFactor: 1.3,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: currentProduct.images.length,
                                  itemBuilder: ((context, index) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          currentImageIndex = index;
                                        });
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        padding: EdgeInsets.all(2),
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: currentProduct
                                                .images[index].color,
                                          ),
                                        ),
                                      ),
                                    );
                                  })),
                            ),
                          ],
                        ),
                      ),

                      /// Divider 1
                      DividerHeightTen(),

                      /// Description
                      Text(
                        currentProduct.description,
                        textScaleFactor: 1.2,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w400),
                      ),

                      /// Space
                      twentySizedBox(),

                      /// Divider
                      DividerHeightTen(),

                      /// Highlights
                      ProductHighlights(highlights: currentProduct.highlights),

                      /// Space
                      twentySizedBox(),

                      /// Horizontle Scrollable
                      RelatedItemsBox(
                          relatedProducts: currentProduct.relatedProducts),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),

            /// bottom sticky widget for add to cart and but now buttons
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.white24)]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            "Add To Card",
                            textScaleFactor: 1.5,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.orange,
                          child: Center(
                            child: Text(
                              "Buy Now",
                              textScaleFactor: 1.5,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ));
  }
}
