import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:foodwifi/model/foodwifimodel.dart';
import 'package:foodwifi/pages/searchrestuarentfilter_page.dart';
import 'package:foodwifi/widget/firstlistContainerSkeleton.dart';

class FoodNearYouListPage extends StatelessWidget {
  final List<List<Item?>> firstitemlist;
  const FoodNearYouListPage({super.key, required this.firstitemlist});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 7),
      child: Container(
        color: Colors.white,
        height: 150,
        child: firstitemlist.isEmpty
            // for lazy loading part not using lazy_loading package
            ? const Skeleton(
                radius: 15,
                height: 280,
                width: 350,
              )
            : ListView.builder(
                controller: PageController(viewportFraction: 0.95),
                //shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const PageScrollPhysics()
                    .applyTo(const BouncingScrollPhysics()),
                itemCount: firstitemlist[0].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 35, left: 10),
                    child: InkWell(
                      onTap: () {
                        if (index == 3) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchRestuarentFilter(
                                        itemname: firstitemlist[0][3]!
                                            .keyword
                                            .toString(),
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
                        } else if (index == 0) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchRestuarentFilter(
                                        itemname: "",
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
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchRestuarentFilter(
                                        itemname: firstitemlist[0][index]!
                                            .title
                                            .toString(),
                                        fromsearchonly: false,
                                        cusinesid: "Store types",
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
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 77,
                            width: 82,
                            child: CachedNetworkImage(
                                fadeInDuration: const Duration(seconds: 2),
                                imageUrl:
                                    'https://globizs.sgp1.cdn.digitaloceanspaces.com/foodwifi/${firstitemlist[0][index]!.img}',
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) {
                                  return const Skeleton(
                                    radius: 15,
                                    height: 70,
                                    width: 85,
                                  );
                                },
                                errorWidget: (context, url, error) =>
                                    const Center(
                                        child: Text(
                                      "bad network",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 10),
                                    ))),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              "${firstitemlist[0][index]!.title}",
                              style: const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
