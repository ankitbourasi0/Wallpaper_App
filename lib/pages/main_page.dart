import 'package:flutter/material.dart';
import 'package:hrythm/pages/accounts_page.dart';
import 'package:hrythm/pages/explore_page.dart';
import 'package:hrythm/pages/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> _pages = [];
  int _currentIndex = 0;
  bool _isVisible = true;

  //intialize the pages
  @override
  void initState() {
    _pages = [
      HomePage(afterScrollResult: afterScrollResult,),
      const ExplorePage(),
      const AccountsPage(),
    ];
    super.initState();
  }

  afterScrollResult(bool visibility){
    setState(() {
       _isVisible = visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      //Visibility widget to hide the bottom navigation bar
      //For animation purposes we use AnimatedContainer
      //but we want to perform animation on scroll events, for that we need to use custom scroll event in each page(Home, Explore, Account)
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: _isVisible ? 80 : 0,
        child: Wrap( //provide dynamic sizing to the bottom navigation bar
          children:[ BottomNavigationBar(
            elevation: 0,
              type: BottomNavigationBarType.fixed,
              fixedColor: Colors.black,
              unselectedItemColor: Colors.grey,
              iconSize: 32,
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.card_giftcard), label: 'Explore'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_box_outlined), label: 'Account'),
              ])
        ],
        ),
      ),
    );
  }
}
