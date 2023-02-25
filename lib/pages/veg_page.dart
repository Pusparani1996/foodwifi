import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:foodwifi/model/joinmodel.dart';
import 'package:foodwifi/pages/all_review+page.dart';
import 'package:intl/intl.dart';

class VegProductPage extends StatelessWidget {
  final String id;

  final List<JoinReviewBellowModel>? belowdatalistveg;
  VegProductPage({
    super.key,
    required this.belowdatalistveg,
    required this.id,
  });
  String categoryname = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: const Color.fromARGB(255, 235, 238, 239),
          child: Column(
            children: [
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: belowdatalistveg!.length,
                itemBuilder: (context, index) {
                  log(belowdatalistveg.toString());

                  for (var element in belowdatalistveg![index].products) {
                    if (element.type == "veg") {
                      categoryname = belowdatalistveg![index].categoryName;
                    }
                  }

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(
                          color: Colors.white,
                          //height: 150,
                          width: 400,
                          child: ListTile(
                            title: SizedBox(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0, top: 9, bottom: 8),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          categoryname,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        )),
                                  ),
                                  ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: belowdatalistveg![index]
                                        .products
                                        .length,
                                    itemBuilder: (context, productindex) {
                                      return belowdatalistveg![index]
                                                  .products[productindex]
                                                  .type ==
                                              "veg"
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8),
                                              child: SizedBox(
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                            child: belowdatalistveg![
                                                                        index]
                                                                    .products[
                                                                        productindex]
                                                                    .img
                                                                    .isEmpty
                                                                ? Stack(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                            90,
                                                                        width:
                                                                            90,
                                                                        child: ClipOval(
                                                                            child: Image.asset(
                                                                          "assets/images/foodwifi.png",
                                                                          color: Colors
                                                                              .white
                                                                              .withOpacity(0.2),
                                                                          colorBlendMode:
                                                                              BlendMode.modulate,
                                                                        )),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            15,
                                                                        width:
                                                                            20,
                                                                        child: Image.asset(
                                                                            "assets/images/veg.jpg"),
                                                                      ),
                                                                    ],
                                                                  )
                                                                : Stack(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    children: [
                                                                      ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                        child: Image
                                                                            .network(
                                                                          "https://globizs.sgp1.cdn.digitaloceanspaces.com/foodwifi/${belowdatalistveg![index].products[productindex].img}",
                                                                          height:
                                                                              90,
                                                                          width:
                                                                              90,
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(
                                                                          top:
                                                                              2,
                                                                        ),
                                                                        child:
                                                                            SizedBox(
                                                                          height:
                                                                              15,
                                                                          width:
                                                                              20,
                                                                          child: Image.asset(belowdatalistveg![index].products[productindex].type == "non_veg"
                                                                              ? "assets/images/non-veg.png"
                                                                              : "assets/images/veg.jpg"),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )),
                                                        const SizedBox(
                                                          width: 14,
                                                        ),
                                                        SizedBox(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width: 200,
                                                                child: Text(
                                                                    maxLines: 2,
                                                                    belowdatalistveg![
                                                                            index]
                                                                        .products[
                                                                            productindex]
                                                                        .name
                                                                        .toString()),
                                                              ),
                                                              SizedBox(
                                                                width: 200,
                                                                child: Text(
                                                                  belowdatalistveg![
                                                                          index]
                                                                      .products[
                                                                          productindex]
                                                                      .description
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          174,
                                                                          169,
                                                                          169)),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 14,
                                                              ),
                                                              SizedBox(
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      belowdatalistveg![index].products[productindex].price ==
                                                                              belowdatalistveg![index].products[productindex].offer.offerPrice
                                                                          ? ""
                                                                          : "₹${belowdatalistveg![index].products[productindex].price}",
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .black87,
                                                                          decoration:
                                                                              TextDecoration.lineThrough),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 7,
                                                                    ),
                                                                    SizedBox(
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Text(
                                                                            maxLines:
                                                                                3,
                                                                            belowdatalistveg![index].products[productindex].offer.offerPrice == null
                                                                                ? ""
                                                                                : "₹${belowdatalistveg![index].products[productindex].offer.offerPrice!.toInt()}",
                                                                            style:
                                                                                const TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                MediaQuery.of(context).size.width / 17,
                                                                          ),
                                                                          belowdatalistveg![index].products[productindex].offer.description!.isEmpty
                                                                              ? Container()
                                                                              : Container(
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(0),
                                                                                    color: const Color.fromARGB(255, 25, 132, 95),
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.all(4.0),
                                                                                    child: Row(
                                                                                      children: [
                                                                                        Transform.rotate(
                                                                                            angle: 20.7,
                                                                                            child: const Icon(
                                                                                              Icons.local_offer,
                                                                                              color: Colors.white,
                                                                                              size: 10,
                                                                                            )),
                                                                                        Text(
                                                                                          belowdatalistveg![index].products[productindex].offer.description.toString(),
                                                                                          style: const TextStyle(color: Colors.white, fontSize: 10),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const Divider(
                                                      height: 20,
                                                      thickness: 1,
                                                      indent: 20,
                                                      endIndent: 0,
                                                      color: Color.fromARGB(
                                                          255, 227, 221, 221),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container();
                                    },
                                  ),
                                  belowdatalistveg![index].reviewData == null
                                      ? Container()
                                      : Container(
                                          color: const Color.fromARGB(
                                              255, 236, 240, 242),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15,
                                                    top: 2,
                                                    right: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "What people say",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    // MOVE TO ALL REVIEW PAGE

                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    AllReviewPage(
                                                                        id: id)));
                                                      },
                                                      child: const CircleAvatar(
                                                        radius: 12,
                                                        backgroundColor:
                                                            Color.fromARGB(255,
                                                                220, 215, 215),
                                                        child: Icon(
                                                          Icons.arrow_forward,
                                                          color: Colors.black,
                                                          size: 15,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15,
                                                    bottom: 15,
                                                    top: 13),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      belowdatalistveg![index]
                                                          .reviewData!
                                                          .rating
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                    const Icon(
                                                      Icons.star,
                                                      size: 18,
                                                      color: Color.fromARGB(
                                                          255, 226, 209, 53),
                                                    ),
                                                    Text(
                                                      "${belowdatalistveg![index].reviewData!.ratingCount} rating & public reviews",
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.black45),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                // color: Colors.amber,
                                                height: 150,
                                                child: ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      belowdatalistveg![index]
                                                          .reviewData!
                                                          .review
                                                          .length,
                                                  itemBuilder:
                                                      (context, reviewindex) {
                                                    DateTime date =
                                                        belowdatalistveg![index]
                                                            .reviewData!
                                                            .review[reviewindex]
                                                            .createdDate;
                                                    var formateddate =
                                                        DateFormat(
                                                                "dd MMM,yyyy")
                                                            .format(date);
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 20,
                                                        // right: 2,
                                                        bottom: 15,
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: Colors
                                                                    .white),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 20,
                                                                      bottom:
                                                                          20,
                                                                      right: 25,
                                                                      left: 10),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    belowdatalistveg![index].reviewData!.review[reviewindex].name ==
                                                                            null
                                                                        ? ""
                                                                        : belowdatalistveg![index]
                                                                            .reviewData!
                                                                            .review[reviewindex]
                                                                            .name!,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top: 12,
                                                                        bottom:
                                                                            11),
                                                                    child: Row(
                                                                      children: [
                                                                        Text(belowdatalistveg![index]
                                                                            .reviewData!
                                                                            .review[reviewindex]
                                                                            .rating),
                                                                        const Icon(
                                                                          Icons
                                                                              .star,
                                                                          size:
                                                                              18,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              226,
                                                                              209,
                                                                              53),
                                                                        ),
                                                                        Text(
                                                                          "$formateddate. Order on",
                                                                          style: const TextStyle(
                                                                              color: Colors.black54,
                                                                              fontSize: 13),
                                                                        ),
                                                                        ClipOval(
                                                                          child:
                                                                              Image.asset(
                                                                            "assets/images/foodwifi.png",
                                                                            height:
                                                                                10,
                                                                            width:
                                                                                10,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    // height: 100,
                                                                    width: 250,
                                                                    child: Text(
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                      maxLines:
                                                                          2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      belowdatalistveg![index].reviewData!.review[reviewindex].description ==
                                                                              null
                                                                          ? ""
                                                                          : belowdatalistveg![index]
                                                                              .reviewData!
                                                                              .review[reviewindex]
                                                                              .description!,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),

                                              // )
                                            ],
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      belowdatalistveg![index].categoryName ==
                              belowdatalistveg!.last.categoryName
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                child: Column(
                                  children: const [
                                    Text(
                                      "Prices on this menu are set directly by the Merchant",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.black54),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                        "Price may differ between Delivery and Dine-in",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black54)),
                                    SizedBox(
                                      height: 40,
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container()
                    ],
                  );
                  // } //else close
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
