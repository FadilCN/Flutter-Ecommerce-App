import 'package:flutter/material.dart';
import 'util/list.dart';
import 'util/qtybox.dart';


class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  double getTotalPrice() {
    double total = 0.0;
    for (var item in cart) {
      double price = double.parse(item[3]);
      int qty = item[5];
      total += price * qty;
    }
    return total;
  }

  int tapCount = 0;

  @override
  Widget build(BuildContext context) {
    double net = getTotalPrice(); // Calculate total price

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              "Cart",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
            ),
            SizedBox(height: 10),
            Expanded(
              child:
                  cart.isEmpty
                      ? Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Your cart is empty",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                      : Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListView.builder(
                          itemCount: cart.length,
                          itemBuilder: (context, index) {
                            double price = double.parse(cart[index][3]);
                            int qty = cart[index][5];
                            double netPrice = price * qty;

                            if (cart[index].length <= 6 ||
                                cart[index][6] != netPrice) {
                              if (cart[index].length > 6) {
                                cart[index][6] = netPrice;
                              } else {
                                cart[index].add(netPrice);
                              }
                            }

                            return QuantityBox(
                              name: cart[index][0],
                              price: netPrice.toStringAsFixed(2),
                              image: cart[index][2],
                              unit: cart[index][4],
                              qty: qty,
                              onIncrement: () {
                                setState(() {
                                  cart[index][5]++;
                                  double price = double.parse(cart[index][3]);
                                  int qty = cart[index][5];
                                  double netPrice = price * qty;
                                  cart[index][6] = netPrice;
                                });
                              },
                              onDecrement: () {
                                setState(() {
                                  cart[index][5]--;
                                  if (cart[index][5] == 0) {
                                    cart.removeAt(index);
                                  } else {
                                    double price = double.parse(cart[index][3]);
                                    int qty = cart[index][5];
                                    double netPrice = price * qty;
                                    cart[index][6] = netPrice;
                                  }
                                });
                              },
                            );
                          },
                        ),
                      ),
            ),

            // Bottom total price & checkout button
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              height: 80,
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
                  Material(
                    color: cart.isEmpty ? Colors.grey : Colors.green,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap:
                          cart.isEmpty
                              ? null
                              : () {
                                setState(() {
                                  cart.clear();
                                  tapCount++;
                                  tapList.add(tapCount);
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Thank you for your purchase!",
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                );
                              },
                      child: Opacity(
                        opacity: cart.isEmpty ? 0.5 : 1.0,
                        child: Container(
                          height: 100,
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
                                "CheckOut",
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


