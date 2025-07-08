
import 'package:flutter/material.dart';
import 'util/list.dart';

import 'util/box_cont.dart';

class Fav extends StatefulWidget {
  @override
  State<Fav> createState() => _FavState();
}

class _FavState extends State<Fav> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "Favorites",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
            ),
          ),
          SizedBox(height: 10),
          fav.isEmpty
              ? Container(
                height: 700,
                margin: EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                alignment: Alignment.center,
                child: Text(
                  "You have no favorite items",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
              : Container(
                height: 700,
                margin: EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: fav.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 3 / 4,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final favItem = fav[index];
                    final realIndex = items.indexWhere(
                      (item) => item[0] == favItem[0],
                    );

                    return Box(
                      name: favItem[0],
                      price: favItem[3],
                      image: favItem[2],
                      unit: favItem[4],
                      cat: favItem[1],
                      index: realIndex,
                      onFavoriteToggle: () => setState(() {}),
                    );
                  },
                ),
              ),
        ],
      ),
    );
  }
}