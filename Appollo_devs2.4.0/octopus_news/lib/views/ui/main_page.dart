import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:newsapi/newsapi.dart';
import 'package:octopus_news/views/ui/listofimage.dart';
import 'package:sliver_tools/sliver_tools.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'Flutter Demo',
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  var newsApi = NewsApi(
    debugLog: true,
    apiKey: '739327659a9c45f5b187578a3b7fcdb1',
  );

  ScrollController _scrollController;
  TabController _tabController;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      keepScrollOffset: true,
      initialScrollOffset: 0,
    );
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
    setState(() {});
  }
  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: " "
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.circle),
                label: "  "
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_outlined),
              label: " "
            )
          ],
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          shadowColor: Colors.white,
          title: Text(
            "Octopus",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),
          ),
          backgroundColor: Colors.white,
          actionsIconTheme: IconThemeData(
            color: Colors.black
          ),
          actions: [
            Container(
              child: Icon(Icons.calendar_today_outlined),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, value) {
              return [
                SliverToBoxAdapter(
                  child: Container(
                    child: Text(
                      "Hello,",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    child: Text("Mariah Carey",style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                ),
                SliverPinnedHeader(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TabBar(
                            unselectedLabelColor: Colors.cyan,
                            isScrollable: true,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blueAccent,
                            ),
                            enableFeedback: true,
                            controller: _tabController,
                            tabs: [
                              Tab(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text('Latest News'),
                                ),
                              ),
                              Tab(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text('Activities'),
                                )
                              ),
                            ],
                          ),
                          Icon(Icons.settings_applications),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: Container(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding:
                        EdgeInsets.only(bottom: 20, left: 20, right: 20),
                        height: 240,
                        width: double.infinity,
                        child: Container(
                          height: 300,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage('https://i.pinimg.com/564x/fc/eb/2b/fceb2bd487bb2a53a0135783bd629ece.jpg'),
                                fit: BoxFit.fill),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding:
                        EdgeInsets.only(bottom: 20, left: 20, right: 20),
                        height: 240,
                        width: double.infinity,
                        child: Container(
                          height: 300,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage('https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aHVtYW58ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80'),
                                fit: BoxFit.fill),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
