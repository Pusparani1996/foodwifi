import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwifi/logic/belowpart/belowpart_cubit.dart';

import 'package:foodwifi/model/joinmodel.dart';

class FirstOneItemPage extends StatelessWidget {
  final String id;

  const FirstOneItemPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final bellowdata = context.watch<BellowDataCubit>().state;
    List<JoinReviewBellowModel>? oneitem = bellowdata.oneitem;

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: oneitem!.length,
      itemBuilder: (context, index) {
        return Padding(
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
                      padding:
                          const EdgeInsets.only(left: 0, top: 9, bottom: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          oneitem[index].categoryName.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: oneitem[index].products.length,
                      itemBuilder: (context, productindex) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: SizedBox(
                            child: Column(
                              children: [
                                FittedBox(
                                  child: Row(
                                    children: [
                                      Container(
                                          child: oneitem[index]
                                                  .products[productindex]
                                                  .img
                                                  .isEmpty
                                              ? Stack(
                                                  alignment: Alignment.topRight,
                                                  children: [
                                                    SizedBox(
                                                      height: 90,
                                                      width: 90,
                                                      child: ClipOval(
                                                          child: Image.asset(
                                                        "assets/images/foodwifi.png",
                                                        color: Colors.white
                                                            .withOpacity(0.2),
                                                        colorBlendMode:
                                                            BlendMode.modulate,
                                                      )),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                      width: 20,
                                                      child: Image.asset(oneitem[
                                                                      index]
                                                                  .products[
                                                                      productindex]
                                                                  .type ==
                                                              "non_veg"
                                                          ? "assets/images/non-veg.png"
                                                          : "assets/images/veg.jpg"),
                                                    ),
                                                  ],
                                                )
                                              : Stack(
                                                  alignment: Alignment.topRight,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Image.network(
                                                        "https://globizs.sgp1.cdn.digitaloceanspaces.com/foodwifi/${oneitem[index].products[productindex].img}",
                                                        height: 90,
                                                        width: 90,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 2,
                                                      ),
                                                      child: SizedBox(
                                                        height: 15,
                                                        width: 20,
                                                        child: Image.asset(oneitem[
                                                                        index]
                                                                    .products[
                                                                        productindex]
                                                                    .type ==
                                                                "non_veg"
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
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(oneitem[index]
                                                .products[productindex]
                                                .name
                                                .toString()),
                                            SizedBox(
                                              width: 200,
                                              child: Text(
                                                oneitem[index]
                                                    .products[productindex]
                                                    .description
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Color.fromARGB(
                                                        255, 174, 169, 169)),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 14,
                                            ),
                                            SizedBox(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "₹${oneitem[index].products[productindex].price}",
                                                    style: const TextStyle(
                                                        color: Colors.black87,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough),
                                                  ),
                                                  const SizedBox(
                                                    width: 7,
                                                  ),
                                                  SizedBox(
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          maxLines: 3,
                                                          "₹${oneitem[index].products[productindex].offer.offerPrice}",
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              17,
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0),
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                25,
                                                                132,
                                                                95),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Row(
                                                              children: [
                                                                Transform.rotate(
                                                                    angle: 20.7,
                                                                    child: const Icon(
                                                                      Icons
                                                                          .local_offer,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 10,
                                                                    )),
                                                                Text(
                                                                  oneitem[index]
                                                                      .products[
                                                                          productindex]
                                                                      .offer
                                                                      .description
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          10),
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
                                ),
                                const Divider(
                                  height: 20,
                                  thickness: 1,
                                  indent: 20,
                                  endIndent: 0,
                                  color: Color.fromARGB(255, 227, 221, 221),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
