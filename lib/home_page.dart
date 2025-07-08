import 'package:flutter/material.dart';
import 'util/box_cont.dart';
import 'util/list.dart';
import 'util/pagev.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _items = items;

  void _onCategoryTap(String cat) {
    setState(() {
      if (cat == "null") {
        _items = items;
      } else {
        _items = items.where((item) => item[1] == cat).toList();
      }
    });
  }

  Widget _categoryButton(String iconUrl, String label, var cat) {
    return Container(
      height: 100,
      width: 85,
      child: Column(
        children: [
          Material(
            color: Colors.green[100],
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => _onCategoryTap(cat),
              child: Container(
                height: 70,
                width: 70,
                padding: const EdgeInsets.all(10.0),
                child: Image.network(iconUrl, fit: BoxFit.fill),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 110, 110, 110),
            ),
          ),
        ],
      ),
    );
  }

  void _showNotificationsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return Container(
          height: 300,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Notifications",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Center(
                  child: Text(
                    "No notifications",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Location and Notification Row
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Location",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 114, 114, 114),
                          ),
                        ),
                        SizedBox(height: 3),
                        Row(
                          children: [
                            Icon(
                              Icons.location_pin,
                              size: 18,
                              color: Colors.green,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "New York, USA",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Notification icon with onTap
                    GestureDetector(
                      onTap: _showNotificationsSheet,
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffEFEFEF),
                        ),
                        child: Icon(Icons.notifications),
                      ),
                    ),
                  ],
                ),
              ),

              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffEFEFEF),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  height: 50,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(Icons.search),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search for Products',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                          ),
                        ),
                      ),
                      Icon(Icons.tune),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 25),

              // PageView banner
              Container(
                height: 200,
                child: PageView(children: [Pagev(), Pagev()]),
              ),

              // Categories Title
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Categories",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "See all",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),

              // Category Buttons
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    _categoryButton(
                      "https://img.icons8.com/?size=100&id=nlNXbEKJEHGS&format=png&color=000000",
                      "All Items",
                      "null",
                    ),
                    _categoryButton(
                      "https://img.icons8.com/?size=100&id=GhHf1K78EMXj&format=png&color=000000",
                      "Vegetables",
                      "Vegetable",
                    ),
                    _categoryButton(
                      "https://img.icons8.com/?size=100&id=xa6TiAmEtO9D&format=png&color=000000",
                      "Fruits",
                      "Fruit",
                    ),
                    _categoryButton(
                      "https://img.icons8.com/?size=100&id=1vzbQymCwtpJ&format=png&color=000000",
                      "Meat",
                      "Meat",
                    ),
                    _categoryButton(
                      "https://img.icons8.com/?size=100&id=zODwN9sQhg00&format=png&color=000000",
                      "Fish",
                      "Fish",
                    ),
                    _categoryButton(
                      "https://img.icons8.com/?size=100&id=yuHrQ6jdmuBB&format=png&color=000000",
                      "Groceries",
                      "Grocery",
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              // Popular Title
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "See all",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),

              // Grid of items
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 3 / 4,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Box(
                      name: _items[index][0],
                      price: _items[index][3],
                      image: _items[index][2],
                      unit: _items[index][4],
                      cat: _items[index][1],
                      index: index,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
