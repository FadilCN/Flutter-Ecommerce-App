import 'package:flutter/material.dart';
import 'util/list.dart';

import 'util/box_cont.dart';

class Details extends StatefulWidget {
  Details({
    Key? key,
    required this.name,
    required this.price,
    required this.cat,
    required this.image,
    required this.keyy,
  }) : super(key: key);

  final String name;
  String price;
  String image;
  String cat;
  int keyy;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int rate = 3;
  int qty = 1;
  bool isFavorite = false;
  @override
  void initState() {
    super.initState();
    isFavorite = fav.any((item) => item[0] == widget.name);
  }

  void toggleFavorite() {
    setState(() {
      if (isFavorite) {
        fav.removeWhere((item) => item[0] == widget.name);
        showBottomPopup(context, '${widget.name} removed from favourites');
      } else {
        fav.add(items[widget.keyy]);
        showBottomPopup(context, '${widget.name} added to favourites');
      }
      isFavorite = !isFavorite;
    });
  }

  void showBottomPopup(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(message, style: TextStyle(color: Colors.green)),
        ),
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
        backgroundColor: Colors.white,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    final _items = items.where((item) => item[1] == widget.cat).toList();

    // Safely parse price string to int with fallback to 0
    double priceDouble = double.tryParse(widget.price) ?? 0.0;

    // Calculate total price as double * qty
    double net = priceDouble * qty;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back button with ripple and pop navigation
                  Material(
                    color: Color(0xffEFEFEF),
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        height: 35,
                        width: 35,
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                  Text(
                    "Details",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                  // Favorite button with ripple effect (empty onTap for now)
                  Material(
                    color: Color(0xffEFEFEF),
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: toggleFavorite,
                      child: SizedBox(
                        height: 35,
                        width: 35,
                        child: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: isFavorite ? Colors.red : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.image),
                  alignment: Alignment.center,
                ),
              ),
              height: 200,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25, left: 25, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.cat,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            widget.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          // Minus button
                          Material(
                            color: Color(0xffEFEFEF),
                            borderRadius: BorderRadius.circular(8),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                setState(() {
                                  if (qty > 1) qty--;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.all(4),
                                child: Icon(Icons.remove, size: 15),
                              ),
                            ),
                          ),

                          SizedBox(width: 8),

                          Container(
                            height: 25,
                            width: 45,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              qty.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                              ),
                            ),
                          ),

                          SizedBox(width: 8),

                          // Plus button
                          Material(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                setState(() {
                                  qty++;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.all(4),
                                child: Icon(
                                  Icons.add,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      for (int i = 0; i < rate; i++)
                        Icon(Icons.star, color: Colors.orange, size: 18),
                      for (int j = 0; j < 5 - rate; j++)
                        Icon(Icons.star, color: Colors.grey, size: 18),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Product Details",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet auctor turpis, et viverra augue. Fusce rhoncus justo justo, eget pulvinar arcu luctus ac. Praesent nunc urna, tincidunt non justo mollis, blandit efficitur quam. Donec sagittis, elit sit amet ullamcorper ultrices, erat felis tincidunt sem, at feugiat justo dolor vel odio. Proin eget auctor nibh. Donec bibendum justo nec fermentum luctus.",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Similar Products",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: AspectRatio(
                            aspectRatio: 3 / 4,
                            child: Box(
                              name: _items[index][0],
                              price: _items[index][3],
                              image: _items[index][2],
                              unit: _items[index][4],
                              cat: _items[index][1],
                              index: index,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Material(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        elevation: 10,
        child: Container(
          height: 65.0,
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Price",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 1),
                    Text(
                      '\$${net.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                // Add to Cart button with ripple effect
                Material(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      setState(() {
                        int index = cart.indexWhere(
                          (item) => item[0] == widget.name,
                        );

                        if (index == -1) {
                          // Add new item with qty
                          cart.add([...items[widget.keyy], qty]);
                          qty = 1;
                          showBottomPopup(
                            context,
                            '${widget.name} added to cart',
                          );
                        } else {
                          // Update quantity
                          cart[index][5] = cart[index][5] + qty;

                          showBottomPopup(
                            context,
                            '${widget.name} quantity updated',
                          );
                        }
                      });
                    },

                    child: Container(
                      height: 40,
                      width: 150,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.shopping_basket_outlined,
                            size: 20,
                            color: Colors.white,
                          ),
                          Text(
                            "Add to Cart",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
