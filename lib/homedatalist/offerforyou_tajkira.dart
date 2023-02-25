import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:foodwifi/model/foodwifimodel.dart';
import 'package:foodwifi/router/router.gr.dart';
import 'package:foodwifi/widget/firstlistContainerSkeleton.dart';

class OfferForYouTajKiraList extends StatelessWidget {
  final List<List<Item?>> firstitemlist;
  final List<FoodwifiModel> alldatalist;
  const OfferForYouTajKiraList(
      {super.key, required this.firstitemlist, required this.alldatalist});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 7),
      child: Container(
        color: Colors.white,
        height: 268,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 10),
              child: alldatalist.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Skeleton(
                            radius: 4,
                            height: 30,
                            width: 210,
                          ),
                        ],
                      ),
                    )
                  : Row(
                      children: [
                        Text(
                          "${alldatalist[1].title}",
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
                            backgroundColor: Color.fromARGB(255, 233, 232, 232),
                            child: Icon(
                              Icons.arrow_forward,
                              size: 17,
                              color: Colors.black,
                            ))
                      ],
                    ),
            ),
            Expanded(
              child: Container(
                child: firstitemlist.isEmpty
                    // for lazy loading part not using lazy_loading package
                    ? const Skeleton(
                        radius: 15,
                        height: 280,
                        width: 350,
                      )
                    : ListView.builder(
                        controller: PageController(viewportFraction: 0.75),
                        //shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const PageScrollPhysics()
                            .applyTo(const BouncingScrollPhysics()),
                        itemCount: firstitemlist[1].length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 20, left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: GestureDetector(
                                    onTap: () {
                                      context.router.push(ProductUpperRoute(
                                        id: firstitemlist[1][index]!
                                            .id
                                            .toString(),
                                        title: firstitemlist[1][index]!
                                            .title
                                            .toString(),
                                        // the below parameter are  not used for this navigate ..it used for searchrestuarant page
                                        autoscroll: false,
                                        searcgcategoryname: '',
                                        finalindex: 0,
                                        products: null,
                                      ));
                                    },
                                    child: SizedBox(
                                      height: 120,
                                      width: 210,
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          CachedNetworkImage(
                                              fadeInDuration:
                                                  const Duration(seconds: 2),
                                              imageUrl:
                                                  'https://globizs.sgp1.cdn.digitaloceanspaces.com/foodwifi/${firstitemlist[1][index]!.img}',
                                              fit: BoxFit.cover,
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                      downloadProgress) {
                                                return const Skeleton(
                                                  radius: 15,
                                                  height: 75,
                                                  width: 85,
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
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 14,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8),
                                                child: firstitemlist[1][index]!
                                                            .offerDescription ==
                                                        ""
                                                    ? Container()
                                                    : Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              17, 153, 106),
                                                        ),
                                                        height: 20,
                                                        width: 120,
                                                        child: Row(
                                                          children: [
                                                            const SizedBox(
                                                              width: 3,
                                                            ),
                                                            Transform.rotate(
                                                                angle: 20.7,
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .local_offer,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 12,
                                                                )),
                                                            Text(
                                                              "${firstitemlist[1][index]!.offerDescription}",
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${firstitemlist[1][index]!.title}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "${firstitemlist[1][index]!.description}",
                                  style: const TextStyle(
                                      fontSize: 10,
                                      color:
                                          Color.fromARGB(255, 131, 130, 130)),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 13,
                                      color: Color.fromARGB(255, 226, 209, 53),
                                    ),
                                    Text(
                                      "${firstitemlist[1][index]!.rating}\t",
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 97, 120, 131)),
                                    ),
                                    Text(
                                      "${firstitemlist[1][index]!.time}\t",
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 97, 120, 131)),
                                    ),
                                    Text(
                                      "${firstitemlist[1][index]!.distance}",
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 97, 120, 131)),
                                    ),
                                  ],
                                )
                              ],
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
