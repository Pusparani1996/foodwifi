import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwifi/logic/search/search_cubit.dart';
import 'package:foodwifi/logic/searchrestuarentfilter/searchfilter_cubit.dart';
import 'package:foodwifi/model/searchModel.dart';

import 'package:foodwifi/model/searchrestuarentfilter.dart';
import 'package:foodwifi/pages/cusinoesPage.dart';
import 'package:foodwifi/pages/productupper.dart';
import 'package:foodwifi/pages/search_page.dart';
import 'package:foodwifi/pages/sortby_page.dart';
import 'package:foodwifi/pages/storetypespage.dart';
import 'package:foodwifi/serviceapi/serviceapi.dart';
import 'package:foodwifi/widget/firstlistContainerSkeleton.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../model/joinmodel.dart';

class SearchRestuarentFilter extends StatefulWidget {
  final String itemname;
  final bool fromsearchonly;
  final String? cusinesid;
  final String? sorttypeid;
  final String? sortbyid;
  //  For green light at tabbar
  final String? cusines;
  final String? storetypes;
  final String? sortby;
  final bool showresetbtn;
  final String checkcuisinesid;
  final bool addcheckcuisinesdata;
  // ignore: non_constant_identifier_names
  final String freedelery_id;
  final String halal_id;
  final String promo_id;
  late bool promocolor;
  late bool freedeliverycolor;
  late bool halalcolor;

  // final bool resetdata;

  SearchRestuarentFilter({
    super.key,
    required this.itemname,
    required this.fromsearchonly,
    required this.cusinesid,
    required this.sorttypeid,
    required this.sortbyid,
    required this.cusines,
    required this.storetypes,
    required this.sortby,
    required this.showresetbtn,
    required this.checkcuisinesid,
    required this.addcheckcuisinesdata,
    required this.freedelery_id,
    required this.halal_id,
    required this.promo_id,
    required this.promocolor,
    required this.freedeliverycolor,
    required this.halalcolor,

    // required this.resetdata
  });

  @override
  State<SearchRestuarentFilter> createState() => _SearchRestuarentFilterState();
}

class _SearchRestuarentFilterState extends State<SearchRestuarentFilter> {
  ScrollController controller = ScrollController();

  List<SearchResturantFilterModel> searchretuarantlist = [];

  int page = 1;
  bool? ismoreloading;
  bool? foundempty;

  // below parameter are used for Navigate to productupperpage for auto navigate to detailspage
  bool autoscroll = false;
  JoinReviewBellowModel? alldata;
  Product? products;
  int finalindex = 0;
  bool tabcolor = false;
  List<Cuisine> searchdata = [];
  List<StoreType> radiostoretype = [];
  List radiostoretypelist = [];
  List cuisinesidkey = [];
  List cuisinesitems = [];
  Map checkcuisinesidandname = {};
  String freedelivery = "";
  String freedeliveryid = "";
  String halalid = ""; // For halal id
  String promoid = "";
  // bool freedeliverycolor = false;
  // bool halalcolor = false;
  // bool promocolor = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getallpagedata();
    context.read<SearchFilterCubit>().getsearchfilter(
          isMoredata: true,
          page: 1,
          itemname: widget.itemname,
          cusinid: widget.cusinesid,
          sortbyid: widget.sortbyid,
          sorttypeid: widget.sorttypeid,
          checkcuisinesid: widget.checkcuisinesid,
          addcheckcuisinesdata: widget.addcheckcuisinesdata,
          freedeliveryid: widget.freedelery_id,
          halalid: widget.halal_id,
          promoid: widget.promo_id,
        );

    log("from search restuarent initstate  : ${widget.checkcuisinesid}");

    log("from search restuarent initstate  cuisined id : ${widget.cusinesid}");

