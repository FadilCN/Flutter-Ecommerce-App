import 'package:flutter/material.dart';
import '../details.dart';
import 'list.dart';

class Box extends StatefulWidget {
  final String name;
  final String price;
  final String image;
  final String unit;
  final String cat;
  final int index;
  final VoidCallback? onFavoriteToggle;

  const Box({
    Key? key,
    required this.name,
    required this.price,
    required this.unit,
    required this.image,
    required this.cat,
    required this.index,
    this.onFavoriteToggle,
  }) : super(key: key);

  @override
  State<Box> createState() => _BoxState();
}

class _BoxState extends State<Box> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    final favItem = fav.firstWhere(
      (item) => item[0] == widget.name,
      orElse: () => [],
    );
    isFavorite = favItem.isNotEmpty && favItem.length > 5 && favItem[5] == 1;
  }

  void showBottomPopup(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(message, style: const TextStyle(color: Colors.green)),
        ),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  void _onAddTap(String name, int _index) {
    setState(() {
      int index = cart.indexWhere((item) => item[0] == name);

      if (index == -1) {
        cart.add([...items[_index], 1]);
        showBottomPopup(context, '$name added to cart');
      } else {
        cart[index][5] += 1;
        showBottomPopup(context, '$name quantity increased');
      }
    });
  }

  void _toggleFavorite() {
    setState(() {
      final existingIndex = fav.indexWhere((item) => item[0] == widget.name);

      if (isFavorite) {
        if (existingIndex != -1) fav.removeAt(existingIndex);
        isFavorite = false;
        showBottomPopup(context, '${widget.name} removed from favorites');
      } else {
        if (existingIndex == -1) {
          final item = [...items[widget.index]];
          if (item.length <= 5) {
            item.add(1); // Add 1 as favorite
          } else {
            item[5] = 1;
          }
          fav.add(item);
        } else {
          fav[existingIndex][5] = 1;
        }
        isFavorite = true;
        showBottomPopup(context, '${widget.name} added to favorites');
      }

      widget.onFavoriteToggle?.call(); // Refresh UI if callback is provided
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xffEFEFEF),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(
                            name: widget.name,
                            cat: widget.cat,
                            price: widget.price,
                            image: widget.image,
                            keyy: widget.index,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.green[100],
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "\$${widget.price}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, color: Colors.white),
                        onPressed: () => _onAddTap(widget.name, widget.index),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: const Size(35, 35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: _toggleFavorite,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
