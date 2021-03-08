=============================================================================================
bottomNavigationBar
Note:
loading async task or future List<Map> to Listview...............
=============================================================================================


//     bottomNavigationBar: BottomNavigationBar(
//        currentIndex: _currentTab,
//        onTap: _tabSelectAction,
//        type: BottomNavigationBarType.shifting,
//        selectedItemColor: bottomNavActiveColor,
//        unselectedItemColor: Colors.white,
//        items: [
//          BottomNavigationBarItem(
//            backgroundColor: homeBottomNavColor,
//            icon: Icon(
//              Icons.home,
//              size: 30.0,
//            ),
//            title: SizedBox.shrink(),
//          ),
//          BottomNavigationBarItem(
//            backgroundColor: Colors.redAccent,
//            icon: Icon(
//              Icons.favorite,
//              size: 30.0,
//            ),
//            title: SizedBox.shrink(),
//          ),
//          BottomNavigationBarItem(
//            backgroundColor: userColor,
//            icon: Icon(
//              Icons.person,
//              size: 30.0,
//            ),
//            title: SizedBox.shrink(),
//          )
//        ],
//      ),


=============================================================================================
bottom_navy_bar package
Note:
loading async task or future List<Map> to Listview...............
=============================================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listOfScreen[_screenIndex],
        bottomNavigationBar: BottomNavyBar(
      selectedIndex: _currentTab,
      showElevation: true, // use this to remove appBar's elevation
      onItemSelected: _tabSelectAction,
      items: [
        BottomNavyBarItem(
          icon: Icon(Icons.apps),
          title: Text('Home'),
          activeColor: Theme.of(context).primaryColor,
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favourite'),
            activeColor: Theme.of(context).primaryColor
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text('Profile'),
            activeColor: Theme.of(context).primaryColor
        ),
      ],
    )