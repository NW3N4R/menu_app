import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu_app/custom_theme.dart';
import 'package:menu_app/models/mealsmodel.dart';
import 'package:menu_app/service/basedb.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MealModel fMeal = Store.meals[2];
  final uniqueCategories = Store.meals
      .map((meal) => meal.strCategory)
      .toSet() // removes duplicates
      .toList();
  @override
  void initState() {
    super.initState();
    uniqueCategories.insert(0, 'All');
  }

  @override
  Widget build(BuildContext context) {
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
            Text('Aurora Info', style: Theme.of(context).textTheme.bodyLarge),
            Spacer(),
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.shopping_bag_outlined, color: Colors.white),
                ),
                // Badge
                Positioned(
                  right: 0,
                  bottom: 0,
                  left: 25,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: DarkColors.primary,
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(minWidth: 18, minHeight: 18),
                    child: Text(
                      '3', // dynamic cart item count
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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
                  Colors.black.withAlpha(170), // darkens image
                  BlendMode.darken,
                ),
                child: Image.asset(
                  'assets/images/pizza-2.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge, // base style
                      children: [
                        TextSpan(
                          text: 'Aurora ',
                          style: const TextStyle(
                            color: DarkColors.primary,
                          ), // first word color
                        ),
                        TextSpan(
                          text: 'Restaurant',
                          style: const TextStyle(
                            color: Colors.white,
                          ), // second word color
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.095),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: uniqueCategories.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: TextButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                    DarkColors.secondaryBackGround,
                                  ),
                                  foregroundColor: WidgetStateProperty.all(
                                    Colors.white,
                                  ),
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  uniqueCategories[index]!,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.openSans(fontSize: 18),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            padding: const EdgeInsets.all(2),
                            itemCount: Store.meals.length,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 180,
                                  crossAxisSpacing: 30,
                                  mainAxisSpacing: 20,
                                  childAspectRatio: 0.8,
                                ),
                            itemBuilder: (context, index) {
                              return TextButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                    DarkColors.secondaryBackGround,
                                  ),
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  padding: WidgetStateProperty.all(
                                    EdgeInsets.all(0),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
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
                                          Store.meals[index].strMealThumb!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsGeometry.fromLTRB(
                                        10,
                                        5,
                                        10,
                                        0,
                                      ),
                                      child: Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              Store.meals[index].strMeal,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  GoogleFonts.robotoCondensed(
                                                    color: Colors.white,
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            Text(
                                              textAlign: TextAlign.center,
                                              Store
                                                  .meals[index]
                                                  .strInstructions!,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  GoogleFonts.robotoCondensed(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            SizedBox(height: 20),

                                            RatingBarIndicator(
                                              rating: Store
                                                  .meals[index]
                                                  .rating!, // your random or stored rating
                                              itemBuilder: (context, index) =>
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                              itemCount: 5,
                                              itemSize: 20.0,
                                              direction: Axis.horizontal,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
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
