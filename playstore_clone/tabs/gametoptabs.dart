import 'package:flutter/material.dart';
import 'gametopchartstabs.dart';


class GamesTopTabs extends StatefulWidget {
  int colorVal;
  GamesTopTabs(this.colorVal);
  _GamesTopTabsState createState() => _GamesTopTabsState();
}

class _GamesTopTabsState extends State<GamesTopTabs> with SingleTickerProviderStateMixin{
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 8);
    _tabController.addListener(_handleTabSelection);
  }
  void _handleTabSelection() {
    setState(() {
      widget.colorVal=0xff3f51b5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: TabBar(
            isScrollable: true,
            indicatorWeight: 4.0,
            indicatorColor:Color(0xff3f51b5),
            unselectedLabelColor: Colors.grey,
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                icon:Icon(Icons.map, color: _tabController.index == 0
                    ? Color( widget.colorVal)
                    : Colors.grey),
                child:Text('For You',style: TextStyle( color: _tabController.index == 0
                    ?  Color( widget.colorVal)
                    : Colors.grey)),
              ),
              Tab(
                icon: Icon(Icons.pie_chart_outlined, color: _tabController.index == 1
                    ? Color( widget.colorVal)
                    : Colors.grey),
                child: Text('Top Charts',style: TextStyle( color: _tabController.index == 1
                    ?  Color( widget.colorVal)
                    : Colors.grey)),
              ),
              Tab(
                icon: Icon(Icons.filter_9_plus, color: _tabController.index == 2
                    ? Color( widget.colorVal)
                    : Colors.grey),
                child: Text('New',style: TextStyle( color: _tabController.index == 2
                    ?  Color( widget.colorVal)
                    : Colors.grey)),
              ),

              Tab(
                icon: Icon(Icons.games, color: _tabController.index == 3
                    ? Color( widget.colorVal)
                    : Colors.grey),
                child: Text('Premium',style: TextStyle( color: _tabController.index == 3
                    ?  Color( widget.colorVal)
                    : Colors.grey)),
              ),
              Tab(
                icon: Icon(Icons.format_shapes, color: _tabController.index == 4
                    ? Color( widget.colorVal)
                    : Colors.grey),
                child: Text('Category',style: TextStyle( color: _tabController.index == 4
                    ?  Color( widget.colorVal)
                    : Colors.grey)),
              ),
              Tab(
                icon: Icon(Icons.calendar_today, color: _tabController.index == 5
                    ? Color( widget.colorVal)
                    : Colors.grey),
                child: Text('Events',style: TextStyle( color: _tabController.index == 5
                    ?  Color( widget.colorVal)
                    : Colors.grey)),
              ),
              Tab(
                icon: Icon(Icons.bookmark, color: _tabController.index == 6
                    ? Color( widget.colorVal)
                    : Colors.grey),
                child: Text('Editors choice',style: TextStyle( color: _tabController.index == 6
                    ?  Color( widget.colorVal)
                    : Colors.grey)),
              ),
              Tab(
                icon: Icon(Icons.bookmark, color: _tabController.index == 7
                    ? Color( widget.colorVal)
                    : Colors.grey),
                child: Text('Family',style: TextStyle( color: _tabController.index == 7
                    ?  Color( widget.colorVal)
                    : Colors.grey)),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Column(
              children: <Widget>[
                Center(
                  child: Text("For you Tabs"),
                )
              ],
            ),
            GameTopChartsTabs(0xff3f51b5),
            Container(
              height: 200.0,
              child: Center(child: Text('New')),
            ),
            Container(
              height: 200.0,
              child: Center(child: Text('Premium')),
            ),
            Container(
              height: 200.0,
              child: Center(child: Text('Category')),
            ),
            Container(
              height: 200.0,
              child: Center(child: Text('Events')),
            ),
            Container(
              height: 200.0,
              child: Center(child: Text('Editor Choice')),
            ),
            Container(
              height: 200.0,
              child: Center(child: Text('Family')),
            ),
          ],
        ),
      ),
    );
  }
}