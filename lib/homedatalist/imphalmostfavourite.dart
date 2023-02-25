import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:foodwifi/model/foodwifimodel.dart';
import 'package:foodwifi/router/router.gr.dart';
import 'package:foodwifi/widget/firstlistContainerSkeleton.dart';

class ImpahlMostFavouriteTastyTasteList extends StatelessWidget {
  final List<List<Item?>> firstitemlist;
  final List<FoodwifiModel> alldatalist;
  const ImpahlMostFavouriteTastyTasteList(
      {super.key, required this.firstitemlist, required this.alldatalist});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 7),
      child: Container(
        color: Colors.white,
        height: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 10),
              child: firstitemlist.isEmpty
                  ? const Skeleton(
                      radius: 15,
                      height: 280,
                      width: 350,
                    )
                  : Text(
                      "${alldatalist[2].title}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontStyle: FontStyle.italic),
                    ),
            ),
            Expanded(
              child: firstitemlist.isEmpty
                  ? const Center(
                      child: SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator()))
                  : GridView.builder(
                      controller: PageController(viewportFraction: 0.4),
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 2 / 1.2),
                      physics: const PageScrollPhysics()
                          .applyTo(const BouncingScrollPhysics()),
                      itemCount: firstitemlist[2].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            left: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.router.push(ProductUpperRoute(
                                    id: firstitemlist[2][index]!.id.toString(),
                                    title: firstitemlist[2][index]!
                                        .title
                                        .toString(),

                                    // the below parameter are  not used for this navigate ..it used for searchrestuarant page
                                    autoscroll: false,
                                    searcgcategoryname: '',
                                    finalindex: 0,
                                    products: null,

                                    // SearchRestuarentFilter(
                                    //   itemname: firstitemlist[2]
                                    //           [index]!
                                    //       .title
                                    //       .toString(),
                                    //   // only used for serach page navigate to searchrestuarentpage
                                    //   fromsearchonly: false,
                                    //   cusinesid: null,
                                    //   sortbyid: '',
                                    //   cusines: '',
                                    //   sortby: '',
                                    //   sorttypeid: '',
                                    //   storetypes: '',
                                    //   showresetbtn: false,
                                    //   checkcuisinesid: '',
                                    //   addcheckcuisinesdata: false,
                                    //   freedelery_id: '',
                                    //   halal_id: '',
                                    //   promo_id: '',
                                    //   freedeliverycolor: false,
                                    //   halalcolor: false,
                                    //   promocolor: false,
                                    // )
                                  ));
                                },
                                child: SizedBox(
                                  height: 140,
                                  width: 130,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: CachedNetworkImage(
                                        fadeInDuration:
                                            const Duration(seconds: 2),
                                        imageUrl:
                                            'https://globizs.sgp1.cdn.digitaloceanspaces.com/foodwifi/${firstitemlist[2][index]!.img}',
                                        fit: BoxFit.cover,
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) {
                                          return const Skeleton(
                                            radius: 30,
                                            height: 85,
                                            width: 80,
                                          );
                                        },
                                        errorWidget: (context, url, error) =>
                                            const Center(
                                                child: Text(
                                              "bad network",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 10),
                                            ))),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${firstitemlist[2][index]!.title}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Icon(
                                      Icons.favorite_border,
                                      size: 17,
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    size: 13,
                                    color: Color.fromARGB(255, 226, 209, 53),
                                  ),
                                  Text(
                                    "${firstitemlist[2][index]!.rating}",
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    "${firstitemlist[2][index]!.time}",
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    "${firstitemlist[2][index]!.distance}",
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