    controller.addListener(() async {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        if (ismoreloading == false) {
        } else {
          setState(() {
            page = page + 1;
          });
          var allpagedata =
              await context.read<SearchFilterCubit>().getsearchfilter(
                    isMoredata: true,
                    page: page,
                    itemname: widget.itemname,
                    cusinid: widget.cusinesid,
                    sortbyid: widget.sortbyid,
                    sorttypeid: widget.sorttypeid,
                    checkcuisinesid: widget.checkcuisinesid,
                    addcheckcuisinesdata: widget.addcheckcuisinesdata,
                    freedeliveryid: widget.freedelery_id,
                    halalid: widget.halal_id,
                    promoid: widget.promo_id,
                  );

          setState(() {
            searchretuarantlist = searchretuarantlist + allpagedata!;
          });
        }
      }
    });
  }

  getallpagedata() async {
    var finalallpagedata =
        await context.read<SearchFilterCubit>().getsearchfilter(
              isMoredata: true,
              page: 1,
              itemname: widget.itemname,
              cusinid: widget.cusinesid,
              sortbyid: widget.sortbyid,
              sorttypeid: widget.sorttypeid,
              checkcuisinesid: widget.checkcuisinesid,
              addcheckcuisinesdata: widget.addcheckcuisinesdata,
              freedeliveryid: widget.freedelery_id,
              halalid: widget.halal_id,
              promoid: widget.promo_id,
            );

    setState(() {
      searchretuarantlist = searchretuarantlist + finalallpagedata!;
    });
  }

  movetosearchrestuarent(int index, int restuarentindex) async {
    var searchalldata = await ServiceApi()
        .getallrestuarentdata(searchretuarantlist[index].id.toString());

    if (searchalldata!.isNotEmpty) {}
    for (var element in searchalldata) {
      for (var items in element.products) {
        if (searchretuarantlist[index].items[restuarentindex].name ==
            items.name) {
          setState(() {
            alldata = element;
            finalindex = searchalldata.indexOf(alldata!);
            // log("index from searchrestuarant :$finalindex");

            products = items;
            // log("Product name :${products!.name}");
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductUpperPage(
                  id: searchretuarantlist[index].id.toString(),
                  title: searchretuarantlist[index].title.toString(),
                  autoscroll: true,
                  searcgcategoryname: '',
                  finalindex: finalindex,
                  products: products,
                ),
              ));
        }
      }
    }
  }

  List tabbar = [
    "Sort by",
    "Store types",
    "Cuisines",
    "Free delivery",
    "Halal",
    "Promo",
  ];

  @override
  Widget build(BuildContext context) {
    final searchresturant = context.watch<SearchFilterCubit>().state;

    ismoreloading = searchresturant.isloading;
    foundempty = searchresturant.foundempty;

    // USED FOR CHECKBOX IN CUISINES PAGE
    final searcgstatus = context.watch<SearcgCubit>().state;
    if (searcgstatus.searchdata != null) {
      searchdata = searcgstatus.searchdata!.cuisines;
      radiostoretype = searcgstatus.searchdata!.storeTypes;
      for (var element in searchdata) {
        if (cuisinesitems.contains(element)) {
          log("ítems already contain");
        } else {
          cuisinesitems.add(element.cuisineName);
          cuisinesidkey.add(element.id);
        }
      }

      checkcuisinesidandname = Map.fromIterables(cuisinesitems, cuisinesidkey);
    }
// FOR STORETYPE RADIO LIST IN STORETYEP PAGE

    log(radiostoretype.toString());

    return searchretuarantlist.isEmpty
        ? foundempty!
            ? SafeArea(
                child: Column(
                  children: [
                    widget.fromsearchonly
                        ? const SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.black54,
                                    size: 15,
                                  )),
                              widget.itemname.isEmpty
                                  ? const Text(
                                      "Foods near you",
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 15),
                                    )
                                  : Center(
                                      child: Text(
                                        widget.itemname,
                                        style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 15),
                                      ),
                                    ),
                              const SizedBox(
                                width: 30,
                              )
                            ],
                          ),
                    // TABBAR FOR ERROR

                    Container(
                      // height: 100,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 30,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: tabbar.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  if (index == 0) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SortByPage(
                                            cusines: widget.cusines,
                                            storetypes: widget.storetypes,
                                            showsearchrestuarent: true,
                                            abovetxt: widget.itemname,
                                            showresetbtn: widget.showresetbtn,
                                            freedelivery: freedelivery,
                                            cuisinesid: widget.cusinesid!,
                                            halal: "",
                                            promo: '',
                                            storetypeid: widget.sorttypeid!,
                                          ),
                                        ));
                                  } else if (index == 1) {
                                    for (var element in radiostoretype) {
                                      radiostoretypelist.add(element.id);
                                      log("id :" + element.id);
                                    }
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => StoreTypesPage(
                                            cusines: widget.cusines,
                                            storetypes: widget.storetypes,
                                            showsearchrestuarent: true,
                                            abovetxt: widget.itemname,
                                            sortby: widget.sortby,
                                            showresetbtn: widget.showresetbtn,
                                            freedilivery: freedelivery,
                                            storetypeid: widget.sorttypeid!,
                                            radiostoretypeidlist:
                                                radiostoretypelist,
                                          ),
                                        ));
                                  } else if (index == 2) {
                                    log("NAvigate to cuisines page no data part : $checkcuisinesidandname");

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CusinesPage(
                                            cusines: widget.cusines,
                                            storetypes: widget.storetypes,
                                            showsearchrestuarent:
                                                widget.cusinesid!.isNotEmpty
                                                    ? false
                                                    : true,
                                            abovetxt: widget.itemname,
                                            sortby: widget.sortby,
                                            showresetbtn: widget.showresetbtn,
                                            checkcuisines:
                                                checkcuisinesidandname,
                                            cuisinesitems: cuisinesitems,
                                            freedilivery: freedelivery,
                                            cuisinesid: widget.cusinesid!,
                                            allcuisines: widget.checkcuisinesid,
                                          ),
                                        ));
                                  } else if (index == 3) {
                                    setState(() {
                                      widget.freedeliverycolor =
                                          !widget.freedeliverycolor;
                                      freedeliveryid = "1";
                                      freedelivery = "Free delivery";
                                    });
                                    // log(" RESTU....free delivery color : ${widget.freedeliverycolor}");

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SearchPage(
                                            textvalue: widget.itemname,
                                            cusines: widget.cusines!,
                                            showsortby: true,
                                            storetypes: widget.storetypes!,
                                            sortbyid: widget.sortbyid!,
                                            sortby: widget.sortby!,
                                            fromsortshoerestuarent: true,
                                            cuisinesid: widget.cusinesid!,
                                            storetypeid: widget.sorttypeid!,
                                            resetdata: false,
                                            addcheckcuisinesdata: false,
                                            freedelivery: freedelivery,
                                            freedeliveryid: freedeliveryid,
                                            halal: widget.halal_id,
                                            promoid: widget.promo_id,
                                            freedeliverycolor:
                                                widget.freedeliverycolor,
                                            halalcolor: widget.halalcolor,
                                            promocolor: widget.promocolor,
                                            checkcuisinesname:
                                                widget.checkcuisinesid,
                                          ),
                                        ));
                                  } else if (index == 4) {
                                    setState(() {
                                      halalid = "1";
                                      widget.halalcolor = !widget.halalcolor;
                                    });
                                    // log("RESTu.. halalcolor on tap : ${widget.halalcolor}");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SearchPage(
                                            textvalue: widget.itemname,
                                            cusines: widget.cusines!,
                                            showsortby: true,
                                            storetypes: widget.storetypes!,
                                            sortbyid: widget.sortbyid!,
                                            sortby: widget.sortby!,
                                            fromsortshoerestuarent: true,
                                            cuisinesid: widget.cusinesid!,
                                            storetypeid: widget.sorttypeid!,
                                            resetdata: false,
                                            checkcuisinesname:
                                                widget.checkcuisinesid,
                                            addcheckcuisinesdata: false,
                                            freedelivery: freedelivery,
                                            freedeliveryid:
                                                widget.freedelery_id,
                                            halal: halalid,
                                            promoid: widget.promo_id,
                                            freedeliverycolor:
                                                widget.freedeliverycolor,
                                            halalcolor: widget.halalcolor,
                                            promocolor: widget.promocolor,
                                          ),
                                        ));
                                  } else {
                                    setState(() {
                                      promoid = "1";
                                      widget.promocolor = !widget.promocolor;
                                    });
                                    // log("RESTu.. promocolor on tap : ${widget.promocolor}");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SearchPage(
                                            textvalue: widget.itemname,
                                            cusines: widget.cusines!,
                                            showsortby: true,
                                            storetypes: widget.storetypes!,
                                            sortbyid: widget.sortbyid!,
                                            sortby: widget.sortby!,
                                            fromsortshoerestuarent: true,
                                            cuisinesid: widget.cusinesid!,
                                            storetypeid: widget.sorttypeid!,
                                            resetdata: false,
                                            checkcuisinesname:
                                                widget.checkcuisinesid,
                                            addcheckcuisinesdata: false,
                                            freedelivery: freedelivery,
                                            freedeliveryid:
                                                widget.freedelery_id,
                                            halal: widget.halal_id,
                                            promoid: promoid,
                                            freedeliverycolor:
                                                widget.freedeliverycolor,
                                            halalcolor: widget.halalcolor,
                                            promocolor: widget.promocolor,
                                          ),
                                        ));
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Container(
                                    height: 15,
                                    decoration: BoxDecoration(
                                        color: tabbar[index] == widget.sortby
                                            ? const Color.fromARGB(
                                                255, 111, 241, 176)
                                            : tabbar[index] == widget.storetypes
                                                ? const Color.fromARGB(
                                                    255, 111, 241, 176)
                                                : tabbar[index] ==
                                                        widget.cusines
                                                    ? const Color.fromARGB(
                                                        255, 111, 241, 176)

                                                    // free delivery
                                                    : widget.freedeliverycolor
                                                        ? index == 3
                                                            ? const Color.fromARGB(
                                                                255, 111, 241, 176)
                                                            : widget.promocolor
                                                                ? index == 5
                                                                    ? const Color.fromARGB(
                                                                        255,
                                                                        111,
                                                                        241,
                                                                        176)
                                                                    : widget
                                                                            .halalcolor
                                                                        ? index ==
                                                                                4
                                                                            ? const Color.fromARGB(
                                                                                255, 111, 241, 176)
                                                                            : const Color.fromARGB(
                                                                                255,
                                                                                219,
                                                                                233,
                                                                                231)
                                                                        : const Color.fromARGB(
                                                                            255,
                                                                            219,
                                                                            233,
                                                                            231)
                                                                : widget
                                                                        .halalcolor
                                                                    ? index == 4
                                                                        ? const Color.fromARGB(
                                                                            255,
                                                                            111,
                                                                            241,
                                                                            176)
                                                                        : const Color.fromARGB(255, 219, 233, 231)
                                                                    : const Color.fromARGB(255, 219, 233, 231)

                                                        //halal

                                                        : widget.halalcolor
                                                            ? index == 4
                                                                ? const Color.fromARGB(255, 111, 241, 176)
                                                                : widget.promocolor
                                                                    ? index == 5
                                                                        ? const Color.fromARGB(255, 111, 241, 176)
                                                                        : widget.freedeliverycolor
                                                                            ? index == 3
                                                                                ? const Color.fromARGB(255, 111, 241, 176)
                                                                                : const Color.fromARGB(255, 219, 233, 231)
                                                                            : const Color.fromARGB(255, 219, 233, 231)
                                                                    : widget.freedeliverycolor
                                                                        ? index == 3
                                                                            ? const Color.fromARGB(255, 111, 241, 176)
                                                                            : const Color.fromARGB(255, 219, 233, 231)
                                                                        : const Color.fromARGB(255, 219, 233, 231)

                                                            // Promo

                                                            : widget.promocolor
                                                                ? index == 5
                                                                    ? const Color.fromARGB(255, 111, 241, 176)
                                                                    : const Color.fromARGB(255, 219, 233, 231)
                                                                : widget.halalcolor
                                                                    ? index == 4
                                                                        ? const Color.fromARGB(255, 111, 241, 176)
                                                                        : const Color.fromARGB(255, 219, 233, 231)
                                                                    : widget.freedeliverycolor
                                                                        ? index == 5
                                                                            ? const Color.fromARGB(255, 111, 241, 176)
                                                                            : const Color.fromARGB(255, 219, 233, 231)
                                                                        : widget.freedeliverycolor
                                                                            ? index == 5
                                                                                ? const Color.fromARGB(255, 111, 241, 176)
                                                                                : const Color.fromARGB(255, 219, 233, 231)
                                                                            : const Color.fromARGB(255, 219, 233, 231),
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                          child: Text(
                                        tabbar[index],
                                        style: const TextStyle(fontSize: 12),
                                      )),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: Image.asset(
                          "assets/images/empty.jpg",
                          fit: BoxFit.fill,
                        )),
                  ],
                ),
              )
            : Container(
                color: Colors.grey,
                child: SafeArea(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        widget.fromsearchonly
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () => Navigator.pop(context),
                                      icon: const Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.black54,
                                        size: 15,
                                      )),
                                  widget.itemname.isEmpty
                                      ? const Text(
                                          "Foods near you",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15),
                                        )
                                      : Text(
                                          widget.itemname,
                                          style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15),
                                        ),
                                  const SizedBox(
                                    width: 30,
                                  )
                                ],
                              ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: Row(
                                children: [
                                  const Skeleton(
                                      height: 90, width: 90, radius: 4),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Skeleton(
                                        radius: 4,
                                        height: 25,
                                        width: 230,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Skeleton(
                                        radius: 4,
                                        height: 25,
                                        width: 180,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Skeleton(
                                        radius: 4,
                                        height: 25,
                                        width: 230,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                        Container(
                          color: const Color.fromARGB(255, 208, 212, 212),
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              )
        : Scaffold(
            body: Container(
            color: Colors.white,
            child: Column(
              children: [
                Material(
                  elevation: 5,
                  shadowColor: const Color.fromARGB(255, 191, 187, 187),
                  child: SafeArea(
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            widget.fromsearchonly
                                ? const SizedBox()
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          icon: const Icon(
                                            Icons.arrow_back_ios,
                                            color: Colors.black54,
                                            size: 15,
                                          )),
                                      widget.itemname.isEmpty
                                          ? const Text(
                                              "Foods near you",
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 15),
                                            )
                                          : Center(
                                              child: Text(
                                                widget.itemname,
                                                style: const TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 15),
                                              ),
                                            ),
                                      const SizedBox(
                                        width: 30,
                                      )
                                    ],
                                  ),

                            //tabbar list

                            SizedBox(
                              height: 30,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: tabbar.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      if (index == 0) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SortByPage(
                                                cusines: widget.cusines,
                                                storetypes: widget.storetypes,
                                                showsearchrestuarent: true,
                                                abovetxt: widget.itemname,
                                                showresetbtn:
                                                    widget.showresetbtn,
                                                freedelivery: freedelivery,
                                                cuisinesid: widget.cusinesid!,
                                                halal: "",
                                                promo: '',
                                                storetypeid: widget.sorttypeid!,
                                              ),
                                            ));
                                      } else if (index == 1) {
                                        for (var element in radiostoretype) {
                                          radiostoretypelist.add(element.id);
                                          log("id :" + element.id);
                                        }
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  StoreTypesPage(
                                                cusines: widget.cusines,
                                                storetypes: widget.storetypes,
                                                showsearchrestuarent: true,
                                                abovetxt: widget.itemname,
                                                sortby: widget.sortby,
                                                showresetbtn:
                                                    widget.showresetbtn,
                                                freedilivery: freedelivery,
                                                storetypeid: widget.sorttypeid!,
                                                radiostoretypeidlist:
                                                    radiostoretypelist,
                                              ),
                                            ));
                                      } else if (index == 2) {
                                        log("from search restuarent checkcuisined : $checkcuisinesidandname");

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => CusinesPage(
                                                  cusines: widget.cusines,
                                                  storetypes: widget.storetypes,
                                                  showsearchrestuarent: widget
                                                          .cusinesid!.isNotEmpty
                                                      ? false
                                                      : true,
                                                  abovetxt: widget.itemname,
                                                  sortby: widget.sortby,
                                                  showresetbtn:
                                                      widget.showresetbtn,
                                                  checkcuisines:
                                                      checkcuisinesidandname,
                                                  cuisinesitems: cuisinesitems,
                                                  freedilivery: freedelivery,
                                                  cuisinesid: widget.cusinesid!,
                                                  allcuisines:
                                                      widget.checkcuisinesid),
                                            ));
                                      } else if (index == 3) {
                                        setState(() {
                                          widget.freedeliverycolor =
                                              !widget.freedeliverycolor;
                                          freedeliveryid = "1";
                                          freedelivery = "Free delivery";
                                        });
                                        // log("on tap free delevery bool : ${widget.freedeliverycolor}");
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SearchPage(
                                                textvalue: widget.itemname,
                                                cusines: widget.cusines!,
                                                storetypes: widget.storetypes!,
                                                showsortby: true,
                                                sortbyid: widget.sortbyid!,
                                                sortby: widget.sortby!,
                                                fromsortshoerestuarent: true,
                                                storetypeid: widget.sorttypeid!,
                                                cuisinesid: widget.cusinesid!,
                                                resetdata: false,
                                                checkcuisinesname:
                                                    widget.checkcuisinesid,
                                                addcheckcuisinesdata: false,
                                                freedelivery: freedelivery,
                                                freedeliveryid: freedeliveryid,
                                                halal: widget.halal_id,
                                                promoid: widget.promo_id,
                                                freedeliverycolor:
                                                    widget.freedeliverycolor,
                                                halalcolor: widget.halalcolor,
                                                promocolor: widget.promocolor,
                                              ),
                                            ));
                                      } else if (index == 4) {
                                        setState(() {
                                          halalid = "1";
                                          widget.halalcolor =
                                              !widget.halalcolor;
                                        });

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SearchPage(
                                                textvalue: widget.itemname,
                                                cusines: widget.cusines!,
                                                showsortby: true,
                                                storetypes: widget.storetypes!,
                                                sortbyid: widget.sortbyid!,
                                                sortby: widget.sortby!,
                                                fromsortshoerestuarent: true,
                                                cuisinesid: widget.cusinesid!,
                                                storetypeid: widget.sorttypeid!,
                                                resetdata: false,
                                                checkcuisinesname:
                                                    widget.checkcuisinesid,
                                                addcheckcuisinesdata: false,
                                                freedelivery: freedelivery,
                                                freedeliveryid: freedeliveryid,
                                                halal: halalid,
                                                promoid: widget.promo_id,
                                                freedeliverycolor:
                                                    widget.freedeliverycolor,
                                                halalcolor: widget.halalcolor,
                                                promocolor: widget.promocolor,
                                              ),
                                            ));
                                      } else {
                                        setState(() {
                                          promoid = "1";
                                          widget.promocolor =
                                              !widget.promocolor;
                                        });
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SearchPage(
                                                textvalue: widget.itemname,
                                                cusines: widget.cusines!,
                                                showsortby: true,
                                                storetypes: widget.storetypes!,
                                                sortbyid: widget.sortbyid!,
                                                cuisinesid: widget.cusinesid!,
                                                storetypeid: widget.sorttypeid!,
                                                sortby: widget.sortby!,
                                                freedeliveryid: freedeliveryid,
                                                halal: halalid,
                                                promoid: promoid,
                                                fromsortshoerestuarent: true,
                                                resetdata: false,
                                                checkcuisinesname:
                                                    widget.checkcuisinesid,
                                                addcheckcuisinesdata: false,
                                                freedelivery: freedelivery,
                                                freedeliverycolor:
                                                    widget.freedeliverycolor,
                                                halalcolor: widget.halalcolor,
                                                promocolor: widget.promocolor,
                                              ),
                                            ));
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Container(
                                        height: 15,
                                        decoration: BoxDecoration(
                                            color: tabbar[index] ==
                                                    widget.sortby
                                                ? const Color.fromARGB(
                                                    255, 111, 241, 176)
                                                : tabbar[index] ==
                                                        widget.storetypes
                                                    ? const Color.fromARGB(
                                                        255, 111, 241, 176)
                                                    : tabbar[index] ==
                                                            widget.cusines
                                                        ? const Color.fromARGB(
                                                            255, 111, 241, 176)

                                                        // free delivery
                                                        : widget
                                                                .freedeliverycolor
                                                            ? index == 3
                                                                ? const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    111,
                                                                    241,
                                                                    176)
                                                                : widget
                                                                        .promocolor
                                                                    ? index == 5
                                                                        ? const Color.fromARGB(
                                                                            255,
                                                                            111,
                                                                            241,
                                                                            176)
                                                                        : widget.halalcolor
                                                                            ? index == 4
                                                                                ? const Color.fromARGB(255, 111, 241, 176)
                                                                                : const Color.fromARGB(255, 219, 233, 231)
                                                                            : const Color.fromARGB(255, 219, 233, 231)
                                                                    : widget.halalcolor
                                                                        ? index == 4
                                                                            ? const Color.fromARGB(255, 111, 241, 176)
                                                                            : const Color.fromARGB(255, 219, 233, 231)
                                                                        : const Color.fromARGB(255, 219, 233, 231)

                                                            //halal

                                                            : widget.halalcolor
                                                                ? index == 4
                                                                    ? const Color.fromARGB(255, 111, 241, 176)
                                                                    : widget.promocolor
                                                                        ? index == 5
                                                                            ? const Color.fromARGB(255, 111, 241, 176)
                                                                            : widget.freedeliverycolor
                                                                                ? index == 3
                                                                                    ? const Color.fromARGB(255, 111, 241, 176)
                                                                                    : const Color.fromARGB(255, 219, 233, 231)
                                                                                : const Color.fromARGB(255, 219, 233, 231)
                                                                        : widget.freedeliverycolor
                                                                            ? index == 3
                                                                                ? const Color.fromARGB(255, 111, 241, 176)
                                                                                : const Color.fromARGB(255, 219, 233, 231)
                                                                            : const Color.fromARGB(255, 219, 233, 231)

                                                                // Promo

                                                                : widget.promocolor
                                                                    ? index == 5
                                                                        ? const Color.fromARGB(255, 111, 241, 176)
                                                                        : const Color.fromARGB(255, 219, 233, 231)
                                                                    : widget.halalcolor
                                                                        ? index == 4
                                                                            ? const Color.fromARGB(255, 111, 241, 176)
                                                                            : const Color.fromARGB(255, 219, 233, 231)
                                                                        : widget.freedeliverycolor
                                                                            ? index == 5
                                                                                ? const Color.fromARGB(255, 111, 241, 176)
                                                                                : const Color.fromARGB(255, 219, 233, 231)
                                                                            : widget.freedeliverycolor
                                                                                ? index == 5
                                                                                    ? const Color.fromARGB(255, 111, 241, 176)
                                                                                    : const Color.fromARGB(255, 219, 233, 231)
                                                                                : const Color.fromARGB(255, 219, 233, 231),
                                            // : const Color.fromARGB(
                                            //     255, 213, 221, 221),
                                            borderRadius: BorderRadius.circular(20)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                              child: Text(
                                            tabbar[index],
                                            style:
                                                const TextStyle(fontSize: 12),
                                          )),
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
                ),
                const SizedBox(
                  height: 7,
                ),
                Expanded(
                    flex: 5,
                    child: SingleChildScrollView(
                      controller: controller,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: const Color.fromARGB(255, 219, 217, 217),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: searchretuarantlist.length,
                              itemBuilder: (context, index) {
                                return searchretuarantlist.isEmpty
                                    ? const SizedBox()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            color: Colors.white,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>

                                                              // Navigate to restuarent only
                                                              ProductUpperPage(
                                                            id: searchretuarantlist[
                                                                    index]
                                                                .id
                                                                .toString(),
                                                            title:
                                                                searchretuarantlist[
                                                                        index]
                                                                    .title
                                                                    .toString(),
                                                            autoscroll: false,
                                                            searcgcategoryname:
                                                                '',
                                                            finalindex:
                                                                finalindex,
                                                            products: products,
                                                          ),
                                                        ));
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10, top: 13),
                                                    child: FittedBox(
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            height: 90,
                                                            width: 90,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              child: searchretuarantlist[
                                                                              index]
                                                                          .img ==
                                                                      null
                                                                  ? ClipOval(
                                                                      child: Image
                                                                          .asset(
                                                                        "assets/images/foodwifi.png",
                                                                        height:
                                                                            90,
                                                                        width:
                                                                            90,
                                                                        color: Colors
                                                                            .white
                                                                            .withOpacity(0.2),
                                                                        colorBlendMode:
                                                                            BlendMode.modulate,
                                                                      ),
                                                                    )
                                                                  : Image
                                                                      .network(
                                                                      "https://globizs.sgp1.cdn.digitaloceanspaces.com/foodwifi/${searchretuarantlist[index].img}",
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 15,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                searchretuarantlist[
                                                                        index]
                                                                    .title
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    searchretuarantlist[
                                                                            index]
                                                                        .time
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black54,
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Text(
                                                                    searchretuarantlist[
                                                                            index]
                                                                        .distance
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black54,
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 5,
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
                                                                    searchretuarantlist[
                                                                            index]
                                                                        .rating
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black54,
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                searchretuarantlist[
                                                                        index]
                                                                    .description
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Divider(
                                                  height: 20,
                                                  thickness: 1,
                                                  indent: 0,
                                                  endIndent: 0,
                                                  color: Color.fromARGB(
                                                      255, 239, 232, 232),
                                                ),
                                                ListView.builder(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount:
                                                      searchretuarantlist[index]
                                                          .items
                                                          .length,
                                                  itemBuilder: (context,
                                                      restuarentindex) {
                                                    return SizedBox(
                                                      // color: Colors.amber,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10,
                                                                right: 10,
                                                                bottom: 17,
                                                                top: 2),
                                                        child: InkWell(
                                                          onTap: () {
                                                            movetosearchrestuarent(
                                                                index,
                                                                restuarentindex);
                                                          },
                                                          child: SizedBox(
                                                            // color: Colors.blue,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SizedBox(
                                                                      width:
                                                                          250,
                                                                      child:
                                                                          Text(
                                                                        maxLines:
                                                                            2,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        searchretuarantlist[index]
                                                                            .items[restuarentindex]
                                                                            .name
                                                                            .toString(),
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              17,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        const Text(
                                                                            "₹"),
                                                                        Text(
                                                                          searchretuarantlist[index]
                                                                              .items[restuarentindex]
                                                                              .price
                                                                              .toString(),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 50,
                                                                  width: 50,
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    child: searchretuarantlist[index].items[restuarentindex].image ==
                                                                            null
                                                                        ? ClipOval(
                                                                            child:
                                                                                Image.asset(
                                                                              "assets/images/foodwifi.png",
                                                                              height: 50,
                                                                              width: 50,
                                                                              color: Colors.white.withOpacity(0.2),
                                                                              colorBlendMode: BlendMode.modulate,
                                                                            ),
                                                                          )
                                                                        : Image
                                                                            .network(
                                                                            "https://globizs.sgp1.cdn.digitaloceanspaces.com/foodwifi/${searchretuarantlist[index].items[restuarentindex].image}",
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                        ],
                                      );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ismoreloading!
                              ? Container(
                                  height: 100,
                                  color: Colors.white,
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        LoadingAnimationWidget.hexagonDots(
                                          color: Colors.blueGrey,
                                          size: 25,
                                        ),
                                        const Text(
                                          "loading more data...",
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 17),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    )),
              ],
            ),
          ));
  }
}
