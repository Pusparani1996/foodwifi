import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwifi/logic/belowpart/belowpart_cubit.dart';
import 'package:foodwifi/logic/upperpart/upperpart_cubit.dart';
import 'package:foodwifi/logic/upperpart/uppertpart_statte.dart';

import 'package:foodwifi/model/joinmodel.dart';
import 'package:foodwifi/model/upperpartmodel.dart';

import 'package:foodwifi/pages/mixedproduct.dart';
import 'package:foodwifi/pages/productdetailspage.dart';
import 'package:foodwifi/pages/veg_page.dart';
import 'package:foodwifi/widget/firstlistContainerSkeleton.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ProductUpperPage extends StatefulWidget {
  final String id;

  final String title;
  final String searcgcategoryname;
  final int? finalindex;

  //from  searchresturant filter page for auto scroll to their index without any press
  final bool autoscroll;
  final Product? products;

  const ProductUpperPage({
    super.key,
    required this.id,
    required this.title,
    required this.autoscroll,
    required this.searcgcategoryname,
    required this.finalindex,
    required this.products,
  });

  @override
  State<ProductUpperPage> createState() => _ProductUpperPageState();
}

class _ProductUpperPageState extends State<ProductUpperPage> {
  bool light = false;
  ScrollController scrollcontroller = ScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ItemScrollController itemScrollController = ItemScrollController();
  bool showcontaineratappbar = false;
  double scrolloffset = 0;
  // for maked singlechild scroll when bellow scroll finish
  double? progress;
  ScrollDirection? direction2;
  ScrollDirection? direction;
  bool showsearchfield = false;
  List<dynamic>? bellowallnamelist = [];
  TextEditingController searchcontroller = TextEditingController();

  //it is used for thr ternary of scrollposition indes

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<UpperPartCubit>().uppergetalldata(
          widget.id,
        );
    context.read<BellowDataCubit>().bellowanotherModelFromJson(
          id: widget.id,
        );

    // log("initState");

    // listener for scroll controller
    scrollcontroller.addListener(() {
      scrolllisner();
    });

//automatic scroll to items index without any ontap or onpress

