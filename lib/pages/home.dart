import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu_app/components/gridview_cards.dart';
import 'package:menu_app/custom_theme.dart';
import 'package:menu_app/models/currentbasket_model.dart';
import 'package:menu_app/models/mealsmodel.dart';
import 'package:menu_app/service/basedb.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

ValueNotifier<int> basketCount = ValueNotifier(currentItems.length);

class _HomeState extends State<Home> {
  List<MealModel> filteredList = [];
  bool isSearching = false;
  final FocusNode _searchFocus = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  final uniqueCategories = Store.meals
      .map((meal) => meal.strCategory)
      .toSet() // removes duplicates
      .toList();

  @override
  void initState() {
    super.initState();
    uniqueCategories.insert(0, 'All');
    filteredList = Store.meals;
    _searchFocus.addListener(() {
      if (!_searchFocus.hasFocus) {
        // TextField lost focus
        setState(() {
          isSearching = false;
          filteredList = Store.meals;
        });
      }
    });
    currentItems.add(CurrentBasketModel(itemNo: 2, meal: Store.meals[1]));
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
            if (!isSearching) ...[
              Text('Aurora Info', style: Theme.of(context).textTheme.bodyLarge),
              Spacer(),
              IconButton(
                onPressed: () {
                  setState(() {
                    isSearching = true;
                  });
                  Future.delayed(Duration(milliseconds: 100), () {
                    FocusScope.of(context).requestFocus(_searchFocus);
                  });
                },
                icon: Icon(Icons.search),
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/basket');
                      // if (basketCount.value >= 1) {
                      // } else {
                      //   CustomBanner.showBanner(
                      //     context: context,
                      //     message: 'You Dont have Anything in the Basket',
                      //     severity: Severity.info,
                      //   );
                      // }
                    },
                    icon: Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                    ),
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
                      child: ValueListenableBuilder<int>(
                        valueListenable: basketCount,
                        builder: (context, value, _) {
                          return Text(
                            value.toString(),
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ] else ...[
              Expanded(
                child: TextField(
                  controller: _searchController,
                  focusNode: _searchFocus,
                  decoration: InputDecoration(
                    hint: Text(
                      'Find Your Desired Meal',
                      style: GoogleFonts.openSans(fontSize: 12),
                    ),
                    border: InputBorder.none,
                  ),
                  style: GoogleFonts.openSans(color: Colors.white),
                  onChanged: (value) {
                    setState(() {
                      filteredList = Store.meals
                          .where(
                            (m) => m.strMeal.toLowerCase().contains(
                              value.toLowerCase(),
                            ),
                          )
                          .toList();
                    });
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  _searchFocus.unfocus(); // manually remove focus
                  setState(() {
                    isSearching = false;
                    filteredList = Store.meals;
                  });
                },
              ),
            ],
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
                                onPressed: () {
                                  final String cat = uniqueCategories[index]!;
                                  setState(() {
                                    filteredList = Store.meals
                                        .where(
                                          (m) => cat != 'All'
                                              ? m.strCategory == cat
                                              : true,
                                        )
                                        .toList();
                                  });
                                },
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
                            itemCount: filteredList.length,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 180,
                                  crossAxisSpacing: 30,
                                  mainAxisSpacing: 20,
                                  childAspectRatio: 0.8,
                                ),
                            itemBuilder: (context, index) {
                              return GridviewCards(
                                index: index,
                                list: filteredList,
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
