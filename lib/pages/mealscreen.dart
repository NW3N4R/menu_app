import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu_app/custom_theme.dart';
import 'package:menu_app/models/currentbasket_model.dart';
import 'package:menu_app/models/mealsmodel.dart';
import 'package:menu_app/pages/home.dart';

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
    final int price = itemCount * int.parse(meal.price!);
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Row(
          children: [
            Spacer(),
            RichText(
              text: TextSpan(
                text: '\$',
                style: GoogleFonts.fugazOne(
                  color: DarkColors.primary,
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                    text: price.toString(),
                    style: GoogleFonts.fugazOne(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),

                  WidgetSpan(
                    child: Transform.translate(
                      offset: Offset(0, -2),
                      child: Text(
                        '.99',
                        style: GoogleFonts.fugazOne(
                          color: Colors.white,
                          fontSize: 18, // smaller font for superscript look
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
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2,
            child: Stack(
              children: [
                ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        DarkColors.primaryBackground,
                        Colors.transparent,
                      ],
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
              ],
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 40),

                Expanded(
                  flex: 20,
                  child: Column(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 250, // set your max width here
                        ),
                        child: Text(
                          meal.strMeal,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.fugazOne(
                            color: Colors.white,
                            fontSize: 38,
                          ),
                        ),
                      ),
                      RatingBarIndicator(
                        rating: meal.rating!,
                        itemBuilder: (context, index) =>
                            Icon(Icons.star, color: Colors.amber),
                        itemCount: 5,
                        itemSize: 20.0,
                        direction: Axis.horizontal,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 50,
                  child: Column(
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        '${meal.strTags ?? ''}  ${meal.strArea ?? ''}  ${meal.strCategory ?? ''}',
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
                        alignment: WrapAlignment.center,
                        spacing: 10,
                        runSpacing: 5,
                        children: meal.measures
                            .where((m) => m != null && m != '' && m != ' ')
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
                      Expanded(
                        flex: 4,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              textAlign: TextAlign.justify,
                              meal.strInstructions!,
                              style: GoogleFonts.faunaOne(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                                  var model = CurrentBasketModel(
                                    itemNo: itemCount,
                                    meal: meal,
                                  );
                                  currentItems.add(model);
                                  basketCount.value = currentItems.length;
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 20,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Add To Basket',
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
