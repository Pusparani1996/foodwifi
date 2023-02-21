import 'dart:developer';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_route/auto_route.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodwifi/homedatalist/imphalmostfavourite.dart';
import 'package:foodwifi/homedatalist/newonfoodwifi.dart';
import 'package:foodwifi/homedatalist/offerforyou_tajkira.dart';
import 'package:foodwifi/homedatalist/supportlocalfavourite.dart';
import 'package:foodwifi/logic/cubit/fetchdata_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwifi/logic/home_search/homesearch_cubit.dart';
import 'package:foodwifi/logic/search/search_cubit.dart';
import 'package:foodwifi/logic/searchrestuarentfilter/searchfilter_cubit.dart';

import 'package:foodwifi/model/foodwifimodel.dart';

import 'package:foodwifi/homedatalist/foodnearyou.dart';
import 'package:foodwifi/homedatalist/belowhomeone.dart';
import 'package:foodwifi/model/home_search_model.dart';
import 'package:foodwifi/model/searchModel.dart';
import 'package:foodwifi/pages/cusinoesPage.dart';

import 'package:foodwifi/pages/search_page.dart';

import 'package:foodwifi/pages/storetypespage.dart';

import 'package:foodwifi/router/router.gr.dart';

import '../logic/home_search/homesearch_state.dart';

class HomePage extends StatefulWidget {
  final String cuisines;
  final String sortby;
  final String storetype;
  final String cuisinesid;
  final String sortbyid;
  final String storetypeid;
  // final List<dynamic> radiostoretypeidlist;

