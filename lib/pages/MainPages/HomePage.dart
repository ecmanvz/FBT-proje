import 'package:cryptotracker/pages/NavigationBarPages/Favorites.dart';
import 'package:cryptotracker/pages/NavigationBarPages/Markets.dart';
import 'package:cryptotracker/pages/NavigationBarPages/Searchs.dart';
import 'package:cryptotracker/pages/NavigationBarPages/Settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late PageController _pageController;

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    // ThemeProvider themeProvider =
    //     Provider.of<ThemeProvider>(context, listen: false);
    final String theme = "light";
    return Scaffold(
      appBar: AppBar(
        title: Text("Hoşgeldiniz!"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() => selectedIndex = 3);
              _pageController.animateToPage(4,
                  duration: Duration(milliseconds: 400), curve: Curves.easeIn);
            },
            padding: EdgeInsets.all(0),
            icon: CircleAvatar(
                backgroundImage:
                    NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!)),
          ),
        ],
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       const DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: Colors.blue,
      //         ),
      //         child: Text('Ziroo'),
      //       ),
      //       ListTile(
      //         title: const Text('Item 1'),
      //         onTap: () {
      //           // Update the state of the app.
      //           // ...
      //         },
      //       ),
      //       ListTile(
      //         title: const Text('Item 2'),
      //         onTap: () {
      //           // Update the state of the app.
      //           // ...
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => selectedIndex = index);
        },
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Markets(),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Search(),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Favorites(),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Settings(),
          ),
        ],
      ),
      // BottomBarPageTransition(
      //   builder: (_, index) => _getBody(index),
      //   currentIndex: selectedIndex,
      //   totalLength: 5,
      //   transitionType: TransitionType.fade,
      //   transitionDuration: Duration(milliseconds: 500),
      //   transitionCurve: Curves.easeOut,
      // ),
      // body: SafeArea(
      //   child: Container(
      //     padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Text(
      //               "Crypto Today",
      //               style: TextStyle(
      //                 fontSize: 40,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //           ],
      //         ),
      //         TabBar(
      //           controller: viewController,
      //           tabs: [
      //             Tab(
      //               child: Text(
      //                 "Markets",
      //                 style: Theme.of(context).textTheme.bodyText1,
      //               ),
      //             ),
      //             Tab(
      //               child: Text(
      //                 "Favorites",
      //                 style: Theme.of(context).textTheme.bodyText1,
      //               ),
      //             ),
      //           ],
      //         ),
      //         Expanded(
      //           child: TabBarView(
      //             physics: BouncingScrollPhysics(
      //                 parent: AlwaysScrollableScrollPhysics()),
      //             controller: viewController,
      //             children: [
      //               Markets(),
      //               Favorites(),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).unselectedWidgetColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: "Top Trending",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search Currency",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        onTap: (index) {
          selectedIndex = index;
          setState(() => selectedIndex = index);
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 400), curve: Curves.easeIn);
        },
      ),
    );
  }
}
