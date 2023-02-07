import 'dart:developer';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodwifi/logic/cubit/fetchdata_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwifi/logic/searchrestuarentfilter/searchfilter_cubit.dart';
import 'package:foodwifi/model/foodwifimodel.dart';
import 'package:foodwifi/pages/search_page.dart';
import 'package:foodwifi/pages/searchrestuarentfilter_page.dart';
import 'package:foodwifi/router/router.gr.dart';
import 'package:foodwifi/widget/firstlistContainerSkeleton.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool pinned = true;
  bool snap = false;
  bool floating = false;

  var isLoading = false;

  List<List<Item?>> firstitemlist = [];
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  List animatedtextcopy = [
    "Momo",
    " Chiken Chou",
    "Pizza",
    " Biriyani",
    "Burger",
    "Paratha "
  ];
  String anitext = '';

  @override
  Widget build(BuildContext context) {
    final alldata = context.watch<FetchdataCubit>().state;
    // alldata.
    List<FoodwifiModel> alldatalist = alldata.alldata;

    firstitemlist = alldata.firstlistitems;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 227, 227),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                height: MediaQuery.of(context).size.height > 500
                    ? MediaQuery.of(context).size.height / 17
                    : MediaQuery.of(context).size.height / 8,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 17.5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Hi Pusparani",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Welcome back !",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: CircleAvatar(
                          radius: 11,
                          backgroundColor: Colors.red,
                          child: Center(
                            child: Icon(
                              Icons.favorite_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverLayoutBuilder(builder: (context, constraints) {
              var scrollvalue = constraints.scrollOffset;
              return SliverAppBar(
                backgroundColor: Colors.white,
                pinned: pinned,
                snap: snap,
                floating: floating,
                toolbarHeight: 103,

                // expandedHeight: 150.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 7.5),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Center(
                                child: Icon(
                                  Icons.location_on,
                                  size: 30,
                                  color: Colors.black,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'DELIVER TO',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    'RW4X + 9QR,Kyamgei,Nongpok Inkhol,Imphal,Manipur 79...',
                                    style: TextStyle(
                                      fontSize: 10.3,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 18,
                              ),
                              const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          // FOR SEZRCH TEXTFIELD
                          Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 241, 236, 236),
                                borderRadius: BorderRadius.circular(16)),
                            height: MediaQuery.of(context).size.height > 500
                                ? MediaQuery.of(context).size.height / 20
                                : MediaQuery.of(context).size.height / 10,
                            child: scrollvalue > 0
                                ? TextFormField(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const SearchPage(
                                              textvalue: 'What are you craving',
                                            ),
                                          ));
                                    },
                                    readOnly: true,
                                    decoration: InputDecoration(
                                        prefixIcon: Row(
                                          children: const [
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Icon(
                                              Icons.search_rounded,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text("What are you craving",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 175, 168, 168)))
                                          ],
                                        ),
                                        border: InputBorder.none),
                                  )
                                : TextFormField(
                                    onTap: () {
                                      var anidataindex =
                                          animatedtextcopy.indexOf(anitext);

                                      if (anidataindex <= 5) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SearchPage(
                                                  textvalue: animatedtextcopy[
                                                      anidataindex == 0
                                                          ? 0
                                                          : anidataindex + 1
                                                      //     ?
                                                      //     : 0
                                                      // <= 1 ||
                                                      //         anidataindex > 5
                                                      //     ? 0
                                                      //     : anidataindex + 1
                                                      ]),
                                            ));
                                      }
                                    },
                                    readOnly: true,
                                    decoration: InputDecoration(
                                        prefixIcon: Row(
                                          children: [
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            const Icon(
                                              Icons.search_rounded,
                                              color: Colors.grey,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            AnimatedTextKit(
                                              onTap: () {
                                                // var anidataindex =
                                                //     animatedtextcopy
                                                //         .indexOf(anitext);
                                                // Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //       builder: (context) => SearchPage(
                                                //           textvalue:
                                                //               animatedtextcopy[
                                                //                   anidataindex
                                                //                   >=
                                                //                           1
                                                //                       ? anidataindex -
                                                //                           1
                                                //                       : 0
                                                //                       ]),
                                                //     ));
                                              },
                                              onNext: (p0, p1) {
                                                setState(
                                                  () {
                                                    anitext =
                                                        animatedtextcopy[p0];
                                                  },
                                                );
                                              },
                                              pause: const Duration(seconds: 2),
                                              stopPauseOnTap: true,
                                              displayFullTextOnTap: true,
                                              repeatForever: true,
                                              animatedTexts: [
                                                TyperAnimatedText("Momo"),
                                                TyperAnimatedText(
                                                    " Chiken Chou"),
                                                TyperAnimatedText("Pizza"),
                                                TyperAnimatedText(" Biriyani"),
                                                TyperAnimatedText("Burger"),
                                                TyperAnimatedText("Paratha "),
                                              ],
                                            ),
                                          ],
                                        ),
                                        border: InputBorder.none),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Container(
                      color: Colors.white,
                      height: 280,
                      child: firstitemlist.isEmpty
                          // for lazy loading part not using lazy_loading package
                          ? const Skeleton(
                              radius: 15,
                              height: 280,
                              width: 350,
                            )
                          : ListView.builder(
                              controller:
                                  PageController(viewportFraction: 0.95),
                              scrollDirection: Axis.horizontal,
                              physics: const PageScrollPhysics()
                                  .applyTo(const BouncingScrollPhysics()),
                              itemCount: firstitemlist[0].length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(top: 35, left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 200,
                                        width: 330,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            fadeInDuration:
                                                const Duration(seconds: 1),
                                            imageUrl:
                                                'https://globizs.sgp1.cdn.digitaloceanspaces.com/foodwifi/${firstitemlist[0][index]!.img}',
                                            fit: BoxFit.cover,
                                            progressIndicatorBuilder: (context,
                                                url, downloadProgress) {
                                              return const Skeleton(
                                                radius: 10,
                                                height: 200,
                                                width: 330,
                                              );
                                            },
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${firstitemlist[0][index]!.title}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                  Padding(
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
                              controller:
                                  PageController(viewportFraction: 0.95),
                              //shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const PageScrollPhysics()
                                  .applyTo(const BouncingScrollPhysics()),
                              itemCount: firstitemlist[1].length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(top: 35, left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 77,
                                        width: 82,
                                        child: CachedNetworkImage(
                                            fadeInDuration:
                                                const Duration(seconds: 2),
                                            imageUrl:
                                                'https://globizs.sgp1.cdn.digitaloceanspaces.com/foodwifi/${firstitemlist[1][index]!.img}',
                                            fit: BoxFit.cover,
                                            progressIndicatorBuilder: (context,
                                                url, downloadProgress) {
                                              return const Skeleton(
                                                radius: 15,
                                                height: 70,
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
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "${firstitemlist[1][index]!.title}",
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                  Padding(
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
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                        "${alldatalist[2].title}",
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
                                          backgroundColor: Color.fromARGB(
                                              255, 233, 232, 232),
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
                                      controller: PageController(
                                          viewportFraction: 0.75),
                                      //shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: const PageScrollPhysics()
                                          .applyTo(
                                              const BouncingScrollPhysics()),
                                      itemCount: firstitemlist[2].length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, left: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    context.router
                                                        .push(ProductUpperRoute(
                                                      id: firstitemlist[2]
                                                              [index]!
                                                          .id
                                                          .toString(),
                                                      title: firstitemlist[2]
                                                              [index]!
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
                                                  child: SizedBox(
                                                    height: 120,
                                                    width: 210,
                                                    child: Stack(
                                                      fit: StackFit.expand,
                                                      children: [
                                                        CachedNetworkImage(
                                                            fadeInDuration:
                                                                const Duration(
                                                                    seconds: 2),
                                                            imageUrl:
                                                                'https://globizs.sgp1.cdn.digitaloceanspaces.com/foodwifi/${firstitemlist[2][index]!.img}',
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
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                const Center(
                                                                    child: Text(
                                                                  "bad network",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                      fontSize:
                                                                          10),
                                                                ))),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const SizedBox(
                                                              height: 14,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 8),
                                                              child: firstitemlist[2]
                                                                              [
                                                                              index]!
                                                                          .offerDescription ==
                                                                      ""
                                                                  ? Container()
                                                                  : Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        color: const Color.fromARGB(
                                                                            255,
                                                                            17,
                                                                            153,
                                                                            106),
                                                                      ),
                                                                      height:
                                                                          20,
                                                                      width:
                                                                          120,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          const SizedBox(
                                                                            width:
                                                                                3,
                                                                          ),
                                                                          Transform.rotate(
                                                                              angle: 20.7,
                                                                              child: const Icon(
                                                                                Icons.local_offer,
                                                                                color: Colors.white,
                                                                                size: 12,
                                                                              )),
                                                                          Text(
                                                                            "${firstitemlist[2][index]!.offerDescription}",
                                                                            style:
                                                                                const TextStyle(color: Colors.white, fontSize: 12),
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
                                                "${firstitemlist[2][index]!.title}",
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                "${firstitemlist[2][index]!.description}",
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Color.fromARGB(
                                                        255, 131, 130, 130)),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    size: 13,
                                                    color: Color.fromARGB(
                                                        255, 226, 209, 53),
                                                  ),
                                                  Text(
                                                    "${firstitemlist[2][index]!.rating}\t",
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 97, 120, 131)),
                                                  ),
                                                  Text(
                                                    "${firstitemlist[2][index]!.time}\t",
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 97, 120, 131)),
                                                  ),
                                                  Text(
                                                    "${firstitemlist[2][index]!.distance}",
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                  ),
                  Padding(
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
                                    "${alldatalist[3].title}",
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
                                              crossAxisCount: 2,
                                              childAspectRatio: 1 / 0.65),
                                      // physics: NeverScrollableScrollPhysics(),
                                      physics: const PageScrollPhysics()
                                          .applyTo(
                                              const BouncingScrollPhysics()),

                                      scrollDirection: Axis.horizontal,
                                      itemCount: firstitemlist[3].length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            top: 20,
                                            left: 10,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              SearchRestuarentFilter(
                                                                itemname: firstitemlist[
                                                                            3]
                                                                        [index]!
                                                                    .title
                                                                    .toString(),
                                                              )));
                                                },
                                                child: SizedBox(
                                                  height: 85,
                                                  width: 80,
                                                  child: CachedNetworkImage(
                                                      fadeInDuration:
                                                          const Duration(
                                                              seconds: 2),
                                                      imageUrl:
                                                          'https://globizs.sgp1.cdn.digitaloceanspaces.com/foodwifi/${firstitemlist[3][index]!.img}',
                                                      fit: BoxFit.cover,
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                              downloadProgress) {
                                                        return const Skeleton(
                                                          radius: 30,
                                                          height: 85,
                                                          width: 80,
                                                        );
                                                      },
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Center(
                                                              child: Text(
                                                            "bad network",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 10),
                                                          ))),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "${firstitemlist[3][index]!.title}",
                                                  style: const TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 10),
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
                  ),
                  //item 5
                  Padding(
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
                                        "${alldatalist[4].title}",
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
                                      controller: PageController(
                                          viewportFraction: 0.75),
                                      //shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: const PageScrollPhysics()
                                          .applyTo(
                                              const BouncingScrollPhysics()),

                                      itemCount: firstitemlist[4].length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            context.router
                                                .push(ProductUpperRoute(
                                              id: firstitemlist[4][index]!
                                                  .id
                                                  .toString(),
                                              title: firstitemlist[4][index]!
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
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20, left: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 140,
                                                  width: 140,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: CachedNetworkImage(
                                                        fadeInDuration:
                                                            const Duration(
                                                                seconds: 2),
                                                        imageUrl:
                                                            'https://globizs.sgp1.cdn.digitaloceanspaces.com/foodwifi/${firstitemlist[4][index]!.img}',
                                                        fit: BoxFit.cover,
                                                        progressIndicatorBuilder:
                                                            (context, url,
                                                                downloadProgress) {
                                                          return const Skeleton(
                                                            radius: 20,
                                                            height: 140,
                                                            width: 140,
                                                          );
                                                        },
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Center(
                                                                child: Text(
                                                              "bad network",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 10),
                                                            ))),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "${firstitemlist[4][index]!.title}",
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  "${firstitemlist[4][index]!.description}",
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      color: Color.fromARGB(
                                                          255, 131, 130, 130)),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${firstitemlist[4][index]!.time}\t",
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              97,
                                                              120,
                                                              131)),
                                                    ),
                                                    Text(
                                                      "${firstitemlist[4][index]!.distance}",
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              97,
                                                              120,
                                                              131)),
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
                  ),
                  //item 6
                  Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Container(
                      color: Colors.white,
                      height: 310,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 10),
                            child: alldatalist.isEmpty
                                ? const CircularProgressIndicator()
                                : Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "${alldatalist[5].title}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    fontStyle:
                                                        FontStyle.italic),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const CircleAvatar(
                                                  radius: 10,
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 233, 232, 232),
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
                                            "${alldatalist[5].description}",
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
                                      controller: PageController(
                                          viewportFraction: 0.75),
                                      //shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: const PageScrollPhysics()
                                          .applyTo(
                                              const BouncingScrollPhysics()),

                                      itemCount: firstitemlist[5].length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            context.router
                                                .push(ProductUpperRoute(
                                              id: firstitemlist[5][index]!
                                                  .id
                                                  .toString(),
                                              title: firstitemlist[5][index]!
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
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20, left: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 140,
                                                  width: 249,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: CachedNetworkImage(
                                                        fadeInDuration:
                                                            const Duration(
                                                                seconds: 2),
                                                        imageUrl:
                                                            'https://globizs.sgp1.cdn.digitaloceanspaces.com/foodwifi/${firstitemlist[5][index]!.img}',
                                                        fit: BoxFit.cover,
                                                        progressIndicatorBuilder:
                                                            (context, url,
                                                                downloadProgress) {
                                                          return const Skeleton(
                                                            radius: 20,
                                                            height: 140,
                                                            width: 249,
                                                          );
                                                        },
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Center(
                                                                child: Text(
                                                              "bad network",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 10),
                                                            ))),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${firstitemlist[5][index]!.title}",
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black87,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      width: 130,
                                                    ),
                                                    const Icon(
                                                      Icons.favorite_outline,
                                                      size: 18,
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  firstitemlist[5][index]!
                                                              .description !=
                                                          null
                                                      ? "${firstitemlist[5][index]!.description}"
                                                      : "",
                                                  style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Color.fromARGB(
                                                        255, 131, 130, 130),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.star,
                                                      size: 13,
                                                      color: Color.fromARGB(
                                                          255, 226, 209, 53),
                                                    ),
                                                    Text(
                                                      "${firstitemlist[5][index]!.rating}\t",
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              97,
                                                              120,
                                                              131)),
                                                    ),
                                                    Text(
                                                      "${firstitemlist[5][index]!.time}\t",
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              97,
                                                              120,
                                                              131)),
                                                    ),
                                                    Text(
                                                      "${firstitemlist[5][index]!.distance}",
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              97,
                                                              120,
                                                              131)),
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
                  ),
                  //item 7
                  Padding(
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
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "${alldatalist[6].title}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    fontStyle:
                                                        FontStyle.italic),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const CircleAvatar(
                                                  radius: 10,
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 233, 232, 232),
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
                                      controller: PageController(
                                          viewportFraction: 0.75),
                                      //shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: const PageScrollPhysics()
                                          .applyTo(
                                              const BouncingScrollPhysics()),

                                      itemCount: firstitemlist[6].length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            context.router
                                                .push(ProductUpperRoute(
                                              id: firstitemlist[6][index]!
                                                  .id
                                                  .toString(),
                                              title: firstitemlist[6][index]!
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
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20, left: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 140,
                                                  width: 249,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: CachedNetworkImage(
                                                        fadeInDuration:
                                                            const Duration(
                                                                seconds: 2),
                                                        imageUrl:
                                                            'https://globizs.sgp1.cdn.digitaloceanspaces.com/foodwifi/${firstitemlist[6][index]!.img}',
                                                        fit: BoxFit.cover,
                                                        progressIndicatorBuilder:
                                                            (context, url,
                                                                downloadProgress) {
                                                          return const Skeleton(
                                                            radius: 20,
                                                            height: 140,
                                                            width: 249,
                                                          );
                                                        },
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Center(
                                                                child: Text(
                                                              "bad network",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 10),
                                                            ))),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "${firstitemlist[6][index]!.title}",
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  "${firstitemlist[6][index]!.description}",
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      color: Color.fromARGB(
                                                          255, 131, 130, 130)),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.star,
                                                      size: 13,
                                                      color: Color.fromARGB(
                                                          255, 226, 209, 53),
                                                    ),
                                                    Text(
                                                      "${firstitemlist[6][index]!.rating}\t",
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              97,
                                                              120,
                                                              131)),
                                                    ),
                                                    Text(
                                                      "${firstitemlist[6][index]!.time}\t",
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              97,
                                                              120,
                                                              131)),
                                                    ),
                                                    Text(
                                                      "${firstitemlist[6][index]!.distance}",
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              97,
                                                              120,
                                                              131)),
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
                  ),
                  //item 8
                  Padding(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "${alldatalist[7].title}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    fontStyle:
                                                        FontStyle.italic),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const CircleAvatar(
                                                  radius: 10,
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 233, 232, 232),
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
                                            "${alldatalist[7].description}",
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
                                      controller: PageController(
                                          viewportFraction: 0.90),
                                      //shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: const PageScrollPhysics()
                                          .applyTo(
                                              const BouncingScrollPhysics()),

                                      itemCount: firstitemlist[7].length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            context.router
                                                .push(ProductUpperRoute(
                                              id: firstitemlist[7][index]!
                                                  .id
                                                  .toString(),
                                              title: firstitemlist[7][index]!
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
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20, left: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    height: 180,
                                                    width: 330,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: Stack(
                                                        fit: StackFit.expand,
                                                        children: [
                                                          CachedNetworkImage(
                                                              fadeInDuration:
                                                                  const Duration(
                                                                      seconds:
                                                                          2),
                                                              imageUrl:
                                                                  'https://globizs.sgp1.cdn.digitaloceanspaces.com/foodwifi/${firstitemlist[7][index]!.img}',
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
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  const Center(
                                                                      child:
                                                                          Text(
                                                                    "bad network",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red,
                                                                        fontSize:
                                                                            10),
                                                                  ))),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 0,
                                                                    bottom: 0),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                SizedBox(
                                                                  height: 90,
                                                                  // width: 330,
                                                                  child: Card(
                                                                    color: const Color
                                                                            .fromARGB(
                                                                        0,
                                                                        1,
                                                                        0,
                                                                        0),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.stretch,
                                                                        children: [
                                                                          Text(
                                                                            "${firstitemlist[7][index]!.title}",
                                                                            style: const TextStyle(
                                                                                fontSize: 23,
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                3,
                                                                          ),
                                                                          Text(
                                                                            "${firstitemlist[7][index]!.description}",
                                                                            style:
                                                                                const TextStyle(fontSize: 13, color: Colors.white),
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                3,
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Text(
                                                                                "${firstitemlist[7][index]!.time}\t",
                                                                                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                                                              ),
                                                                              Text(
                                                                                "${firstitemlist[7][index]!.distance}",
                                                                                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                                                              ),
                                                                              const Icon(
                                                                                Icons.star,
                                                                                size: 13,
                                                                                color: Color.fromARGB(255, 226, 209, 53),
                                                                              ),
                                                                              Text(
                                                                                "${firstitemlist[7][index]!.rating}",
                                                                                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
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
                  ),
                  //item 9
                  Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Container(
                      color: Colors.white,
                      height: 310,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 10),
                            child: alldatalist.isEmpty
                                ? const CircularProgressIndicator()
                                : Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "${alldatalist[8].title}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    fontStyle:
                                                        FontStyle.italic),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const CircleAvatar(
                                                  radius: 10,
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 233, 232, 232),
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
                                            "${alldatalist[8].description}",
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
                                      controller: PageController(
                                          viewportFraction: 0.72),
                                      //shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: const PageScrollPhysics()
                                          .applyTo(
                                              const BouncingScrollPhysics()),

                                      itemCount: firstitemlist[8].length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            context.router
                                                .push(ProductUpperRoute(
                                              id: firstitemlist[8][index]!
                                                  .id
                                                  .toString(),
                                              title: firstitemlist[8][index]!
                                                  .title
                                                  .toString(),
                                              // the below parameter are  not used for this navigate ..it used for searchrestuarant page
                                              autoscroll: false,
                                              searcgcategoryname: '',
                                              finalindex: 0,
                                              products: null,
                                            ));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20, left: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 140,
                                                  width: 249,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: CachedNetworkImage(
                                                        fadeInDuration:
                                                            const Duration(
                                                                seconds: 2),
                                                        imageUrl:
                                                            'https://globizs.sgp1.cdn.digitaloceanspaces.com/foodwifi/${firstitemlist[8][index]!.img}',
                                                        fit: BoxFit.cover,
                                                        progressIndicatorBuilder:
                                                            (context, url,
                                                                downloadProgress) {
                                                          return const Skeleton(
                                                            radius: 15,
                                                            height: 140,
                                                            width: 249,
                                                          );
                                                        },
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Center(
                                                                child: Text(
                                                              "bad network",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 10),
                                                            ))),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${firstitemlist[8][index]!.title}",
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black87,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      width: 70,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: const [
                                                            Icon(
                                                              Icons
                                                                  .favorite_outline,
                                                              size: 18,
                                                            ),
                                                            SizedBox(
                                                              width: 60,
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  firstitemlist[8][index]!
                                                              .description !=
                                                          null
                                                      ? "${firstitemlist[8][index]!.description}"
                                                      : "",
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.star,
                                                      size: 13,
                                                      color: Color.fromARGB(
                                                          255, 226, 209, 53),
                                                    ),
                                                    Text(
                                                      "${firstitemlist[8][index]!.rating}\t",
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              97,
                                                              120,
                                                              131)),
                                                    ),
                                                    Text(
                                                      "${firstitemlist[8][index]!.time}\t",
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              97,
                                                              120,
                                                              131)),
                                                    ),
                                                    Text(
                                                      "${firstitemlist[8][index]!.distance}",
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              97,
                                                              120,
                                                              131)),
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
