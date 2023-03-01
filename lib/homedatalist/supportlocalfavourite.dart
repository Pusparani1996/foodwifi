import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:foodwifi/model/foodwifimodel.dart';
import 'package:foodwifi/router/router.gr.dart';
import 'package:foodwifi/widget/firstlistContainerSkeleton.dart';

class SupportLocalFavouriteList extends StatelessWidget {
  final List<List<Item?>> firstitemlist;
  final List<FoodwifiModel> alldatalist;
  const SupportLocalFavouriteList(
      {super.key, required this.firstitemlist, required this.alldatalist});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 7),
      child: Container(
        color: Colors.white,
        height: 297,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 10),
              child: alldatalist.isEmpty
                  ? const CircularProgressIndicator()
                  : Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${alldatalist[4].title}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const CircleAvatar(
                                    radius: 10,
                                    backgroundColor:
                                        Color.fromARGB(255, 233, 232, 232),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      size: 17,
                                      color: Colors.black,
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              "${alldatalist[4].description}",
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
            ),
            Expanded(
              child: Container(
                child: firstitemlist.isEmpty
                    ? const Skeleton(
                        radius: 15,
                        height: 280,
                        width: 350,
                      )
                    : ListView.builder(
                        controller: PageController(viewportFraction: 0.90),
                        //shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const PageScrollPhysics()
                            .applyTo(const BouncingScrollPhysics()),

                        itemCount: firstitemlist[4].length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              context.router.push(ProductUpperRoute(
                                id: firstitemlist[4][index]!.id.toString(),
                                title:
                                    firstitemlist[4][index]!.title.toString(),
                                // the below parameter are  not used for this navigate ..it used for searchrestuarant page
                                autoscroll: false,
                                searcgcategoryname: '',
                                finalindex: 0,
                                products: null,
                                // products: null,
                                // finalindex: 5
                              ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20, left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height: 180,
                                      width: 330,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            CachedNetworkImage(
                                                fadeInDuration:
                                                    const Duration(seconds: 1),
                                                imageUrl:
                                                    'https://globizs.sgp1.cdn.digitaloceanspaces.com/foodwifi/${firstitemlist[4][index]!.img}',
                                                fit: BoxFit.cover,
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                        downloadProgress) {
                                                  return const Skeleton(
                                                    radius: 15,
                                                    height: 180,
                                                    width: 330,
                                                  );
                                                },
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Center(
                                                            child: Text(
                                                          "bad network",
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 10),
                                                        ))),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0, bottom: 0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox(
                                                    height: 90,
                                                    // width: 330,
                                                    child: Card(
                                                      color:
                                                          const Color.fromARGB(
                                                              0, 1, 0, 0),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .stretch,
                                                          children: [
                                                            Text(
                                                              "${firstitemlist[4][index]!.title}",
                                                              style: const TextStyle(
                                                                  fontSize: 23,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            const SizedBox(
                                                              height: 3,
                                                            ),
                                                            Text(
                                                              "${firstitemlist[4][index]!.description}",
                                                              style: const TextStyle(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            const SizedBox(
                                                              height: 3,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "${firstitemlist[4][index]!.time}\t",
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                Text(
                                                                  "${firstitemlist[4][index]!.distance}",
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                const Icon(
                                                                  Icons.star,
                                                                  size: 13,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          226,
                                                                          209,
                                                                          53),
                                                                ),
                                                                Text(
                                                                  "${firstitemlist[4][index]!.rating}",
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