  const HomePage({
    super.key,
    required this.cuisines,
    required this.sortby,
    required this.storetype,
    required this.cuisinesid,
    required this.sortbyid,
    required this.storetypeid,
    //required this.radiostoretypeidlist,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool pinned = true;
  bool snap = false;
  bool floating = false;
  bool showbelowhomesearch = false;

  var isLoading = false;

  List<List<Item?>> firstitemlist = [];
  List<Items?> homebelowdara = [];

  late AnimationController controller;
  String sortbyid = '';
  String storetypeid = "";
  String cuisinesid = "";
  // late Status homesearchstatus;
  List<dynamic> radiostoretypeidlist = [];

  List<dynamic> radiostoretype = [];
  List radiostoretypelist = [];
  List cuisinesitems = [];
  List<Cuisine> cuisinesdata = [];
  List cuisinesidkey = [];

  Map checkcuisinesidandname = {};

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    context.read<HomeSearchCubit>().gethomesearch(sortbyid: sortbyid);
  }

  List animatedtextcopy = [
    "Momo",
    " Chow",
    "Pizza",
    " Biriyani",
    "Burger",
    "Paratha "
  ];

  List tabbar = [
    "Sort by",
    "Cuisines",
    "Store types",
    "Free delivery",
    "Halal",
    "Promo",
  ];
  String anitext = '';
  Future<void> navigatetosortby(
      BuildContext context, void Function(void Function()) setState) async {
    final result = await context.router.push(SortByRoute(
      cusines: widget.cuisines,
      storetypes: widget.storetype,
      showsearchrestuarent: false,
      abovetxt: "",
      showresetbtn: true,
      freedelivery: "",
      showbelowhomesearch: true,
      cuisinesid: cuisinesid,
      storetypeid: storetypeid,
      halal: '',
      promo: '',
    ));
    if (result != null) {
      context.read<HomeSearchCubit>().gethomesearch(
          sortbyid: result.toString(),
          cuisinesid: cuisinesid,
          storetypeid: storetypeid);
      setState(
        () {
          sortbyid = result.toString();
        },
      );

      print(sortbyid.toString());
    }
  }

  Future<void> navigatetocuisines(
    BuildContext context,
    void Function(void Function()) setState,
  ) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CusinesPage(
            cusines: widget.cuisines,
            storetypes: widget.storetype,
            showsearchrestuarent: false,
            abovetxt: "",
            sortby: widget.sortby,
            showresetbtn: true,
            checkcuisines: checkcuisinesidandname,
            cuisinesitems: cuisinesitems,
            freedilivery: "",
            cuisinesid: cuisinesid,
            showbelowhomesearch: true,
            allcuisines: cuisinesid,
          ),
        ));
    if (result != null) {
      context
          .read<HomeSearchCubit>()
          .gethomesearch(allcuisions: result.toString());
      setState(
        () {
          cuisinesid = result.toString();
        },
      );

      print(cuisinesid.toString());
    }
  }

  Future<void> navigatetostoretypes(
    BuildContext context,
    void Function(void Function()) setState,
  ) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StoreTypesPage(
            cusines: widget.cuisines,
            storetypes: widget.storetype,
            showsearchrestuarent: false,
            abovetxt: "",
            sortby: widget.sortby,
            showresetbtn: true,
            freedilivery: "",
            radiostoretypeidlist: radiostoretype,
            storetypeid: storetypeid,
            showbelowhomesearch: true,
          ),
        ));
    if (result != null) {
      context.read<HomeSearchCubit>().gethomesearch(
          storetypeid: result.toString(),
          cuisinesid: cuisinesid,
          sortbyid: sortbyid);
      setState(
        () {
          storetypeid = result.toString();
        },
      );

      print(storetypeid.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final alldata = context.watch<FetchdataCubit>().state;
    final homesearchdata = context.watch<HomeSearchCubit>().state;
    final searcgstatus = context.watch<SearcgCubit>().state;

    List<FoodwifiModel> alldatalist = alldata.alldata;

    firstitemlist = alldata.firstlistitems;
    radiostoretype = searcgstatus.radiostoretypelist;
    cuisinesidkey = searcgstatus.cuisinesidkey;
    cuisinesitems = searcgstatus.cuisinesitems;
    checkcuisinesidandname = searcgstatus.checkcuisinesidandname;

    // var homesearchstatus = homesearchdata.homesatatus;
    if (homesearchdata.alldata != null) {
      homebelowdara = homesearchdata.alldata!.items;
    }

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
                toolbarHeight: scrollvalue >= 1590 ? 141 : 103,

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
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 241, 236, 236),
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
                                                  textvalue:
                                                      'What are you craving',
                                                  cusines: '',
                                                  // showsearchrestuarent: true,
                                                  storetypes: '',
                                                  sortbyid: '',
                                                  sortby: '',
                                                  showsortby: false,
                                                  fromsortshoerestuarent: false,
                                                  cuisinesid: '',
                                                  storetypeid: '',
                                                  resetdata: false,
                                                  checkcuisinesname: '',
                                                  addcheckcuisinesdata: false,
                                                  freedelivery: '',
                                                  freedeliveryid: '',
                                                  halal: '',
                                                  promoid: '',
                                                  freedeliverycolor: false,
                                                  halalcolor: false,
                                                  promocolor: false,
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
                                                            255,
                                                            175,
                                                            168,
                                                            168)))
                                              ],
                                            ),
                                            border: InputBorder.none),
                                      )
                                    : TextFormField(
                                        readOnly: true,
                                        onTap: () {
                                          var anidataindex =
                                              animatedtextcopy.indexOf(anitext);

                                          if (anidataindex <= 5) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SearchPage(
                                                    textvalue: animatedtextcopy[
                                                        anidataindex > 4
                                                            ? 0
                                                            : anidataindex + 1],
                                                    cusines: '',
                                                    //  showsearchrestuarent: true,
                                                    storetypes: '',
                                                    sortbyid: '',
                                                    sortby: '',
                                                    showsortby: false,
                                                    fromsortshoerestuarent:
                                                        false,
                                                    cuisinesid: '',
                                                    storetypeid: '',
                                                    resetdata: false,
                                                    checkcuisinesname: '',
                                                    addcheckcuisinesdata: false,
                                                    freedelivery: '',
                                                    freedeliveryid: '',
                                                    halal: '',
                                                    promoid: '',
                                                    freedeliverycolor: false,
                                                    halalcolor: false,
                                                    promocolor: false,
                                                  ),
                                                ));
                                          }
                                        },
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
                                                  onNext: (p0, p1) {
                                                    setState(
                                                      () {
                                                        anitext =
                                                            animatedtextcopy[
                                                                p0];
                                                      },
                                                    );
                                                  },
                                                  pause: const Duration(
                                                      seconds: 2),
                                                  stopPauseOnTap: true,
                                                  displayFullTextOnTap: true,
                                                  repeatForever: true,
                                                  animatedTexts: [
                                                    TyperAnimatedText("Momo"),
                                                    TyperAnimatedText(" Chow"),
                                                    TyperAnimatedText("Pizza"),
                                                    TyperAnimatedText(
                                                        " Biriyani"),
                                                    TyperAnimatedText("Burger"),
                                                    TyperAnimatedText(
                                                        "Paratha "),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            border: InputBorder.none),
                                      ),
                              ),

                              // TAB BAR
                              scrollvalue >= 1590
                                  ? Container(
                                      // height: 100,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: SizedBox(
                                          height: 30,
                                          child: StatefulBuilder(builder:
                                              (BuildContext context,
                                                  void Function(void Function())
                                                      setState) {
                                            return ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: tabbar.length,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    if (index == 0) {
                                                      navigatetosortby(
                                                          context, setState);
                                                    } else if (index == 1) {
                                                      navigatetocuisines(
                                                          context, setState);
                                                    } else if (index == 2) {
                                                      navigatetostoretypes(
                                                        context,
                                                        setState,
                                                      );
                                                    }
                                                    // else if (index == 3) {
                                                    //   setState(() {
                                                    //     widget.freedeliverycolor =
                                                    //         !widget.freedeliverycolor;
                                                    //     freedeliveryid = "1";
                                                    //     freedelivery = "Free delivery";
                                                    //   });
                                                    //   log(" RESTU....free delivery color : ${widget.freedeliverycolor}");

                                                    //   Navigator.push(
                                                    //       context,
                                                    //       MaterialPageRoute(
                                                    //         builder: (context) => SearchPage(
                                                    //           textvalue: widget.itemname,
                                                    //           cusines: widget.cusines!,
                                                    //           showsortby: true,
                                                    //           storetypes: widget.storetypes!,
                                                    //           sortbyid: widget.sortbyid!,
                                                    //           sortby: widget.sortby!,
                                                    //           fromsortshoerestuarent: true,
                                                    //           cuisinesid: widget.cusinesid!,
                                                    //           storetypeid: widget.sorttypeid!,
                                                    //           resetdata: false,
                                                    //           checkcuisinesname:
                                                    //               widget.checkcuisinesid,
                                                    //           addcheckcuisinesdata: false,
                                                    //           freedelivery: freedelivery,
                                                    //           freedeliveryid: freedeliveryid,
                                                    //           halal: widget.halal_id,
                                                    //           promoid: widget.promo_id,
                                                    //           freedeliverycolor:
                                                    //               widget.freedeliverycolor,
                                                    //           halalcolor: widget.halalcolor,
                                                    //           promocolor: widget.promocolor,
                                                    //         ),
                                                    //       ));
                                                    // } else if (index == 4) {
                                                    //   setState(() {
                                                    //     halalid = "1";
                                                    //     widget.halalcolor = !widget.halalcolor;
                                                    //   });
                                                    //   log("RESTu.. halalcolor on tap : ${widget.halalcolor}");
                                                    //   Navigator.push(
                                                    //       context,
                                                    //       MaterialPageRoute(
                                                    //         builder: (context) => SearchPage(
                                                    //           textvalue: widget.itemname,
                                                    //           cusines: widget.cusines!,
                                                    //           showsortby: true,
                                                    //           storetypes: widget.storetypes!,
                                                    //           sortbyid: widget.sortbyid!,
                                                    //           sortby: widget.sortby!,
                                                    //           fromsortshoerestuarent: true,
                                                    //           cuisinesid: widget.cusinesid!,
                                                    //           storetypeid: widget.sorttypeid!,
                                                    //           resetdata: false,
                                                    //           checkcuisinesname:
                                                    //               widget.checkcuisinesid,
                                                    //           addcheckcuisinesdata: false,
                                                    //           freedelivery: freedelivery,
                                                    //           freedeliveryid:
                                                    //               widget.freedelery_id,
                                                    //           halal: halalid,
                                                    //           promoid: widget.promo_id,
                                                    //           freedeliverycolor:
                                                    //               widget.freedeliverycolor,
                                                    //           halalcolor: widget.halalcolor,
                                                    //           promocolor: widget.promocolor,
                                                    //         ),
                                                    //       ));
                                                    // } else {
                                                    //   setState(() {
                                                    //     promoid = "1";
                                                    //     widget.promocolor = !widget.promocolor;
                                                    //   });
                                                    //   log("RESTu.. promocolor on tap : ${widget.promocolor}");
                                                    //   Navigator.push(
                                                    //       context,
                                                    //       MaterialPageRoute(
                                                    //         builder: (context) => SearchPage(
                                                    //           textvalue: widget.itemname,
                                                    //           cusines: widget.cusines!,
                                                    //           showsortby: true,
                                                    //           storetypes: widget.storetypes!,
                                                    //           sortbyid: widget.sortbyid!,
                                                    //           sortby: widget.sortby!,
                                                    //           fromsortshoerestuarent: true,
                                                    //           cuisinesid: widget.cusinesid!,
                                                    //           storetypeid: widget.sorttypeid!,
                                                    //           resetdata: false,
                                                    //           checkcuisinesname:
                                                    //               widget.checkcuisinesid,
                                                    //           addcheckcuisinesdata: false,
                                                    //           freedelivery: freedelivery,
                                                    //           freedeliveryid:
                                                    //               widget.freedelery_id,
                                                    //           halal: widget.halal_id,
                                                    //           promoid: promoid,
                                                    //           freedeliverycolor:
                                                    //               widget.freedeliverycolor,
                                                    //           halalcolor: widget.halalcolor,
                                                    //           promocolor: widget.promocolor,
                                                    //         ),
                                                    //       ));
                                                    //  }
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Container(
                                                      height: 15,
                                                      decoration: BoxDecoration(
                                                          color: Colors.grey,
                                                          // color: tabbar[index] == widget.sortby
                                                          //     ? const Color.fromARGB(
                                                          //         255, 111, 241, 176)
                                                          //     : tabbar[index] == widget.storetypes
                                                          //         ? const Color.fromARGB(
                                                          //             255, 111, 241, 176)
                                                          //         : tabbar[index] ==
                                                          //                 widget.cusines
                                                          //             ? const Color.fromARGB(
                                                          //                 255, 111, 241, 176)

                                                          //             // free delivery
                                                          //             : widget.freedeliverycolor
                                                          //                 ? index == 3
                                                          //                     ? const Color.fromARGB(
                                                          //                         255, 111, 241, 176)
                                                          //                     : widget.promocolor
                                                          //                         ? index == 5
                                                          //                             ? const Color.fromARGB(
                                                          //                                 255,
                                                          //                                 111,
                                                          //                                 241,
                                                          //                                 176)
                                                          //                             : widget
                                                          //                                     .halalcolor
                                                          //                                 ? index ==
                                                          //                                         4
                                                          //                                     ? const Color.fromARGB(
                                                          //                                         255, 111, 241, 176)
                                                          //                                     : const Color.fromARGB(
                                                          //                                         255,
                                                          //                                         219,
                                                          //                                         233,
                                                          //                                         231)
                                                          //                                 : const Color.fromARGB(
                                                          //                                     255,
                                                          //                                     219,
                                                          //                                     233,
                                                          //                                     231)
                                                          //                         : widget
                                                          //                                 .halalcolor
                                                          //                             ? index == 4
                                                          //                                 ? const Color.fromARGB(
                                                          //                                     255,
                                                          //                                     111,
                                                          //                                     241,
                                                          //                                     176)
                                                          //                                 : const Color.fromARGB(255, 219, 233, 231)
                                                          //                             : const Color.fromARGB(255, 219, 233, 231)

                                                          //                 //halal

                                                          //                 : widget.halalcolor
                                                          //                     ? index == 4
                                                          //                         ? const Color.fromARGB(255, 111, 241, 176)
                                                          //                         : widget.promocolor
                                                          //                             ? index == 5
                                                          //                                 ? const Color.fromARGB(255, 111, 241, 176)
                                                          //                                 : widget.freedeliverycolor
                                                          //                                     ? index == 3
                                                          //                                         ? const Color.fromARGB(255, 111, 241, 176)
                                                          //                                         : const Color.fromARGB(255, 219, 233, 231)
                                                          //                                     : const Color.fromARGB(255, 219, 233, 231)
                                                          //                             : widget.freedeliverycolor
                                                          //                                 ? index == 3
                                                          //                                     ? const Color.fromARGB(255, 111, 241, 176)
                                                          //                                     : const Color.fromARGB(255, 219, 233, 231)
                                                          //                                 : const Color.fromARGB(255, 219, 233, 231)

                                                          //                     // Promo

                                                          //                     : widget.promocolor
                                                          //                         ? index == 5
                                                          //                             ? const Color.fromARGB(255, 111, 241, 176)
                                                          //                             : const Color.fromARGB(255, 219, 233, 231)
                                                          //                         : widget.halalcolor
                                                          //                             ? index == 4
                                                          //                                 ? const Color.fromARGB(255, 111, 241, 176)
                                                          //                                 : const Color.fromARGB(255, 219, 233, 231)
                                                          //                             : widget.freedeliverycolor
                                                          //                                 ? index == 5
                                                          //                                     ? const Color.fromARGB(255, 111, 241, 176)
                                                          //                                     : const Color.fromARGB(255, 219, 233, 231)
                                                          //                                 : widget.freedeliverycolor
                                                          //                                     ? index == 5
                                                          //                                         ? const Color.fromARGB(255, 111, 241, 176)
                                                          //                                         : const Color.fromARGB(255, 219, 233, 231)
                                                          //                                     : const Color.fromARGB(255, 219, 233, 231),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Center(
                                                            child: Text(
                                                          tabbar[index],
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12),
                                                        )),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }),
                                        ),
                                      ),
                                    )
                                  : Container()
                            ],
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 200,
                        width: 330,
                        child: Image.asset(
                          "assets/images/valentine.gif",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),

                  // LIST ONE

                  // Padding(
                  //   padding: const EdgeInsets.only(top: 7),
                  //   child: Container(
                  //     color: Colors.white,
                  //     height: 280,
                  //     child: firstitemlist.isEmpty
                  //         // for lazy loading part not using lazy_loading package
                  //         ? const Skeleton(
                  //             radius: 15,
                  //             height: 280,
                  //             width: 350,
                  //           )
                  //         :

                  //  ListView.builder(
                  //     controller:
                  //         PageController(viewportFraction: 0.95),
                  //     scrollDirection: Axis.horizontal,
                  //     physics: const PageScrollPhysics()
                  //         .applyTo(const BouncingScrollPhysics()),
                  //     itemCount: firstitemlist[0].length,
                  //     itemBuilder: (context, index) {
                  //       return Padding(
                  //         padding:
                  //             const EdgeInsets.only(top: 35, left: 10),
                  //         child: Column(
                  //           crossAxisAlignment:
                  //               CrossAxisAlignment.start,
                  //           children: [
                  //             SizedBox(
                  //               height: 200,
                  //               width: 330,
                  //               child: ClipRRect(
                  //                 borderRadius:
                  //                     BorderRadius.circular(10),
                  //                 child: CachedNetworkImage(
                  //                   fadeInDuration:
                  //                       const Duration(seconds: 1),
                  //                   imageUrl:
                  //                       'https://globizs.sgp1.cdn.digitaloceanspaces.com/foodwifi/${firstitemlist[0][index]!.img}',
                  //                   fit: BoxFit.cover,
                  //                   progressIndicatorBuilder: (context,
                  //                       url, downloadProgress) {
                  //                     return const Skeleton(
                  //                       radius: 10,
                  //                       height: 200,
                  //                       width: 330,
                  //                     );
                  //                   },
                  //                   errorWidget:
                  //                       (context, url, error) =>
                  //                           const Icon(Icons.error),
                  //                 ),
                  //               ),
                  //             ),
                  //             const SizedBox(
                  //               height: 10,
                  //             ),
                  //             Text(
                  //               "${firstitemlist[0][index]!.title}",
                  //               style: const TextStyle(
                  //                   fontWeight: FontWeight.bold),
                  //             )
                  //           ],
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  // ),

                  // FOOD NEAR YOU LIST
                  FoodNearYouListPage(firstitemlist: firstitemlist),

                  // OFFER FOR YOU  TAJ KIRA GROUP LIST
                  OfferForYouTajKiraList(
                      firstitemlist: firstitemlist, alldatalist: alldatalist),

                  //   IMPHAL MOST FAVOURITEs TASTY TASTE GROUP LIST
                  ImpahlMostFavouriteTastyTasteList(
                      firstitemlist: firstitemlist, alldatalist: alldatalist),

                  //  New ON FOOD WIFI    HOTEL IMOLIST GROUP
                  NewOnFoodWifiHotelImolist(
                      firstitemlist: firstitemlist, alldatalist: alldatalist),

                  // SUPPORT LOCAL FAVOURITES GROUP OK CHIKEN GROUP LIST
                  SupportLocalFavouriteList(
                      firstitemlist: firstitemlist, alldatalist: alldatalist),

                  // FOR HOME SEARCH BELOW PART

                  BelowHomeone(
                    homebelowdara: homebelowdara,
                  ),

                  // index 4
                  //item 6
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 7),
                  //   child: Container(
                  //     color: Colors.white,
                  //     height: 310,
                  //     child: Column(
                  //       children: [
                  //         Padding(
                  //           padding: const EdgeInsets.only(top: 15, left: 10),
                  //           child: alldatalist.isEmpty
                  //               ? const CircularProgressIndicator()
                  //               : Row(
                  //                   children: [
                  //                     Column(
                  //                       crossAxisAlignment:
                  //                           CrossAxisAlignment.start,
                  //                       children: [
                  //                         Row(
                  //                           children: [
                  //                             Text(
                  //                               "${alldatalist[4].title}",
                  //                               style: const TextStyle(
                  //                                   fontWeight: FontWeight.bold,
                  //                                   fontSize: 20,
                  //                                   fontStyle:
                  //                                       FontStyle.italic),
                  //                             ),
                  //                             const SizedBox(
                  //                               width: 5,
                  //                             ),
                  //                             const CircleAvatar(
                  //                                 radius: 10,
                  //                                 backgroundColor:
                  //                                     Color.fromARGB(
                  //                                         255, 233, 232, 232),
                  //                                 child: Icon(
                  //                                   Icons.arrow_forward,
                  //                                   size: 17,
                  //                                   color: Colors.black,
                  //                                 ))
                  //                           ],
                  //                         ),
                  //                         const SizedBox(
                  //                           height: 7,
                  //                         ),
                  //                         Text(
                  //                           "${alldatalist[4].description}",
                  //                           style: const TextStyle(
                  //                               fontSize: 12,
                  //                               fontStyle: FontStyle.italic,
                  //                               color: Colors.black54),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                     const SizedBox(
                  //                       width: 5,
                  //                     ),
                  //                   ],
                  //                 ),
                  //         ),
                  //         Expanded(
                  //           child: Container(
                  //             child: firstitemlist.isEmpty
                  //                 ? const Skeleton(
                  //                     radius: 15,
                  //                     height: 280,
                  //                     width: 350,
                  //                   )
                  //                 : ListView.builder(
                  //                     controller: PageController(
                  //                         viewportFraction: 0.95),
                  //                     scrollDirection: Axis.horizontal,
                  //                     physics: const PageScrollPhysics()
                  //                         .applyTo(
                  //                             const BouncingScrollPhysics()),
                  //                     itemCount: firstitemlist[4].length,
                  //                     itemBuilder: (context, index) {
                  //                       return InkWell(
                  //                         onTap: () {
                  //                           context.router
                  //                               .push(ProductUpperRoute(
                  //                             id: firstitemlist[4][index]!
                  //                                 .id
                  //                                 .toString(),
                  //                             title: firstitemlist[4][index]!
                  //                                 .title
                  //                                 .toString(),
                  //                             // the below parameter are  not used for this navigate ..it used for searchrestuarant page
                  //                             autoscroll: false,
                  //                             searcgcategoryname: '',
                  //                             finalindex: 0,
                  //                             products: null,
                  //                           ));
                  //                         },
                  //                         child: Padding(
                  //                           padding: const EdgeInsets.only(
                  //                               top: 20, left: 10),
                  //                           child: Column(
                  //                             crossAxisAlignment:
                  //                                 CrossAxisAlignment.start,
                  //                             children: [
                  //                               SizedBox(
                  //                                 // height: 200,
                  //                                 width: 290,
                  //                                 child: ClipRRect(
                  //                                   borderRadius:
                  //                                       BorderRadius.circular(
                  //                                           20),
                  //                                   child: CachedNetworkImage(
                  //                                       fadeInDuration:
                  //                                           const Duration(
                  //                                               seconds: 2),
                  //                                       imageUrl:
                  //                                           'https://globizs.sgp1.cdn.digitaloceanspaces.com/foodwifi/${firstitemlist[4][index]!.img}',
                  //                                       fit: BoxFit.cover,
                  //                                       progressIndicatorBuilder:
                  //                                           (context, url,
                  //                                               downloadProgress) {
                  //                                         return const Skeleton(
                  //                                           radius: 20,
                  //                                           height: 140,
                  //                                           width: 249,
                  //                                         );
                  //                                       },
                  //                                       errorWidget: (context,
                  //                                               url, error) =>
                  //                                           const Center(
                  //                                               child: Text(
                  //                                             "bad network",
                  //                                             style: TextStyle(
                  //                                                 color: Colors
                  //                                                     .red,
                  //                                                 fontSize: 10),
                  //                                           ))),
                  //                                 ),
                  //                               ),
                  //                               const SizedBox(
                  //                                 height: 10,
                  //                               ),
                  //                               Row(
                  //                                 children: [
                  //                                   Text(
                  //                                     "${firstitemlist[4][index]!.title}",
                  //                                     style: const TextStyle(
                  //                                         fontSize: 12,
                  //                                         color: Colors.black87,
                  //                                         fontWeight:
                  //                                             FontWeight.bold),
                  //                                   ),
                  //                                   const SizedBox(
                  //                                     width: 130,
                  //                                   ),
                  //                                   const Icon(
                  //                                     Icons.favorite_outline,
                  //                                     size: 18,
                  //                                   ),
                  //                                 ],
                  //                               ),
                  //                               Text(
                  //                                 firstitemlist[4][index]!
                  //                                             .description !=
                  //                                         null
                  //                                     ? "${firstitemlist[4][index]!.description}"
                  //                                     : "",
                  //                                 style: const TextStyle(
                  //                                   fontSize: 10,
                  //                                   color: Color.fromARGB(
                  //                                       255, 131, 130, 130),
                  //                                 ),
                  //                               ),
                  //                               const SizedBox(
                  //                                 height: 3,
                  //                               ),
                  //                               Row(
                  //                                 children: [
                  //                                   const Icon(
                  //                                     Icons.star,
                  //                                     size: 13,
                  //                                     color: Color.fromARGB(
                  //                                         255, 226, 209, 53),
                  //                                   ),
                  //                                   Text(
                  //                                     "${firstitemlist[4][index]!.rating}\t",
                  //                                     style: const TextStyle(
                  //                                         fontSize: 10,
                  //                                         fontWeight:
                  //                                             FontWeight.bold,
                  //                                         color: Color.fromARGB(
                  //                                             255,
                  //                                             97,
                  //                                             120,
                  //                                             131)),
                  //                                   ),
                  //                                   Text(
                  //                                     "${firstitemlist[4][index]!.time}\t",
                  //                                     style: const TextStyle(
                  //                                         fontSize: 10,
                  //                                         fontWeight:
                  //                                             FontWeight.bold,
                  //                                         color: Color.fromARGB(
                  //                                             255,
                  //                                             97,
                  //                                             120,
                  //                                             131)),
                  //                                   ),
                  //                                   Text(
                  //                                     "${firstitemlist[4][index]!.distance}",
                  //                                     style: const TextStyle(
                  //                                         fontSize: 10,
                  //                                         fontWeight:
                  //                                             FontWeight.bold,
                  //                                         color: Color.fromARGB(
                  //                                             255,
                  //                                             97,
                  //                                             120,
                  //                                             131)),
                  //                                   ),
                  //                                 ],
                  //                               )
                  //                             ],
                  //                           ),
                  //                         ),
                  //                       );
                  //                     },
                  //                   ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  //item
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 7),
                  //   child: Container(
                  //     color: Colors.white,
                  //     height: 280,
                  //     child: Column(
                  //       children: [
                  //         Padding(
                  //           padding: const EdgeInsets.only(top: 15, left: 10),
                  //           child: alldatalist.isEmpty
                  //               ? const CircularProgressIndicator()
                  //               : Row(
                  //                   children: [
                  //                     Column(
                  //                       crossAxisAlignment:
                  //                           CrossAxisAlignment.start,
                  //                       children: [
                  //                         Row(
                  //                           children: [
                  //                             Text(
                  //                               "${alldatalist[6].title}",
                  //                               style: const TextStyle(
                  //                                   fontWeight: FontWeight.bold,
                  //                                   fontSize: 20,
                  //                                   fontStyle:
                  //                                       FontStyle.italic),
                  //                             ),
                  //                             const SizedBox(
                  //                               width: 5,
                  //                             ),
                  //                             const CircleAvatar(
                  //                                 radius: 10,
                  //                                 backgroundColor:
                  //                                     Color.fromARGB(
                  //                                         255, 233, 232, 232),
                  //                                 child: Icon(
                  //                                   Icons.arrow_forward,
                  //                                   size: 17,
                  //                                   color: Colors.black,
                  //                                 ))
                  //                           ],
                  //                         ),
                  //                         const SizedBox(
                  //                           height: 7,
                  //                         ),
                  //                       ],
                  //                     ),
                  //                     const SizedBox(
                  //                       width: 5,
                  //                     ),
                  //                   ],
                  //                 ),
                  //         ),
                  //         Expanded(
                  //           child: Container(
                  //             child: firstitemlist.isEmpty
                  //                 ? const Skeleton(
                  //                     radius: 15,
                  //                     height: 280,
                  //                     width: 350,
                  //                   )
                  //                 : ListView.builder(
                  //                     controller: PageController(
                  //                         viewportFraction: 0.75),
                  //                     //shrinkWrap: true,
                  //                     scrollDirection: Axis.horizontal,
                  //                     physics: const PageScrollPhysics()
                  //                         .applyTo(
                  //                             const BouncingScrollPhysics()),

                  //                     itemCount: firstitemlist[6].length,
                  //                     itemBuilder: (context, index) {
                  //                       return InkWell(
                  //                         onTap: () {
                  //                           context.router
                  //                               .push(ProductUpperRoute(
                  //                             id: firstitemlist[6][index]!
                  //                                 .id
                  //                                 .toString(),
                  //                             title: firstitemlist[6][index]!
                  //                                 .title
                  //                                 .toString(),
                  //                             // the below parameter are  not used for this navigate ..it used for searchrestuarant page
                  //                             autoscroll: false,
                  //                             searcgcategoryname: '',
                  //                             finalindex: 0,
                  //                             products: null,
                  //                             // products: null,
                  //                             // finalindex: 5
                  //                           ));
                  //                         },
                  //                         child: Padding(
                  //                           padding: const EdgeInsets.only(
                  //                               top: 20, left: 10),
                  //                           child: Column(
                  //                             crossAxisAlignment:
                  //                                 CrossAxisAlignment.start,
                  //                             children: [
                  //                               SizedBox(
                  //                                 height: 140,
                  //                                 width: 249,
                  //                                 child: ClipRRect(
                  //                                   borderRadius:
                  //                                       BorderRadius.circular(
                  //                                           20),
                  //                                   child: CachedNetworkImage(
                  //                                       fadeInDuration:
                  //                                           const Duration(
                  //                                               seconds: 2),
                  //                                       imageUrl:
                  //                                           'https://globizs.sgp1.cdn.digitaloceanspaces.com/foodwifi/${firstitemlist[6][index]!.img}',
                  //                                       fit: BoxFit.cover,
                  //                                       progressIndicatorBuilder:
                  //                                           (context, url,
                  //                                               downloadProgress) {
                  //                                         return const Skeleton(
                  //                                           radius: 20,
                  //                                           height: 140,
                  //                                           width: 249,
                  //                                         );
                  //                                       },
                  //                                       errorWidget: (context,
                  //                                               url, error) =>
                  //                                           const Center(
                  //                                               child: Text(
                  //                                             "bad network",
                  //                                             style: TextStyle(
                  //                                                 color: Colors
                  //                                                     .red,
                  //                                                 fontSize: 10),
                  //                                           ))),
                  //                                 ),
                  //                               ),
                  //                               const SizedBox(
                  //                                 height: 10,
                  //                               ),
                  //                               Text(
                  //                                 "${firstitemlist[6][index]!.title}",
                  //                                 style: const TextStyle(
                  //                                     fontSize: 12,
                  //                                     color: Colors.black87,
                  //                                     fontWeight:
                  //                                         FontWeight.bold),
                  //                               ),
                  //                               const SizedBox(
                  //                                 height: 3,
                  //                               ),
                  //                               Text(
                  //                                 "${firstitemlist[6][index]!.description}",
                  //                                 style: const TextStyle(
                  //                                     fontSize: 10,
                  //                                     color: Color.fromARGB(
                  //                                         255, 131, 130, 130)),
                  //                               ),
                  //                               const SizedBox(
                  //                                 height: 3,
                  //                               ),
                  //                               Row(
                  //                                 children: [
                  //                                   const Icon(
                  //                                     Icons.star,
                  //                                     size: 13,
                  //                                     color: Color.fromARGB(
                  //                                         255, 226, 209, 53),
                  //                                   ),
                  //                                   Text(
                  //                                     "${firstitemlist[6][index]!.rating}\t",
                  //                                     style: const TextStyle(
                  //                                         fontSize: 10,
                  //                                         fontWeight:
                  //                                             FontWeight.bold,
                  //                                         color: Color.fromARGB(
                  //                                             255,
                  //                                             97,
                  //                                             120,
                  //                                             131)),
                  //                                   ),
                  //                                   Text(
                  //                                     "${firstitemlist[6][index]!.time}\t",
                  //                                     style: const TextStyle(
                  //                                         fontSize: 10,
                  //                                         fontWeight:
                  //                                             FontWeight.bold,
                  //                                         color: Color.fromARGB(
                  //                                             255,
                  //                                             97,
                  //                                             120,
                  //                                             131)),
                  //                                   ),
                  //                                   Text(
                  //                                     "${firstitemlist[6][index]!.distance}",
                  //                                     style: const TextStyle(
                  //                                         fontSize: 10,
                  //                                         fontWeight:
                  //                                             FontWeight.bold,
                  //                                         color: Color.fromARGB(
                  //                                             255,
                  //                                             97,
                  //                                             120,
                  //                                             131)),
                  //                                   ),
                  //                                 ],
                  //                               )
                  //                             ],
                  //                           ),
                  //                         ),
                  //                       );
                  //                     },
                  //                   ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  //   //item 9
                  //   Padding(
                  //     padding: const EdgeInsets.only(top: 7),
                  //     child: Container(
                  //       color: Colors.white,
                  //       height: 310,
                  //       child: Column(
                  //         children: [
                  //           Padding(
                  //             padding: const EdgeInsets.only(top: 15, left: 10),
                  //             child: alldatalist.isEmpty
                  //                 ? const CircularProgressIndicator()
                  //                 : Row(
                  //                     children: [
                  //                       Column(
                  //                         crossAxisAlignment:
                  //                             CrossAxisAlignment.start,
                  //                         children: [
                  //                           Row(
                  //                             children: [
                  //                               Text(
                  //                                 "${alldatalist[8].title}",
                  //                                 style: const TextStyle(
                  //                                     fontWeight: FontWeight.bold,
                  //                                     fontSize: 20,
                  //                                     fontStyle:
                  //                                         FontStyle.italic),
                  //                               ),
                  //                               const SizedBox(
                  //                                 width: 5,
                  //                               ),
                  //                               const CircleAvatar(
                  //                                   radius: 10,
                  //                                   backgroundColor:
                  //                                       Color.fromARGB(
                  //                                           255, 233, 232, 232),
                  //                                   child: Icon(
                  //                                     Icons.arrow_forward,
                  //                                     size: 17,
                  //                                     color: Colors.black,
                  //                                   ))
                  //                             ],
                  //                           ),
                  //                           const SizedBox(
                  //                             height: 7,
                  //                           ),
                  //                           Text(
                  //                             "${alldatalist[8].description}",
                  //                             style: const TextStyle(
                  //                                 fontSize: 12,
                  //                                 fontStyle: FontStyle.italic,
                  //                                 color: Colors.black54),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                       const SizedBox(
                  //                         width: 5,
                  //                       ),
                  //                     ],
                  //                   ),
                  //           ),
                  //           Expanded(
                  //             child: Container(
                  //               child: firstitemlist.isEmpty
                  //                   ? const Skeleton(
                  //                       radius: 15,
                  //                       height: 280,
                  //                       width: 350,
                  //                     )
                  //                   : ListView.builder(
                  //                       controller: PageController(
                  //                           viewportFraction: 0.72),
                  //                       //shrinkWrap: true,
                  //                       scrollDirection: Axis.horizontal,
                  //                       physics: const PageScrollPhysics()
                  //                           .applyTo(
                  //                               const BouncingScrollPhysics()),

                  //                       itemCount: firstitemlist[8].length,
                  //                       itemBuilder: (context, index) {
                  //                         return InkWell(
                  //                           onTap: () {
                  //                             context.router
                  //                                 .push(ProductUpperRoute(
                  //                               id: firstitemlist[8][index]!
                  //                                   .id
                  //                                   .toString(),
                  //                               title: firstitemlist[8][index]!
                  //                                   .title
                  //                                   .toString(),
                  //                               // the below parameter are  not used for this navigate ..it used for searchrestuarant page
                  //                               autoscroll: false,
                  //                               searcgcategoryname: '',
                  //                               finalindex: 0,
                  //                               products: null,
                  //                             ));
                  //                           },
                  //                           child: Padding(
                  //                             padding: const EdgeInsets.only(
                  //                                 top: 20, left: 10),
                  //                             child: Column(
                  //                               crossAxisAlignment:
                  //                                   CrossAxisAlignment.start,
                  //                               children: [
                  //                                 SizedBox(
                  //                                   height: 140,
                  //                                   width: 249,
                  //                                   child: ClipRRect(
                  //                                     borderRadius:
                  //                                         BorderRadius.circular(
                  //                                             20),
                  //                                     child: CachedNetworkImage(
                  //                                         fadeInDuration:
                  //                                             const Duration(
                  //                                                 seconds: 2),
                  //                                         imageUrl:
                  //                                             'https://globizs.sgp1.cdn.digitaloceanspaces.com/foodwifi/${firstitemlist[8][index]!.img}',
                  //                                         fit: BoxFit.cover,
                  //                                         progressIndicatorBuilder:
                  //                                             (context, url,
                  //                                                 downloadProgress) {
                  //                                           return const Skeleton(
                  //                                             radius: 15,
                  //                                             height: 140,
                  //                                             width: 249,
                  //                                           );
                  //                                         },
                  //                                         errorWidget: (context,
                  //                                                 url, error) =>
                  //                                             const Center(
                  //                                                 child: Text(
                  //                                               "bad network",
                  //                                               style: TextStyle(
                  //                                                   color: Colors
                  //                                                       .red,
                  //                                                   fontSize: 10),
                  //                                             ))),
                  //                                   ),
                  //                                 ),
                  //                                 const SizedBox(
                  //                                   height: 10,
                  //                                 ),
                  //                                 Row(
                  //                                   children: [
                  //                                     Text(
                  //                                       "${firstitemlist[8][index]!.title}",
                  //                                       style: const TextStyle(
                  //                                           fontSize: 12,
                  //                                           color: Colors.black87,
                  //                                           fontWeight:
                  //                                               FontWeight.bold),
                  //                                     ),
                  //                                     const SizedBox(
                  //                                       width: 70,
                  //                                     ),
                  //                                     Row(
                  //                                       mainAxisAlignment:
                  //                                           MainAxisAlignment.end,
                  //                                       crossAxisAlignment:
                  //                                           CrossAxisAlignment
                  //                                               .end,
                  //                                       children: [
                  //                                         Column(
                  //                                           crossAxisAlignment:
                  //                                               CrossAxisAlignment
                  //                                                   .end,
                  //                                           children: const [
                  //                                             Icon(
                  //                                               Icons
                  //                                                   .favorite_outline,
                  //                                               size: 18,
                  //                                             ),
                  //                                             SizedBox(
                  //                                               width: 60,
                  //                                             )
                  //                                           ],
                  //                                         ),
                  //                                       ],
                  //                                     ),
                  //                                   ],
                  //                                 ),
                  //                                 const SizedBox(
                  //                                   height: 3,
                  //                                 ),
                  //                                 Text(
                  //                                   firstitemlist[8][index]!
                  //                                               .description !=
                  //                                           null
                  //                                       ? "${firstitemlist[8][index]!.description}"
                  //                                       : "",
                  //                                   style: const TextStyle(
                  //                                       fontSize: 12,
                  //                                       color: Colors.black87,
                  //                                       fontWeight:
                  //                                           FontWeight.bold),
                  //                                 ),
                  //                                 const SizedBox(
                  //                                   height: 3,
                  //                                 ),
                  //                                 Row(
                  //                                   children: [
                  //                                     const Icon(
                  //                                       Icons.star,
                  //                                       size: 13,
                  //                                       color: Color.fromARGB(
                  //                                           255, 226, 209, 53),
                  //                                     ),
                  //                                     Text(
                  //                                       "${firstitemlist[8][index]!.rating}\t",
                  //                                       style: const TextStyle(
                  //                                           fontSize: 10,
                  //                                           fontWeight:
                  //                                               FontWeight.bold,
                  //                                           color: Color.fromARGB(
                  //                                               255,
                  //                                               97,
                  //                                               120,
                  //                                               131)),
                  //                                     ),
                  //                                     Text(
                  //                                       "${firstitemlist[8][index]!.time}\t",
                  //                                       style: const TextStyle(
                  //                                           fontSize: 10,
                  //                                           fontWeight:
                  //                                               FontWeight.bold,
                  //                                           color: Color.fromARGB(
                  //                                               255,
                  //                                               97,
                  //                                               120,
                  //                                               131)),
                  //                                     ),
                  //                                     Text(
                  //                                       "${firstitemlist[8][index]!.distance}",
                  //                                       style: const TextStyle(
                  //                                           fontSize: 10,
                  //                                           fontWeight:
                  //                                               FontWeight.bold,
                  //                                           color: Color.fromARGB(
                  //                                               255,
                  //                                               97,
                  //                                               120,
                  //                                               131)),
                  //                                     ),
                  //                                   ],
                  //                                 )
                  //                               ],
                  //                             ),
                  //                           ),
                  //                         );
                  //                       },
                  //                     ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
