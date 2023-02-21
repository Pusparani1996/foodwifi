import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:foodwifi/model/foodwifimodel.dart';
import 'package:foodwifi/pages/searchrestuarentfilter_page.dart';
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
        height: 320,
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
              child: Container(
                child: firstitemlist.isEmpty
                    ? const Center(
                        child: SizedBox(
                            height: 15,
                            width: 15,
                            child: CircularProgressIndicator()))
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 1 / 0.65),
                        physics: const PageScrollPhysics()
                            .applyTo(const BouncingScrollPhysics()),
                        scrollDirection: Axis.horizontal,
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SearchRestuarentFilter(
                                                  itemname: firstitemlist[2]
                                                          [index]!
                                                      .title
                                                      .toString(),
                                                  // only used for serach page navigate to searchrestuarentpage
                                                  fromsearchonly: false,
                                                  cusinesid: null,
                                                  sortbyid: '',
                                                  cusines: '',
                                                  sortby: '',
                                                  sorttypeid: '',
                                                  storetypes: '',
                                                  showresetbtn: false,
                                                  checkcuisinesid: '',
                                                  addcheckcuisinesdata: false,
                                                  freedelery_id: '',
                                                  halal_id: '',
                                                  promo_id: '',
                                                  freedeliverycolor: false,
                                                  halalcolor: false,
                                                  promocolor: false,
                                                )));
                                  },
                                  child: SizedBox(
                                    height: 85,
                                    width: 80,
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
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${firstitemlist[2][index]!.title}",
                                    style: const TextStyle(
                                        color: Colors.black54, fontSize: 10),
                                  ),
                                ),
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
