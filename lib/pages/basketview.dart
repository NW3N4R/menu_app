import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu_app/custom_theme.dart';
import 'package:menu_app/models/currentbasket_model.dart';
import 'package:menu_app/pages/home.dart';

class Basketview extends StatefulWidget {
  const Basketview({super.key});

  @override
  State<Basketview> createState() => _BasketviewState();
}

class _BasketviewState extends State<Basketview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(scrolledUnderElevation: 0.0),
      body: currentItems.isEmpty
          ? nothingBasket()
          : ListView.builder(
              itemCount: currentItems.length,
              itemBuilder: (value, index) {
                final meal = currentItems[index].meal;
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Dismissible(
                    direction: DismissDirection.endToStart,
                    key: ValueKey(currentItems[index].id),
                    onDismissed: (direction) {
                      currentItems.removeAt(index);
                      basketCount.value = currentItems.length;
                      setState(() {
                        // isEmpty = currentItems.isEmpty;
                      });
                    },
                    background: Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      color: Colors.orange,
                      child: Icon(Icons.delete),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: DarkColors.secondaryBackGround,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(meal.strMealThumb!, height: 100),
                          SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    meal.strMeal,
                                    softWrap: true,
                                    style: GoogleFonts.fugazOne(
                                      color: Colors.white,
                                      fontSize: 24,
                                    ),
                                  ),
                                  Text(
                                    textAlign: TextAlign.end,
                                    '\$${meal.price.toString()}.99',
                                    softWrap: true,
                                    style: GoogleFonts.roboto(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(100),
        ),
        child: IconButton(onPressed: () {}, icon: Icon(Icons.shop)),
      ),
    );
  }
}

Widget nothingBasket() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.shopping_basket, size: 48, color: DarkColors.primary),
        Text(
          'Nothing in the Basket!',
          style: GoogleFonts.fugazOne(color: Colors.white, fontSize: 28),
        ),
      ],
    ),
  );
}
