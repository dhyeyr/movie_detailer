// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/movie_provider.dart';
import 'detail_page.dart';

class LikePage extends StatefulWidget {
  const LikePage({super.key});

  @override
  State<LikePage> createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Like Page",
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        body: Consumer<MovieProvider>(
          builder: (BuildContext context, value, Widget? child) {
            return (value.likeList.isEmpty)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 150,
                          ),
                        ),
                      ),
                      Text("Not Like Movies !!! "),
                    ],
                  )
                : GridView.builder(
                    clipBehavior: Clip.antiAlias,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: value.likeList.length,
                    itemBuilder: (context, index) {
                      String sData = value.likeList[index];

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ViewMore(index: value.index),
                              ));
                        },
                        child: Stack(
                          children: [
                            Container(
                                margin: EdgeInsets.all(10),
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.network(
                                  sData,
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: 200,
                                )),
                            Positioned(
                                right: 0,
                                bottom: 0,
                                child: IconButton(
                                    onPressed: () {
                                      value.removeMovie(sData);
                                    },
                                    icon: Icon(
                                      CupertinoIcons.heart_fill,
                                      color: Colors.red,
                                    )))
                          ],
                        ),
                      );
                    },
                  );
          },
        ));
  }
}
