// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/movie_provider.dart';
import '../controller/search_provider.dart';
import '../model/movie_helper.dart';
import '../model/search_model.dart';
import 'detail_page.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({super.key});

  @override
  State<Home_screen> createState() => _HomeState();
}

class _HomeState extends State<Home_screen> {
  String sModel = "south";
  String value1 = "";

  @override
  void initState() {
    SearchProvider sp = Provider.of<SearchProvider>(context, listen: false);
    sp.sMovie;
    super.initState();
  }

  bool _isGrid = false;
  bool heart = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        leading: Consumer<MovieProvider>(builder: (context, value, child) {
          return IconButton(
            icon: Icon(_isGrid ? Icons.list : Icons.grid_on),
            onPressed: () {
              Provider.of<MovieProvider>(context, listen: false).nPage();
              _isGrid = !_isGrid;
            },
          );
        }),
        title: Text(
          "Movies",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "LikePage");
            },
            icon: Icon(
              CupertinoIcons.heart_fill,
              color: Colors.red,
              size: 30,
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Consumer<SearchProvider>(
            builder: (context, value, child) => FutureBuilder(
              future: MovieHelper()
                  .searchApi(value.sMovie.isEmpty ? sModel : value.sMovie),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Not Found",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        "${snapshot.error.runtimeType}",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  );
                } else if (snapshot.hasData) {
                  SearchModel? data = snapshot.data;
                  return Consumer2<MovieProvider, SearchProvider>(
                    builder: (context, value, value2, child) {
                      return Expanded(
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: TextFormField(
                                style: TextStyle(color: Colors.black),
                                onChanged: (value) {
                                  value2.searchApi(value);
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  hintText: "Search Movies",
                                  enabled: true,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  focusColor: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height / 60,
                            ),
                            (snapshot.hasData)
                                ? Expanded(
                                    child: _isGrid
                                        ? ListView.builder(
                                            clipBehavior: Clip.antiAlias,
                                            itemCount: data?.search?.length,
                                            itemBuilder: (context, index) {
                                              var sData = data?.search![index];
                                              var dat = sData?.poster;
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ViewMore(
                                                                id: sData
                                                                    .imdbId),
                                                      ));
                                                },
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(left: 60,right: 10,top: 5,bottom: 5),
                                                      height: 100,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.pink[50],
                                                          borderRadius:
                                                              BorderRadius.only(topRight: Radius.circular(5),bottomRight: Radius.circular(5))
                                                                  ),
                                                      child:  Padding(
                                                        padding: const EdgeInsets.only(left: 40,top: 20),
                                                        child: Text(
                                                            "${sData!.title}\n${sData.year}"),
                                                      ),

                                                    ),

                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 15,top: 5),
                                                      child: Container(
                                                        height: 90,
                                                        width: 80,
                                                        margin:
                                                        EdgeInsets.all(
                                                            5),
                                                        child:
                                                        Image.network(
                                                          "${sData?.poster}",
                                                          // fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5,
                                                              left: 310),
                                                      child: IconButton(
                                                          onPressed: () {
                                                            value
                                                                .likeMovie(dat);
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                SnackBar(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .pink[50],
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            200),
                                                                    content:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        "Like Your Movie Successfully",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    )));

                                                            value.likeIndex(
                                                                index);
                                                          },
                                                          icon: Icon(
                                                            (index ==
                                                                    value.index)
                                                                ? CupertinoIcons
                                                                    .heart_fill
                                                                : CupertinoIcons
                                                                    .heart,
                                                            color: Colors.red,
                                                          )),
                                                    ),

                                                  ],
                                                ),
                                              );
                                            },
                                          )
                                        : GridView.builder(
                                            clipBehavior: Clip.antiAlias,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2),
                                            itemCount: data?.search?.length,
                                            itemBuilder: (context, index) {
                                              var sData = data?.search![index];
                                              var dat = sData?.poster;
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ViewMore(
                                                          id: sData!.imdbId,
                                                        ),
                                                      ));
                                                },
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Image.network(
                                                          "${sData?.poster}",
                                                          fit: BoxFit.cover,
                                                          height: 200,
                                                          width: 200,
                                                        )),
                                                    Positioned(
                                                        bottom: 0,
                                                        right: 0,
                                                        child: IconButton(
                                                            onPressed: () {
                                                              value.likeMovie(
                                                                  dat);

                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                  SnackBar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .pink[50],
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              200),
                                                                      content:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          "Like Your Movie Successfully",
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                      )));
                                                              value.likeIndex(
                                                                  index);
                                                            },
                                                            icon: Icon(
                                                              (index ==
                                                                      value
                                                                          .index)
                                                                  ? CupertinoIcons
                                                                      .heart_fill
                                                                  : CupertinoIcons
                                                                      .heart,
                                                              color: Colors.red,
                                                            )))
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                  )
                                : Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.purpleAccent,
                                        backgroundColor: Colors.purple),
                                  ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                        color: Colors.purpleAccent,
                        backgroundColor: Colors.purple),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