    if (widget.autoscroll) {
      // log("Autoscroll : ${widget.autoscroll}");

      Future.delayed(const Duration(seconds: 2), () {
        //log("auto Scroll");
        scrollcontroller
            .animateTo(scrollcontroller.position.maxScrollExtent,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.fastOutSlowIn)
            .whenComplete(() {
          setState(() {
            showcontaineratappbar = true;
          });

          scrolltoindex(widget.finalindex!);

          // log("final index :${widget.finalindex}");
        }).whenComplete(() {
          // if (widget.products != null) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailsPage(products: widget.products)));

            /// log("products : ${widget.products}");
          });

          // }
        });
      });
    }
  }

  void scrolllisner() {
    if (scrollcontroller.hasClients && scrollcontroller.offset > 540) {
      setState(() {
        showcontaineratappbar = true;
      });
    } else {
      setState(() {
        showcontaineratappbar = false;
      });
      scrolloffset = scrollcontroller.offset;
      //  log("from scroll value$scrolloffset");
    }
  }

  // for scrollablepositionlist
  void scrolltoindex(
    int index,
  ) {
    itemScrollController.scrollTo(
        index: index, alignment: 0.11, duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    scrollcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final upperdata = context.watch<UpperPartCubit>().state;
    UpperPartModel? upalldatalist = upperdata.alldata;
    final bellowdata = context.watch<BellowDataCubit>().state;
    List<JoinReviewBellowModel>? finaljoinreviewandbelowlist =
        bellowdata.belowalldata;
    log("below data : $finaljoinreviewandbelowlist");

    List<JoinReviewBellowModel>? belowdatalistveg = bellowdata.belowdatalistveg;
    // log("join data ${finaljoinreviewandbelowlist!.length}");

    switch (upperdata.status) {
      case Status.initial:
        log(Status.initial.toString());
        return Container(
          color: Colors.blue,
        );

      case Status.loading:
        log(Status.loading.toString());
        return Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height > 500
                    ? MediaQuery.of(context).size.height / 2
                    : MediaQuery.of(context).size.height / 2,
              ),
              const Text(
                "Serving your is our pleasure",
                style: TextStyle(color: Colors.blueGrey, fontSize: 20),
              ),
              Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.blueGrey,
                size: 20,
              )),
            ],
          ),
        );

      case Status.loaded:
        log(Status.loaded.toString());
        return Scaffold(
          body: Stack(children: [
            SizedBox(
              child: Column(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height > 500
                          ? MediaQuery.of(context).size.height / 3.2
                          : MediaQuery.of(context).size.height / 1.4,
                      width: MediaQuery.of(context).size.width > 500
                          ? MediaQuery.of(context).size.width
                          : MediaQuery.of(context).size.width,

                      //top image
                      child: Image.network(
                        "https://globizs.sgp1.cdn.digitaloceanspaces.com/foodwifi/${upalldatalist!.img}",
                        fit: BoxFit.cover,
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 55, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.black45,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 9),
                        child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.black45,
                    child: Center(
                      child: IconButton(
                          onPressed: () => context.router.pop(),
                          icon: const Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 170,
              left: 0,
              right: 0,
              bottom: 0,
              child: NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  direction2 = notification.direction;
                  return true;
                },
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (maxscroll) {
                    maxscroll.disallowIndicator();
                    return true;
                  },
                  child: SingleChildScrollView(
                    physics: progress == null
                        ? const AlwaysScrollableScrollPhysics()
                        : progress == 0.0
                            ? const AlwaysScrollableScrollPhysics()
                            : const NeverScrollableScrollPhysics(),
                    controller: scrollcontroller,
                    clipBehavior: Clip.none,
                    child: SizedBox(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Card(
                              elevation: 15,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                              ),
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      //height: 250,
                                      width:
                                          MediaQuery.of(context).size.width / 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, top: 25, bottom: 4),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              upalldatalist.title.toString(),
                                              style: const TextStyle(
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              upalldatalist.description
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              upalldatalist.address.toString(),
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            SizedBox(
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    size: 13,
                                                    color: Color.fromARGB(
                                                        255, 226, 209, 53),
                                                  ),
                                                  Text(
                                                    "${upalldatalist.rating}\t",
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Text(
                                                    "(${upalldatalist.ratingCount}+\tratings)",
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${upalldatalist.time}\t",
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.grey),
                                                  ),
                                                  Text(
                                                    "${upalldatalist.distance}",
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 3.5,
                                            ),
                                            SizedBox(
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                      height: 20,
                                                      width: 50,
                                                      child: Image.asset(
                                                        "assets/images/Fssai.png",
                                                        fit: BoxFit.cover,
                                                      )),
                                                  const Text("\tLic.\tNo.",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.grey)),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10, bottom: 10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 241, 236, 236),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                height: MediaQuery.of(context)
                                                            .size
                                                            .height >
                                                        500
                                                    ? MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        20
                                                    : MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        10,
                                                width: 400,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 13),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        upalldatalist
                                                            .notices![0]
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.grey)),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Container(
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width,
                            //height: MediaQuery.of(context).size.height,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 130,
                                  // width: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ListView.builder(
                                      physics: const PageScrollPhysics()
                                          .applyTo(
                                              const BouncingScrollPhysics()),
                                      itemCount: 1,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15, left: 15, right: 15),
                                          child: Image.asset(
                                            'assets/images/burger.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 15),
                                  child: Row(
                                    children: [
                                      Switch(
                                        value: light,
                                        activeColor: const Color.fromARGB(
                                            255, 72, 217, 77),
                                        onChanged: (bool value) {
                                          log(light.toString());
                                          setState(() {
                                            light = value;
                                          });
                                          log(light.toString());
                                        },
                                      ),
                                      const Text(
                                        "Veg only",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// for veg ,non-veg differentiate
                          light
                              ? belowdatalistveg == null
                                  ? const SizedBox()
                                  : VegProductPage(
                                      belowdatalistveg: belowdatalistveg,
                                      id: widget.id,
                                    )
                              : finaljoinreviewandbelowlist == null
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Skeleton(
                                                radius: 10,
                                                height: 90,
                                                width: 90,
                                              ),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              Column(
                                                children: const [
                                                  Skeleton(
                                                    radius: 2,
                                                    height: 30,
                                                    width: 220,
                                                  ),
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  Skeleton(
                                                    radius: 2,
                                                    height: 30,
                                                    width: 220,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                            children: [
                                              const Skeleton(
                                                radius: 10,
                                                height: 90,
                                                width: 90,
                                              ),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              Column(
                                                children: const [
                                                  Skeleton(
                                                    radius: 2,
                                                    height: 30,
                                                    width: 220,
                                                  ),
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  Skeleton(
                                                    radius: 2,
                                                    height: 30,
                                                    width: 220,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        Container(
                                          color: const Color.fromARGB(
                                              255, 188, 184, 184),
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          // make scrollable to bottom and make non scrollabel to top because make scrollable for SingleChildScrollView
                                          child: NotificationListener<
                                              UserScrollNotification>(
                                            onNotification: (notification) {
                                              direction =
                                                  notification.direction;
                                              progress =
                                                  notification.metrics.pixels;
                                              if (direction ==
                                                  ScrollDirection.reverse) {
                                                //  log('down');

                                                setState(() {
                                                  showcontaineratappbar = true;
                                                });
                                              } else if (direction ==
                                                  ScrollDirection.forward) {
                                                if (progress == 0) {
                                                  setState(() {
                                                    showcontaineratappbar =
                                                        false;
                                                  });
                                                }
                                              }

                                              // log('Progress :$progress');

                                              return true;
                                            },
                                            child: ScrollablePositionedList
                                                .builder(
                                              itemPositionsListener:
                                                  itemPositionsListener,
                                              itemScrollController:
                                                  itemScrollController,
                                              physics: showcontaineratappbar
                                                  ? const AlwaysScrollableScrollPhysics()
                                                  : const NeverScrollableScrollPhysics(),
                                              itemCount:
                                                  finaljoinreviewandbelowlist
                                                      .length,
                                              itemBuilder:
                                                  (context, categoryindex) {
                                                return MixedProductPage(
                                                  finaljoinreviewanddelowlist:
                                                      finaljoinreviewandbelowlist,
                                                  categoryindex: categoryindex,
                                                  id: widget.id,
                                                  searchcontroller:
                                                      searchcontroller.text,
                                                  showsearchfield:
                                                      showsearchfield,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        // Container(
                                        //   width:
                                        //       MediaQuery.of(context).size.width,
                                        //   color: Colors.white,
                                        //   child: Padding(
                                        //     padding: const EdgeInsets.symmetric(
                                        //         vertical: 15, horizontal: 20),
                                        //     child: Column(
                                        //       children: const [
                                        //         Text(
                                        //           "Prices on this menu are set directly by the Merchant",
                                        //           style: TextStyle(
                                        //               fontSize: 13,
                                        //               color: Colors.black54),
                                        //         ),
                                        //         SizedBox(
                                        //           height: 4,
                                        //         ),
                                        //         Text(
                                        //             "Price may differ between Delivery and Dine-in",
                                        //             style: TextStyle(
                                        //                 fontSize: 13,
                                        //                 color: Colors.black54)),
                                        //         SizedBox(
                                        //           height: 40,
                                        //         )
                                        //       ],
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // above pop up container
            showcontaineratappbar
                ? Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 25.0,
                        )
                      ],
                    ),
                    height: 120,
                    child: SafeArea(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: FittedBox(
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back_ios,
                                        color:
                                            Color.fromARGB(255, 180, 176, 176),
                                      )),
                                  Text(widget.title.toString()),
                                  const SizedBox(
                                    width: 210,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.favorite_outline,
                                          color: Color.fromARGB(
                                              255, 196, 202, 208))),
                                ],
                              ),
                            ),
                          ),
                          showsearchfield == false
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // for showing list of item for scrolltoindex
                                      GestureDetector(
                                          onTap: () {
                                            showFlexibleBottomSheet(
                                                bottomSheetColor:
                                                    Colors.transparent,
                                                isModal: true,
                                                isDismissible: true,
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                minHeight: 0.1,
                                                initHeight: 0.8,
                                                maxHeight: 0.8,
                                                context: context,
                                                builder: (context, controller,
                                                    bottomSheetOffset) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          height: 4,
                                                          width: 33,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.grey,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Expanded(
                                                          flex: 8,
                                                          child:
                                                              ListView.builder(
                                                            controller:
                                                                controller,
                                                            itemCount:
                                                                finaljoinreviewandbelowlist!
                                                                    .length,
                                                            physics:
                                                                const BouncingScrollPhysics(),
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            shrinkWrap: true,
                                                            itemBuilder:
                                                                (context,
                                                                    nameindex) {
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  scrolltoindex(
                                                                      nameindex);

                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    Container(
                                                                  color: Colors
                                                                      .white,
                                                                  height: 50,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(horizontal: 16),
                                                                        child:
                                                                            Text(
                                                                          finaljoinreviewandbelowlist[nameindex]
                                                                              .categoryName,
                                                                          style:
                                                                              const TextStyle(fontSize: 20),
                                                                        ),
                                                                      ),
                                                                      const Divider(
                                                                        height:
                                                                            20,
                                                                        thickness:
                                                                            1,
                                                                        indent:
                                                                            20,
                                                                        endIndent:
                                                                            0,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            227,
                                                                            221,
                                                                            221),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                isExpand: true,
                                                anchors: [0.1, 0.6]);
                                          },

                                          // it can listen the position and change the text in above textfield(momo,chicken,friedrice)
                                          child: ValueListenableBuilder<
                                              Iterable<ItemPosition>>(
                                            valueListenable:
                                                itemPositionsListener
                                                    .itemPositions,
                                            builder: (context, positionvalue,
                                                child) {
                                              int? min;
                                              if (positionvalue.isNotEmpty) {
                                                // Determine the first visible item by finding the item with the
                                                // smallest trailing edge that is greater than 0.  i.e. the first
                                                // item whose trailing edge in visible in the viewport.
                                                min = positionvalue
                                                    .where((ItemPosition
                                                            position) =>
                                                        position
                                                            .itemTrailingEdge >
                                                        0.11)
                                                    .reduce((ItemPosition min,
                                                            ItemPosition
                                                                position) =>
                                                        position.itemTrailingEdge <
                                                                min.itemTrailingEdge
                                                            ? position
                                                            : min)
                                                    .index;
                                                // log(min.toString());
                                                // Determine the last visible item by finding the item with the
                                                // greatest leading edge that is less than 1.  i.e. the last
                                                // item whose leading edge in visible in the viewport.
                                              }
                                              //  log(finaljoinreviewandbelowlist![
                                              //           min!]
                                              //       .categoryName);

                                              return Container(
                                                width: 230,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: const Color.fromARGB(
                                                        255, 236, 242, 243)),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 15),
                                                        child: Row(
                                                          children: [
                                                            Text(finaljoinreviewandbelowlist![
                                                                    min!]
                                                                .categoryName)
                                                          ],
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 10),
                                                        child: Center(
                                                          child: Icon(
                                                              Icons
                                                                  .keyboard_arrow_down,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ]),
                                              );
                                            },
                                          )),
                                      Container(
                                        width: 86,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: const Color.fromARGB(
                                              255, 236, 242, 243),
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              showsearchfield = true;
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15, right: 15),
                                            child: Row(children: const [
                                              Icon(Icons.search_outlined,
                                                  size: 16,
                                                  color: Colors.black),
                                              Text(
                                                "Search",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ]),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: SizedBox(
                                    height: 38,
                                   
                                    child: TextFormField(
                                        controller: searchcontroller,
                                        onChanged: (value) {
                                       
                                          Future.delayed(
                                            const Duration(seconds: 2),
                                          ).whenComplete(() => context
                                              .read<BellowDataCubit>()
                                              .bellowanotherModelFromJson(
                                                  id: widget.id,
                                                  onchangevalue: value,
                                                  showsearchfield: true));

                                       
                                        },
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: "Looking for something?",
                                          hintStyle: TextStyle(fontSize: 13),
                                          alignLabelWithHint: true,
                                        )),
                                  ),
                                )
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
          ]),
        );
      case Status.error:
        log(Status.error.toString());
        return Container(color: Colors.red);
    }
  }
}
