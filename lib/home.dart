import 'package:fitness/models/category_model.dart';
import 'package:fitness/models/diet_model.dart';
import 'package:fitness/models/popular_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<DietModel> diets = [];
  List<PopularDietsModel> popularDiets = [];

  void _getInitialInfo() {
    categories = CategoryModel.getCategories();
    diets = DietModel.getDiets();
    popularDiets = PopularDietsModel.getPopularDiets();
  }

  @override
  Widget build(BuildContext context) {
    _getInitialInfo();
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          _searchField(),
          const SizedBox(height: 40,),
          _categoriesSection(),
          const SizedBox(height: 40,),
          _dietSection(),
          const SizedBox(height: 40,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Popular',
                  style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 15.0,),
              ListView.separated(
                itemCount: popularDiets.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) => const SizedBox(height: 25.0,),
                padding: const EdgeInsets.only(left: 20, right: 20),
                itemBuilder: (context, index) {
                  return Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: popularDiets[index].boxIsSelected ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: popularDiets[index].boxIsSelected ? [
                        BoxShadow(
                          color: const Color(0xff1D1617).withOpacity(0.07),
                          offset: const Offset(0, 10),
                          blurRadius: 40,
                          spreadRadius: 0
                        )
                      ] : []
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          popularDiets[index].iconPath,
                          width: 64,
                          height: 64,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(popularDiets[index].name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16
                            ),),
                            Text(
                              '${popularDiets[index].level} | ${popularDiets[index].duration} | ${popularDiets[index].calorie}',
                              style: const TextStyle(
                                color: Color(0xff7C7C7C),
                                fontSize: 13
                              ),)
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                          'assets/icons/button.svg',
                          width: 30,
                          height: 30,
                          ),
                      )
                    ],
                  ),
                  );
                },
              ),
            ] 
          ),
          const SizedBox(height: 40.0,),
        ],
      ),
    );
  }

  Column _dietSection() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text("Recommendations\n for Diet",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),),
          ),
          const SizedBox(height: 15.0,),
          Container(
            height: 240,
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Container(
                  width: 210,
                  decoration: BoxDecoration(
                    color: diets[index].boxColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(diets[index].iconPath),
                      Text(
                        diets[index].name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      Text
                      ('${diets[index].level} | ${diets[index].duration} | ${diets[index].calorie}',
                      style: const TextStyle(
                        color: Color(0xff7B6F72),
                        fontSize: 13,
                        fontWeight: FontWeight.w400
                      ),),
                      Container(
                        height: 45,
                        width: 130,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              diets[index].viewIsSelected ? const Color(0xff9DCEFF) : Colors.transparent,
                              diets[index].viewIsSelected ?  const Color(0xff92A3FD) : Colors.transparent
                            ]
                          ),
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: Center(
                          child: Text(
                            'View',
                            style: TextStyle(
                              color: diets[index].viewIsSelected ? Colors.white : const Color(0xffC58BF2),
                              fontWeight: FontWeight.w600,
                              fontSize: 14
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }, 
              separatorBuilder: (context, index) => const SizedBox(width: 25,), 
              itemCount: diets.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(
                left: 20,
                right: 20
              ),
            ),
          )
        ],
        );
  }

  Column _categoriesSection() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Category',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              ),
            ),
            const SizedBox(height: 15.0,)
            ,
            Container(
              height: 120,
              child: ListView.separated(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20, right: 20),
                separatorBuilder: (context, index) => const SizedBox(width: 25,),
                itemBuilder: (context, index) {
                  return Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: categories[index].boxColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(categories[index].iconPath),
                          ),
                        ),
                        Text(
                          categories[index].name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
  }

  Container _searchField() {
    return Container(
        margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: const Color(0xff1D1617).withOpacity(0.11),
              blurRadius: 40,
              spreadRadius: 0.0,
            )
          ]),
          child: TextField(
        decoration: InputDecoration(
          filled: true,
          hintText: 'Search Pancake',
          hintStyle: const TextStyle(
            color: Color(0xffDDDADA),
            fontSize: 14,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.asset('assets/icons/Search.svg'),
          ),
          suffixIcon: SizedBox(
            width: 100,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const VerticalDivider(
                    color: Colors.black,
                    indent: 10,
                    endIndent: 10,
                    thickness: 0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset('assets/icons/Filter.svg'),
                  ),
                ],
              ),
            ),
          ),
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'Hello AppBar!',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xffF7F8F8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(
            'assets/icons/Arrow - Left 2.svg',
            width: 20,
            height: 20,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            decoration: BoxDecoration(
              color: const Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(
              'assets/icons/dots.svg',
              width: 5,
              height: 5,
            ),
          ),
        ),
      ],
    );
  }
}
