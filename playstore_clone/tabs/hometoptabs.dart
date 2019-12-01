import 'package:flutter/material.dart';

import 'homeforyou.dart';

class HomeTopTabs extends StatefulWidget{
  int _colorval;
  HomeTopTabs(this._colorval);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeTopTabsState();
  }

}

class HomeTopTabsState extends State<HomeTopTabs> with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }
  void _handleTabSelection(){
    setState(() {
//      widget._colorval = 0xffff5722;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorWeight: 4.0,
            indicatorColor: Color(widget._colorval),
            unselectedLabelColor: Colors.grey,
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.map,
                  color: _tabController.index == 0 ? Color(widget._colorval) : Colors.grey
                ),
                child: Text('For You', style: TextStyle( color: _tabController.index == 0 ? Color(widget._colorval) : Colors.grey))
              ),
              Tab(
                  icon: Icon(
                      Icons.show_chart,
                      color: _tabController.index == 1 ? Color(widget._colorval) : Colors.grey
                  ),
                  child: Text('Top Charts', style: TextStyle( color: _tabController.index == 1 ? Color(widget._colorval) : Colors.grey))
              ),
              Tab(
                  icon: Icon(
                      Icons.bookmark,
                      color: _tabController.index == 2 ? Color(widget._colorval) : Colors.grey
                  ),
                  child: Text('Family', style: TextStyle( color: _tabController.index == 2 ? Color(widget._colorval) : Colors.grey))
              ),
              Tab(
                  icon: Icon(
                      Icons.star,
                      color: _tabController.index == 3 ? Color(widget._colorval) : Colors.grey
                  ),
                  child: Text('Early access', style: TextStyle( color: _tabController.index == 3 ? Color(widget._colorval) : Colors.grey))
              ),
              Tab(
                  icon: Icon(
                      Icons.lock_open,
                      color: _tabController.index == 4 ? Color(widget._colorval) : Colors.grey
                  ),
                  child: Text('For you', style: TextStyle( color: _tabController.index == 4 ? Color(widget._colorval) : Colors.grey))
              ),
              Tab(
                  icon: Icon(
                      Icons.lock_open,
                      color: _tabController.index == 5 ? Color(widget._colorval) : Colors.grey
                  ),
                  child: Text('For you', style: TextStyle( color: _tabController.index == 5 ? Color(widget._colorval) : Colors.grey))
              ),

            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
        children: <Widget>[
          HomeForYou(),
          HomeForYou(),
          HomeForYou(),
          HomeForYou(),
          HomeForYou(),
          HomeForYou(),
        ],
    ),
      ),
    );
  }

}