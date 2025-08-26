import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu_app/custom_theme.dart';
import 'package:menu_app/models/mealsmodel.dart';
import 'package:menu_app/service/basedb.dart';

class GridviewCards extends StatefulWidget {
  const GridviewCards({super.key, required this.index, required this.list});
  final int index;
  final List<MealModel> list;
  @override
  State<GridviewCards> createState() => _GridviewCardsState();
}

class _GridviewCardsState extends State<GridviewCards> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final addedItem = await Navigator.pushNamed(
          context,
          '/mealScreen',
          arguments: widget.list[widget.index],
        );

        if (addedItem != null) {
          setState(() {}); // rebuild GridviewCards if needed
          // Optional: notify parent to rebuild
        }
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          DarkColors.secondaryBackGround,
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        padding: WidgetStateProperty.all(EdgeInsets.all(0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: double.infinity,
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                widget.list[widget.index].strMealThumb!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.fromLTRB(10, 5, 10, 0),
            child: Column(
              children: [
                Text(
                  widget.list[widget.index].strMeal,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.robotoCondensed(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  widget.list[widget.index].strInstructions!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.robotoCondensed(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                RatingBarIndicator(
                  rating: Store
                      .meals[widget.index]
                      .rating!, // your random or stored rating
                  itemBuilder: (context, index) =>
                      Icon(Icons.star, color: Colors.amber),
                  itemCount: 5,
                  itemSize: 20.0,
                  direction: Axis.horizontal,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
