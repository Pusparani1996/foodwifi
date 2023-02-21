import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:foodwifi/model/foodwifimodel.dart';
import 'package:foodwifi/pages/searchrestuarentfilter_page.dart';
import 'package:foodwifi/router/router.gr.dart';
import 'package:foodwifi/widget/firstlistContainerSkeleton.dart';

class NewOnFoodWifiHotelImolist extends StatelessWidget {
  final List<List<Item?>> firstitemlist;
  final List<FoodwifiModel> alldatalist;
  const NewOnFoodWifiHotelImolist(
      {super.key, required this.firstitemlist, required this.alldatalist});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 7),
      child: Container(
        color: Colors.white,
        height: 280,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 10),
              child: alldatalist.isEmpty
                  ? const CircularProgressIndicator()
                  : Row(
                      children: [
                        Text(
                          "${alldatalist[3].title}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontStyle: FontStyle.italic),
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
                        controller: PageController(viewportFraction: 0.75),
                        scrollDirection: Axis.horizontal,
                        physics: const PageScrollPhysics()
                            .applyTo(const BouncingScrollPhysics()),
                        itemCount: firstitemlist[3].length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              context.router.push(ProductUpperRoute(
                                id: firstitemlist[3][index]!.id.toString(),
                                title:
                                    firstitemlist[3][index]!.title.toString(),

                                // the below parameter are  not used for this navigate ..it used for searchrestuarant page
                                autoscroll: false,
                                searcgcategoryname: '',
                                finalindex: 0,
                                products: null,
                              ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20, left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 140,
                                    width: 140,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: CachedNetworkImage(
                                          fadeInDuration:
                                              const Duration(seconds: 2),
                                          imageUrl:
                                              'https://globizs.sgp1.cdn.digitaloceanspaces.com/foodwifi/${firstitemlist[3][index]!.img}',
                                          fit: BoxFit.cover,
                                          progressIndicatorBuilder:
                                              (context, url, downloadProgress) {
                                            return const Skeleton(
                                              radius: 20,
                                              height: 140,
                                              width: 140,
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "${firstitemlist[3][index]!.title}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    "${firstitemlist[3][index]!.description}",
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
                                      Text(
                                        "${firstitemlist[3][index]!.time}\t",
                                        style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 97, 120, 131)),
                                      ),
                                      Text(
                                        "${firstitemlist[3][index]!.distance}",
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
