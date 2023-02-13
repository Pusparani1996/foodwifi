import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwifi/logic/search/search_cubit.dart';
import 'package:foodwifi/logic/searchrestuarentfilter/searchfilter_cubit.dart';

import 'package:foodwifi/model/searchModel.dart';
import 'package:foodwifi/pages/homepage.dart';
import 'package:foodwifi/pages/searchrestuarentfilter_page.dart';
import 'package:foodwifi/widget/firstlistContainerSkeleton.dart';

class SearchPage extends StatefulWidget {
  final String textvalue;
  final String cusines;
  final String storetypes;
  final String sortby;

  final bool showsortby;
  final String sortbyid;
  final String storetypeid;
  final String cuisinesid;
  final bool fromsortshoerestuarent;

  const SearchPage({
    super.key,
    required this.textvalue,
    required this.cusines,
    required this.storetypes,
    required this.showsortby,
    required this.sortbyid,
    required this.sortby,
    required this.fromsortshoerestuarent,
    required this.storetypeid,
    required this.cuisinesid,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();

  bool showsearchrestuarent = false;
  bool searching = false;
  String onchangevalue = "";
  bool visible = true;
  bool searching2 = false;
  String cusinid = "";

  String sorttypeid = "";
  String sortbyid = "";
  // for green light on searcg restuarent page

  String cusinescolor1 = "";
  String cusinescolor2 = "";
  String cusinescolor3 = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = widget.textvalue;
    context.read<SearcgCubit>().getsearch();
    if (widget.showsortby == true) {
      setState(() {
        controller.text = widget.textvalue;
        cusinid = widget.cuisinesid;
        sorttypeid = widget.storetypeid;
        sortbyid = widget.sortbyid;
        cusinescolor1 = widget.sortby;
        cusinescolor2 = widget.storetypes;
        cusinescolor3 = widget.cusines;
        showsearchrestuarent = widget.fromsortshoerestuarent;
      });
      log("Cusinescolor : ${cusinescolor3}");
      log("sortbycolor : ${cusinescolor1}");
      log("storecolor : ${cusinescolor2}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final searcgstatus = context.watch<SearcgCubit>().state;
    SearchModel? searchdata = searcgstatus.searchdata;

    // switch (searcgstatus.status) {
    //   case SearchStatus.initial:
    //     return Container();
    //   case SearchStatus.loading:
    //     return CircularProgressIndicator();
    //   case SearchStatus.loaded:
    return SafeArea(
      child: Container(
          color: const Color.fromARGB(255, 229, 224, 224),
          child: Column(children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 50,
                color: Colors.white,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          // log("from searcg navigate${widget.showsortby}");
                          if (widget.showsortby != true) {
                            //  log("from searcg navigate inside : ${widget.showsortby}");
                            Navigator.pop(context);
                          } else {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ));
                          }
                        },
                        icon: const Icon(Icons.arrow_back_ios)),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 227, 229, 231),
                          borderRadius: BorderRadius.circular(5)),
                      height: MediaQuery.of(context).size.height > 500
                          ? MediaQuery.of(context).size.height / 20
                          : MediaQuery.of(context).size.height / 10,
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                autofocus: true,
                                onTap: () {
                                  setState(() {
                                    searching = searching2;
                                  });
                                },
                                onChanged: (value) {
                                  if (value.length > 2) {
                                    setState(() {
                                      searching = !searching;
                                      visible = false;
                                      searching2 = searching;
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    });
                                  }
                                },
                                controller: controller,
                                decoration: const InputDecoration(
                                    hintText: "What are you craving?",
                                    hintStyle: TextStyle(
                                        fontSize: 17, color: Colors.black38),
                                    prefixIcon: Icon(
                                      Icons.search_rounded,
                                      color: Colors.black,
                                    ),
                                    border: InputBorder.none),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // controller.clear();
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                setState(() {
                                  controller.text = "";
                                  // showsearchrestuarent = true;
                                });
                                // log("From Inkwell :$showsearchrestuarent");
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            showsearchrestuarent == true || searching == true
                ? Expanded(
                    flex: 9,
                    child: SearchRestuarentFilter(
                      itemname: controller.text,
                      fromsearchonly: true,
                      cusinesid: cusinid,
                      sorttypeid: sorttypeid,
                      sortbyid: sortbyid,
                      cusines: cusinescolor3,
                      sortby: cusinescolor1,
                      storetypes: cusinescolor2,
                      // sortby: ,
                      // sortby: sorttypeid,
                    ))
                : Expanded(
                    flex: 9,
                    child: Visibility(
                        visible: visible,
                        replacement: SearchRestuarentFilter(
                          itemname: controller.text,
                          fromsearchonly: true,
                          cusinesid: cusinid,
                          sorttypeid: sorttypeid,
                          sortbyid: widget.sortbyid,
                          cusines: cusinescolor3,
                          sortby: cusinescolor1,
                          storetypes: cusinescolor2,
                        ),
                        child: searchreplacebelow(context, searchdata)),
                  )
          ])),
    );

    // case SearchStatus.error:
    //   return Container();
    // }
  }

  // METHOD FOR SEARCH PAGE BELOW

  Container searchreplacebelow(BuildContext context, SearchModel? searchdata) {
    return Container(
      height: 700,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        children: [
          const Divider(
            thickness: 7,
            color: const Color.fromARGB(255, 229, 224, 224),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 24),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Cuisines",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Store types",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                ),
                searchdata == null
                    ? Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            SizedBox(
                              height: 20,
                            ),
                            Skeleton(
                              radius: 1,
                              height: 40,
                              width: 310,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Skeleton(
                              radius: 1,
                              height: 40,
                              width: 310,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Skeleton(
                              radius: 1,
                              height: 40,
                              width: 310,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Skeleton(
                              radius: 1,
                              height: 40,
                              width: 310,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Skeleton(
                              radius: 1,
                              height: 40,
                              width: 310,
                            ),
                          ],
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 170,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: searchdata.cuisines.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: InkWell(
                                    onTap: () {
                                      cusinescolor3 = "Cuisines";
                                      setState(() {
                                        showsearchrestuarent = true;
                                        cusinid = searchdata.cuisines[index].id
                                            .toString();
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                      });
                                    },
                                    child: Text(
                                        searchdata.cuisines[index].cuisineName),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          SizedBox(
                            width: 150,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: searchdata.storeTypes.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    cusinescolor2 = "Store types";
                                    setState(() {
                                      showsearchrestuarent = true;
                                      sorttypeid = searchdata
                                          .storeTypes[index].id
                                          .toString();
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child:
                                        Text(searchdata.storeTypes[index].name),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
} // END OF CODE FOR THIS PAGE




