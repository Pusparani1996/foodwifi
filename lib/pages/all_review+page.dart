import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwifi/logic/all_reviewdata/all_review_cubit.dart';
import 'package:foodwifi/model/allreviewmodel.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AllReviewPage extends StatefulWidget {
  final String id;
  const AllReviewPage({super.key, required this.id});

  @override
  State<AllReviewPage> createState() => _AllReviewPageState();
}

class _AllReviewPageState extends State<AllReviewPage> {
  bool pinned = true;
  bool snap = false;
  bool floating = false;
  final scrollcontroller = ScrollController();
  int data = 7;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<AllReviewCubit>().getallreview(
          limitdata: 7,
          page: "1",
          id: widget.id,
          isMoredata: true,
        );

    //for refresh data and get remaining items
    scrollcontroller.addListener(() {
      if (scrollcontroller.position.pixels ==
          scrollcontroller.position.maxScrollExtent) {
        setState(() {
          data = data + 7;
        });
        context.read<AllReviewCubit>().getallreview(
              limitdata: data,
              page: "1",
              id: widget.id,
              isMoredata: true,
            );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final reviewdata = context.watch<AllReviewCubit>().state;
    AllProductReviewModel? allreviewdata = reviewdata.allreview;
    bool ismoreloading = reviewdata.isloading;
    log(allreviewdata.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 243, 240, 240),
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
        title: const Text(
          "Ratings & Reviews",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: allreviewdata == null
          ? const Center(
              child: SizedBox(
                  height: 20, width: 20, child: CircularProgressIndicator()),
            )
          : ScrollConfiguration(
              behavior: HideScrollBehavior(),
              child: SingleChildScrollView(
                controller: scrollcontroller,
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10, left: 0),
                              child: Row(
                                children: [
                                  Text(
                                    allreviewdata.rating.toString(),
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  const Icon(
                                    Icons.star,
                                    size: 18,
                                    color: Color.fromARGB(255, 226, 209, 53),
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(allreviewdata.ratingCount.toString(),
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.black)),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  const Text(
                                    "ratings & public reviews",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                            const Divider(
                              height: 20,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                              color: Color.fromARGB(255, 162, 153, 153),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: allreviewdata.review.length,
                          itemBuilder: (context, index) {
                            DateTime date =
                                allreviewdata.review[index].createdDate;
                            var formateddate =
                                DateFormat("dd MMM,yyy").format(date);

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: Text(
                                    allreviewdata.review[index].name.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: Row(
                                    children: [
                                      Text(
                                        allreviewdata.review[index].rating
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16),
                                      ),
                                      const Icon(
                                        Icons.star,
                                        size: 20,
                                        color:
                                            Color.fromARGB(255, 226, 209, 53),
                                      ),
                                      Text(
                                        "$formateddate. Order on",
                                        style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16),
                                      ),
                                      ClipOval(
                                        child: Image.asset(
                                          "assets/images/foodwifi.png",
                                          height: 10,
                                          width: 10,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 25, top: 10),
                                  child:
                                      allreviewdata.review[index].description ==
                                              null
                                          ? Container()
                                          : Text(
                                              allreviewdata
                                                  .review[index].description
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontStyle: FontStyle.italic),
                                            ),
                                ),
                                const Divider(
                                  height: 20,
                                  thickness: 1,
                                  indent: 0,
                                  endIndent: 0,
                                  color: Color.fromARGB(255, 162, 153, 153),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Center(
                        child: ismoreloading
                            ? Container(
                                color: const Color.fromARGB(255, 235, 232, 232),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    LoadingAnimationWidget.hexagonDots(
                                      color: Colors.blueGrey,
                                      size: 35,
                                    ),
                                    const Text(
                                      "loading data...",
                                      style: TextStyle(
                                          color: Colors.black45, fontSize: 20),
                                    )
                                  ],
                                ),
                              )
                            : const SizedBox(),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

// IT USED FOR HIDE THE SCROLL VIEW BLUE COLOR
class HideScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }

  bool get showenableGlow => false;
}
