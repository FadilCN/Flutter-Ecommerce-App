import 'package:flutter/material.dart';

class QuantityBox extends StatelessWidget {
  final String name;
  final String price;
  final String image;
  final int qty;
  final String unit;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantityBox({
    Key? key,
    required this.name,
    required this.price,
    required this.image,
    required this.qty,
    required this.unit,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // Image
          Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                image,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Expanded for name, price, qty controls
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and Price in one row with space between
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right:10.0),
                      child: Text(
                          '\$$price', 
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Quantity buttons
                Row(
                  children: [
                    IconButton(
                      onPressed: onDecrement,
                      icon: const Icon(Icons.remove),
                      color: Colors.white,
                      iconSize: 10,
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: const Size(25, 25),
                        maximumSize: const Size(25, 25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    
                    ),

                    SizedBox(width: 5),
                    Text(
                      qty.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5),

                    IconButton(
                      onPressed: onIncrement,
                      icon: const Icon(Icons.add),
                      color: Colors.white,
                      iconSize: 10,
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: const Size(25, 25),
                        maximumSize: const Size(25, 25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
