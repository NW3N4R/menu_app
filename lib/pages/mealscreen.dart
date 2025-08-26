import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu_app/custom_theme.dart';
import 'package:menu_app/models/mealsmodel.dart';

class MealScreen extends StatefulWidget {
  const MealScreen({super.key});
  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  int itemCount = 1;
  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context)!.settings.arguments as MealModel;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2.2,
            child: ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [DarkColors.primaryBackground, Colors.transparent],
                  stops: [0.4, 1.0],
                ).createShader(rect);
              },
              blendMode: BlendMode.dstIn,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withAlpha(170),
                  BlendMode.darken,
                ),
                child: Image.network(meal.strMealThumb!, fit: BoxFit.cover),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.065),
                Text(
                  textAlign: TextAlign.center,
                  meal.strMeal,
                  style: GoogleFonts.fugazOne(
                    color: Colors.white,
                    fontSize: 38,
                  ),
                ),
                Center(
                  child: RatingBarIndicator(
                    rating: meal.rating!,
                    itemBuilder: (context, index) =>
                        Icon(Icons.star, color: Colors.amber),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        '${meal.strTags!}  ${meal.strArea!}  ${meal.strCategory!}',
                        maxLines: 3,
                        style: GoogleFonts.openSans(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Wrap(
                        spacing: 10,
                        runSpacing: 5,
                        children: meal.measures
                            .where((m) => m != null && m != '')
                            .map(
                              (ingredient) => Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: DarkColors.secondaryBackGround
                                      .withAlpha(70),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  ingredient!,
                                  style: GoogleFonts.faunaOne(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    meal.strInstructions!,
                    maxLines: 5,
                    style: GoogleFonts.faunaOne(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  '\$${meal.idMeal!}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.fugazOne(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: DarkColors.secondaryBackGround,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  itemCount++;
                                });
                              },
                              icon: Icon(Icons.add, color: Colors.white),
                            ),
                            Text(
                              itemCount.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (itemCount == 1) return;
                                  itemCount--;
                                });
                              },
                              icon: Icon(Icons.remove, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [DarkColors.primary, Colors.red],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                // your onPressed action
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 20,
                                ),
                                child: Center(
                                  child: Text(
                                    'Order Now',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 19,
                                    ),
                                  ),
                                ),
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
        ],
      ),
    );
  }
}
