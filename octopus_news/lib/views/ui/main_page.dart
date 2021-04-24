import 'package:flutter/material.dart';
import 'apisservice.dart';
import 'package:sliver_tools/sliver_tools.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Lexend',
      ),
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
    SizeConfig().init(context);
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
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                floating: false,
                pinned: false,
                snap: false,
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
                    padding: EdgeInsets.all(10),
                      child: Icon(Icons.date_range_outlined),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 1.5, color: Colors.black12),
                  ),
                  )
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: Text(
                      "Hello,",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: Text("Mariah Carey",style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                    ),),
                  ),
                ),
              ),
              SliverPinnedHeader(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:10.0, bottom: 10),
                          child: TabBar(
                            unselectedLabelColor: Colors.cyan,
                            isScrollable: true,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color.fromRGBO(0,112,255,1),
                            ),
                            enableFeedback: true,
                            controller: _tabController,
                            tabs: [
                              Tab(
                                child: Text('Latest News'),
                              ),
                              Tab(
                                child: Text('Activities')
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.settings_applications),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FutureBuilder(
                    future: ApiService().getArticle(),
                    builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
                      if (snapshot.hasData){
                        List<Article> articles = snapshot.data;
                        return ListView.builder(
                          itemCount: articles.length,
                            itemBuilder: (context, index) {
                            if(articles[index].urlToImage!=null) {
                              return Padding(
                                padding: const EdgeInsets.only(top:20.0),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(articles[index].urlToImage,),
                                          fit: BoxFit.fill
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      height: SizeConfig.blockSizeVertical*20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:15.0, bottom: 15),
                                      child: Container(
                                        child: Text(
                                          articles[index].title,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.schedule,
                                                color: Colors.grey,
                                              ),
                                              Text('😍'),
                                            ],
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          ),
                                        ),
                                        Container(
                                          child: Icon(
                                            Icons.bookmark_outline,
                                            color: Colors.grey,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                            }
                        );
                      }
                      else {
                        return Container(
                          child:Text('Couldnt load data.'),
                        );
                      }
                    }
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FutureBuilder(
                    future: ApiService().getArticle(),
                    builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
                      if (snapshot.hasData){
                        List<Article> articles = snapshot.data;
                        return ListView.builder(
                            itemCount: articles.length,
                            itemBuilder: (context, index) {
                              if(articles[index].urlToImage!=null) {
                                return Padding(
                                  padding: const EdgeInsets.only(top:20.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(articles[index].urlToImage,),
                                              fit: BoxFit.fill
                                          ),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        height: SizeConfig.blockSizeVertical*20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top:15.0, bottom: 15),
                                        child: Container(
                                          child: Text(
                                            articles[index].title,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.schedule,
                                                  color: Colors.grey,
                                                ),
                                                Text('😍'),
                                              ],
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            ),
                                          ),
                                          Container(
                                            child: Icon(
                                              Icons.bookmark_outline,
                                              color: Colors.grey,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }
                        );
                      }
                      else {
                        return Container(
                          child:Text('Couldnt load data.'),
                        );
                      }
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal = _mediaQueryData.padding.left +
        _mediaQueryData.padding.right;
    _safeAreaVertical = _mediaQueryData.padding.top +
        _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth -
        _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight -
        _safeAreaVertical) / 100;
  }
}