import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scoregenics/API/BaseApi.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  ScrollController mainScrollController;
  BaseApi baseApi = BaseApi();
  bool appBarShow = true;
  bool isScrollingDown = false;
  int _value = 1;
  @override
  void initState() {
    super.initState();
    mainScrollController = ScrollController();
    mainScrollController.addListener(() {
      if (mainScrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          setState(() {
            isScrollingDown = true;
            appBarShow = false;
          });
        }
      }
      if (mainScrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          setState(() {
            isScrollingDown = false;
            appBarShow = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          controller: mainScrollController,
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              // leadingWidth: 600,
              leading: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xff0019F5), Color(0xff8E0101)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8),
                          topRight: Radius.circular(8)),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Score\nGenics',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              actions: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        baseApi.getRequestAvailable ?? 'Waiting',
                        style: TextStyle(color: Colors.black),
                      ),
                      // IconButton(icon: Icon(Icons.ac_unit), onPressed: () {}),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: FlatButton(
                            onPressed: () {
                              print('Standings');
                            },
                            child: Text('Standings')),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: FlatButton(
                            onPressed: () async {
                              await baseApi.getProfile().then((value) {
                                setState(() {});
                                print('VALUE: $value');
                                print(baseApi.getRequestAvailable);
                              }).catchError((e) {
                                print("ERRROOORRR :$e");
                              });
                              print('Stats');
                            },
                            child: Text('Stats')),
                      )
                    ],
                  ),
                )
              ],
              //primary: false,

              //floating: true,
              flexibleSpace: FlexibleSpaceBar(),
              //collapsedHeight: 300,
              toolbarHeight: 120,
              elevation: 0,
              pinned: true,
              expandedHeight: 140,
            ),
            AnimatedContainer(
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 5000),
              child: SliverAppBar(
                actions: [
                  DropdownButton(
                      value: _value,
                      items: [
                        DropdownMenuItem(
                          child: Text("First Item"),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text("Second Item"),
                          value: 2,
                        ),
                        DropdownMenuItem(child: Text("Third Item"), value: 3),
                        DropdownMenuItem(child: Text("Fourth Item"), value: 4)
                      ],
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                      })
                ],
                elevation: 0,
                //toolbarHeight: 20,
                backgroundColor: Colors.greenAccent,
                pinned: appBarShow,
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, i) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.white,
                            child: ListTile(
                              title: Text('$i'),
                            ),
                          ),
                        ),
                    childCount: 1000))
          ],
        ));
  }
}
