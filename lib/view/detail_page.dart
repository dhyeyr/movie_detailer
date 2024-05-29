// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../model/idmodel.dart';
import '../model/movie_helper.dart';
import '../model/search_model.dart';

class ViewMore extends StatefulWidget {
  final String? id;
  final int? index;

  const ViewMore({
    super.key,
    this.id,
    this.index,
  });

  @override
  State<ViewMore> createState() => _ViewMoreState();
}

class _ViewMoreState extends State<ViewMore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        backgroundColor:Colors.pink[50],
        title: Text(
          "Detail Page",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder(
        future: MovieHelper().iSearch(widget.id!),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(
              "${snapshot.error}",
              style: TextStyle(color: Colors.black),
            );
          } else if (snapshot.hasData) {
            IdModel? data = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Image.network(
                      "${data?.poster}",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: Container(
                          height: 35,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.yellow[700],
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Text(
                            " IMDB ${data?.imdbRating}",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Icon(
                          Icons.star,
                          color: Colors.yellow[700],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          " ${data?.imdbRating}",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: Text.rich(
                          TextSpan(
                              text: " Releasing :\n",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                              children: [
                                TextSpan(
                                  text: "${data?.released}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                      color: Colors.black, fontSize: 15),
                                )
                              ]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                 Padding(
                    padding: const EdgeInsets.only(top: 5,left: 10),
                    child:  Text.rich(
                      TextSpan(
                          text: " ${data?.title} \n",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: "  Language : ${data?.language}",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            )
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.pink[50]),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text.rich(
                        TextSpan(
                            text: " Description : \n",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                            children: [
                              TextSpan(
                                text: "  ${data?.plot}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15,fontWeight: FontWeight.normal),
                              )
                            ]),
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.pink[50]),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            " Type : ${data?.type}",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ),

                      SizedBox(
                        width: 10,
                      ),
                      Container(

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.pink[50]),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            " Duration: ${data?.runtime}",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.pink[50]),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        " Direcoter : ${data?.director}",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.pink[50]),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        " Weiters : ${data?.writer}",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.pink[50]),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        " Actors : ${data?.actors}",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.pink[50]),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        " Country : ${data?.country}",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.pink[50]),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            " Boxoffice : ${data?.boxOffice}",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.pink[50]),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            " MetaScore : ${data?.metascore}",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
SizedBox(height: 20,)
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                backgroundColor: Colors.purpleAccent,
              ),
            );
          }
        },
      ),
    );
  }
}
