import 'package:auto_route/auto_route.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodwifi/logic/home_search/homesearch_state.dart';

import 'package:foodwifi/model/home_search_model.dart';
import 'package:foodwifi/router/router.gr.dart';
import 'package:foodwifi/widget/firstlistContainerSkeleton.dart';

class BelowHomeone extends StatelessWidget {
  final List<Items?> homebelowdara;
  final HomeStatus homesearchstatus;
  const BelowHomeone({
    super.key,
    required this.homebelowdara,
    required this.homesearchstatus,
  });

  @override
  Widget build(BuildContext context) {
    switch (homesearchstatus) {
      case HomeStatus.initial:
        return Container();
      case HomeStatus.loading:
        return Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Skeleton(
                  radius: 4,
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width / 1,
                ),
                const SizedBox(
                  height: 7,
                ),
                Skeleton(
                  radius: 4,
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width / 1,
                ),
              ],
            ),
          ),
        );
      case HomeStatus.loaded:
        return homebelowdara.isEmpty
            // for lazy loading part not using lazy_loading package
            ? Column(
                children: [
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 16, left: 14, right: 8, bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Restaurants near you",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            "view all restaurents",
                            style: TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(255, 147, 149, 149)),
                          ),
                          SizedBox(
                            height: 23,
                          ),
                          Text(
                            "No restaurants found",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 7,
                  // ),
                ],
              )
            : Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 16, left: 14, right: 8, bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Restaurants near you",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "view all restaurents",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 147, 149, 149)),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: homebelowdara.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            if (index == 1) {
                              showFlexibleBottomSheet(
                                  bottomSheetColor: Colors.transparent,
                                  isModal: true,
                                  isDismissible: true,
                                  duration: const Duration(milliseconds: 500),
                                  minHeight: 0.1,
                                  initHeight: 0.5,
                                  maxHeight: 0.8,
                                  context: context,
                                  builder:
                                      (context, controller, bottomSheetOffset) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Center(
                                            child: Container(
                                              height: 4,
                                              width: 33,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                homebelowdara[1]!.title!.isEmpty
                                                    ? const SizedBox()
                                                    : Text(
                                                        homebelowdara[1]!
                                                            .title
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                homebelowdara[1]!.img!.isEmpty
                                                    ? Container(
                                                        height: 240,
                                                        width: 340,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                239,
                                                                238,
                                                                238)),
                                                      )
                                                    : SizedBox(
                                                        height: 50,
                                                        width: 90,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child:
                                                              CachedNetworkImage(
                                                            fadeInDuration:
                                                                const Duration(
                                                                    seconds: 2),
                                                            imageUrl:
                                                                'https://globizs.sgp1.cdn.digitaloceanspaces.com/foodwifi/${homebelowdara[1]!.img}',
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          const Divider(
                                            thickness: 0.4,
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              context.router
                                                  .popAndPush(ProductUpperRoute(
                                                id: homebelowdara[index]!
                                                    .id
                                                    .toString(),
                                                title: homebelowdara[index]!
                                                    .title
                                                    .toString(),
                                                // the below parameter are  not used for this navigate ..it used for searchrestuarant page
                                                autoscroll: false,
                                                searcgcategoryname: '',
                                                finalindex: 0,
                                                products: null,
                                                // products: null,
                                                // finalindex: 5
                                              ));
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12),
                                                  child: Text(
                                                    "Likla Moirangkhom",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12),
                                                  child: Row(
                                                    children: [
                                                      homebelowdara[index]!
                                                              .time!
                                                              .isEmpty
                                                          ? const SizedBox()
                                                          : Text(
                                                              homebelowdara[
                                                                      index]!
                                                                  .time
                                                                  .toString(),
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 11,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        137,
                                                                        137,
                                                                        139),
                                                              ),
                                                            ),
                                                      const SizedBox(
                                                        width: 3,
                                                      ),
                                                      homebelowdara[index]!
                                                              .distance!
                                                              .isEmpty
                                                          ? const SizedBox()
                                                          : Text(
                                                              homebelowdara[
                                                                      index]!
                                                                  .distance
                                                                  .toString(),
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 11,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        137,
                                                                        137,
                                                                        139),
                                                              ),
                                                            ),
                                                      const Icon(
                                                        Icons.star,
                                                        size: 13,
                                                        color: Color.fromARGB(
                                                            255, 226, 209, 53),
                                                      ),
                                                      homebelowdara[index]!
                                                              .rating!
                                                              .isEmpty
                                                          ? const SizedBox()
                                                          : Text(
                                                              homebelowdara[
                                                                      index]!
                                                                  .rating
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontSize: 11,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          137,
                                                                          137,
                                                                          139),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                      homebelowdara[index]!
                                                              .ratingCount!
                                                              .isEmpty
                                                          ? const SizedBox()
                                                          : Text(
                                                              "(${homebelowdara[index]!.ratingCount})"
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontSize: 10,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          137,
                                                                          137,
                                                                          139),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Divider(
                                            thickness: 0.4,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  isExpand: true,
                                  anchors: [0.1, 0.6]);
                            } else {
                              context.router.push(ProductUpperRoute(
                                id: homebelowdara[index]!.id.toString(),
                                title: homebelowdara[index]!.title.toString(),
                                // the below parameter are  not used for this navigate ..it used for searchrestuarant page
                                autoscroll: false,
                                searcgcategoryname: '',
                                finalindex: 0,
                                products: null,
                                // products: null,
                                // finalindex: 5
                              ));
                            }
                          },
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 2, bottom: 25),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    homebelowdara[index]!.img == null
                                        ? Container(
                                            height: 240,
                                            width: 340,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: const Color.fromARGB(
                                                    255, 239, 238, 238)),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                              fadeInDuration:
                                                  const Duration(seconds: 2),
                                              imageUrl:
                                                  'https://globizs.sgp1.cdn.digitaloceanspaces.com/foodwifi/${homebelowdara[index]!.img}',
                                              fit: BoxFit.cover,
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                      downloadProgress) {
                                                return const Skeleton(
                                                  radius: 20,
                                                  height: 240,
                                                  width: 360,
                                                );
                                              },
                                            ),
                                          ),
                                    const SizedBox(
                                      height: 9,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        homebelowdara[index]!.title!.isEmpty
                                            ? const SizedBox()
                                            : SizedBox(
                                                //color: Colors.amber,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.2,
                                                child: Text(
                                                  maxLines: 2,
                                                  homebelowdara[index]!
                                                      .title
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                        const Icon(
                                          Icons.favorite_border_outlined,
                                          size: 20,
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    FittedBox(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          homebelowdara[index]!
                                                  .description!
                                                  .isEmpty
                                              ? const SizedBox()
                                              : Text(
                                                  homebelowdara[index]!
                                                      .description
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      color: Color.fromARGB(
                                                          255, 139, 139, 140)),
                                                ),
                                          Row(
                                            children: [
                                              homebelowdara[index]!
                                                      .time!
                                                      .isEmpty
                                                  ? const SizedBox()
                                                  : Text(
                                                      homebelowdara[index]!
                                                          .time
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          color: Color.fromARGB(
                                                              255,
                                                              139,
                                                              139,
                                                              140)),
                                                    ),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              homebelowdara[index]!
                                                      .distance!
                                                      .isEmpty
                                                  ? const SizedBox()
                                                  : Text(
                                                      homebelowdara[index]!
                                                          .distance
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          color: Color.fromARGB(
                                                              255,
                                                              139,
                                                              139,
                                                              140)),
                                                    ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          size: 13,
                                          color:
                                              Color.fromARGB(255, 226, 209, 53),
                                        ),
                                        homebelowdara[index]!.rating!.isEmpty
                                            ? const SizedBox()
                                            : Text(
                                                homebelowdara[index]!
                                                    .rating
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 11,
                                                    color: Color.fromARGB(
                                                        255, 111, 111, 113),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                        homebelowdara[index]!
                                                .ratingCount!
                                                .isEmpty
                                            ? const SizedBox()
                                            : Text(
                                                "(${homebelowdara[index]!.ratingCount})"
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Color.fromARGB(
                                                        255, 111, 111, 113),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/equilizer.gif",
                                          fit: BoxFit.fill,
                                          height: 12,
                                          width: 12,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "${homebelowdara[index]!.recentOrder}+\t orders placed from here recently",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Color.fromARGB(
                                                  255, 139, 139, 140)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    )
                                  ]),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
      case HomeStatus.error:
        return Container();
    }
  }
}
