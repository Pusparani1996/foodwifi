import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwifi/logic/belowpart/belowpart_cubit.dart';
import 'package:foodwifi/logic/belowpart/belowpart_state.dart';
import 'package:foodwifi/logic/upperpart/upperpart_cubit.dart';
import 'package:foodwifi/model/categorymodel.dart';
import 'package:foodwifi/model/upperpartmodel.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({
    super.key,
    required this.id,
    //  required this.img,
    required this.title,
    //  required this.rating,
    //  required this.time,
    //   required this.distance,
    //   //required this.note,
    //   required this.description
  });

  final String id;
  // final String img;
  final String title;
  // final String rating;
  // final String time;
  // final String distance;
  // //final String note;
  // final String description;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  UpperPartModel? upalldatalist;
  List<CategoryModel?>? belowdatalist;
  bool light = true;
  ScrollController scrollcontroller = ScrollController();
  bool showcontaineratappbar = false;
  var allowForward = true;
  var allowReverse = true;
  double scrolloffset = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getupdata();
    scrollcontroller.addListener(() {
      scrolllisner();
    });
  }

  void scrolllisner() {
    if (scrollcontroller.hasClients && scrollcontroller.offset > 555) {
      setState(() {
        showcontaineratappbar = true;
      });
    } else {
      setState(() {
        showcontaineratappbar = false;
      });
      scrolloffset = scrollcontroller.offset;
    }
  }

  getupdata() async {
    var alldata = await context.read<UpperPartCubit>().uppergetalldata(
          id: widget.id,
        );
    var belowdata =
        await context.read<BellowDataCubit>().belowgetalldata(id: widget.id);
    setState(() {
      upalldatalist = alldata;
      //belowdatalist = belowdata;
      log(widget.id);
    });
  }

  Widget build(BuildContext context) {
    final belowpartlist = context.watch<BellowDataCubit>().state;
    List<CategoryModel?>? belowdatalist = belowpartlist.belowalldata;

    return Scaffold(
      body: upalldatalist == null
          ? Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height > 500
                        ? MediaQuery.of(context).size.height / 2
                        : MediaQuery.of(context).size.height / 2,
                  ),
                  const Text(
                    "Serving your is our pleasure",
                    style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                  ),
                  Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.blueGrey,
                    size: 20,
                  )),
                ],
              ),
            )
          : Stack(children: [
              SizedBox(
                child: Column(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height > 500
                            ? MediaQuery.of(context).size.height / 3.2
                            : MediaQuery.of(context).size.height / 1.4,
                        width: MediaQuery.of(context).size.width > 500
                            ? MediaQuery.of(context).size.width
                            : MediaQuery.of(context).size.width,
                        child: Image.network(
                          "https://globizs.sgp1.cdn.digitaloceanspaces.com/foodwifi/${upalldatalist!.img}",
                          fit: BoxFit.cover,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 55, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.black45,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 9),
                          child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.black45,
                      child: Center(
                        child: IconButton(
                            onPressed: () => context.router.pop(),
                            icon: const Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 170,
                left: 0,
                right: 0,
                bottom: 0,
                child: SingleChildScrollView(
                  controller: scrollcontroller,
                  clipBehavior: Clip.none,
                  child: SizedBox(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Card(
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: SizedBox(
                              child: Column(
                                children: [
                                  SizedBox(
                                    //height: 250,
                                    width:
                                        MediaQuery.of(context).size.width / 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, top: 25, bottom: 4),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            upalldatalist!.title.toString(),
                                            style: const TextStyle(
                                                fontSize: 23,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            upalldatalist!.description
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            upalldatalist!.address.toString(),
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          SizedBox(
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  size: 13,
                                                  color: Color.fromARGB(
                                                      255, 226, 209, 53),
                                                ),
                                                Text(
                                                  "${upalldatalist!.rating}\t",
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                Text(
                                                  "(${upalldatalist!.ratingCount}+\tratings)",
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                Text(
                                                  "${upalldatalist!.time}\t",
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey),
                                                ),
                                                Text(
                                                  "${upalldatalist!.distance}",
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 3.5,
                                          ),
                                          SizedBox(
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                    height: 20,
                                                    width: 50,
                                                    child: Image.asset(
                                                      "assets/images/Fssai.png",
                                                      fit: BoxFit.cover,
                                                    )),
                                                const Text("\tLic.\tNo.",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.grey)),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10, bottom: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 241, 236, 236),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              height: MediaQuery.of(context)
                                                          .size
                                                          .height >
                                                      500
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      20
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      10,
                                              width: 400,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 13),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                      upalldatalist!.notices![0]
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.grey)),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          //height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 12),
                                child: Image.asset("assets/images/burger.jpg"),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 15),
                                child: Row(
                                  children: [
                                    Switch(
                                      value: light,
                                      activeColor:
                                          Color.fromARGB(255, 72, 217, 77),
                                      onChanged: (bool value) {
                                        setState(() {
                                          light = value;
                                        });
                                      },
                                    ),
                                    const Text(
                                      "Veg only",
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: const Color.fromARGB(255, 235, 238, 239),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: belowdatalist!.length,
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
                                            padding: const EdgeInsets.only(
                                                left: 0, top: 9, bottom: 8),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                belowdatalist[index]!
                                                    .categoryName
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                          ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: belowdatalist[index]!
                                                .products
                                                ?.length,
                                            itemBuilder:
                                                (context, productindex) {
                                              return
                                                  // Column(
                                                  //   children: [

                                                  Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8),
                                                child: SizedBox(
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                              child: belowdatalist[
                                                                          index]!
                                                                      .products![
                                                                          productindex]!
                                                                      .img!
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
                                                                            color:
                                                                                Colors.white.withOpacity(0.2),
                                                                            colorBlendMode:
                                                                                BlendMode.modulate,
                                                                          )),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              15,
                                                                          width:
                                                                              20,
                                                                          child: Image.asset(belowdatalist[index]!.products![productindex]!.type == "non_veg"
                                                                              ? "assets/images/non-veg.png"
                                                                              : "assets/images/veg.jpg"),
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
                                                                          child:
                                                                              Image.network(
                                                                            "https://globizs.sgp1.cdn.digitaloceanspaces.com/foodwifi/${belowdatalist[index]!.products![productindex]!.img}",
                                                                            height:
                                                                                90,
                                                                            width:
                                                                                90,
                                                                            fit:
                                                                                BoxFit.fill,
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
                                                                            child: Image.asset(belowdatalist[index]!.products![productindex]!.type == "non_veg"
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
                                                                Text(belowdatalist[
                                                                        index]!
                                                                    .products![
                                                                        productindex]!
                                                                    .name
                                                                    .toString()),
                                                                SizedBox(
                                                                  width: 200,
                                                                  child: Text(
                                                                    belowdatalist[
                                                                            index]!
                                                                        .products![
                                                                            productindex]!
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
                                                                        "₹${belowdatalist[index]!.products![productindex]!.price}",
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black87,
                                                                            decoration: TextDecoration.lineThrough),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            7,
                                                                      ),
                                                                      SizedBox(
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text(
                                                                              maxLines: 3,
                                                                              "₹${belowdatalist[index]!.products![productindex]!.offer!.offerPrice}",
                                                                              style: const TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: MediaQuery.of(context).size.width / 17,
                                                                            ),
                                                                            Container(
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
                                                                                      belowdatalist[index]!.products![productindex]!.offer!.description.toString(),
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
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              showcontaineratappbar
                  ? Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 25.0,
                          )
                        ],
                      ),
                      height: 120,
                      child: SafeArea(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back_ios,
                                        color:
                                            Color.fromARGB(255, 180, 176, 176),
                                      )),
                                  const Text("Taj Kiraj"),
                                  const SizedBox(
                                    width: 210,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.favorite_outline,
                                          color: Color.fromARGB(
                                              255, 196, 202, 208))),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 230,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color:
                                            Color.fromARGB(255, 236, 242, 243)),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(left: 15),
                                            child: Text("Momo"),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Center(
                                              child: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ]),
                                  ),
                                  Container(
                                    width: 86,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color.fromARGB(255, 236, 242, 243),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: Row(children: const [
                                        Icon(Icons.search_outlined,
                                            size: 16, color: Colors.black),
                                        Text(
                                          "Search",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : const SizedBox()
            ]),
    );
  }
}
