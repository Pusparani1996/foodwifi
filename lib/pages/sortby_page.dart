import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:foodwifi/logic/search/search_cubit.dart';
import 'package:foodwifi/model/searchModel.dart';
import 'package:foodwifi/pages/search_page.dart';

import 'package:foodwifi/widget/firstlistContainerSkeleton.dart';

class SortByPage extends StatefulWidget {
  const SortByPage({
    super.key,
    required this.cusines,
    required this.storetypes,
    required this.showsearchrestuarent,
    required this.abovetxt,
    required this.showresetbtn,
    required this.freedelivery,
    this.showbelowhomesearch,
    required this.halal,
    required this.promo,
    required this.cuisinesid,
    required this.storetypeid,
    required this.sortbyname,
    required this.radiosortbyidlist,
    required this.sortbyid,
  });

  final String? cusines;
  final String? storetypes;
  final bool? showsearchrestuarent;
  final String? abovetxt;
  final bool? showresetbtn;
  final String freedelivery;
  final String halal;
  final String promo;
  final bool? showbelowhomesearch;
  final String cuisinesid;
  final String storetypeid;
  final String sortbyid;
  final String sortbyname;
  final List radiosortbyidlist;

  // final String halal;
  // final String promo;

  @override
  State<SortByPage> createState() => _SortByPageState();
}

class _SortByPageState extends State<SortByPage> {
  int? selectedindex;
  bool showsortby = false;
  String showresetfilter = "";
  String sortbyid = "";
  // String? sortby= "";
  bool showreset = false;
  bool resetdata = false;
  String shortby = 'Sort by';

  List<SortOption> searchdata = [];
  List<SortOption> radiosortby = [];
  List radiosortbylist = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SearcgCubit>().getsearch();
    log("Sort by init");
    log("Sort by id init : ${widget.sortbyid}");

    if (widget.sortbyid.isNotEmpty) {
      log("Sort by init if ");

      setState(() {
        selectedindex = int.parse(widget.sortbyid) - 1;
      });
      log("SELECTED INDEX FROM Sortby : $selectedindex");
    }
  }

  @override
  Widget build(BuildContext context) {
    final searcgstatus = context.watch<SearcgCubit>().state;
    if (searcgstatus.searchdata != null) {
      searchdata = searcgstatus.searchdata!.sortOptions;
    }

    return showsortby
        ? SearchPage(
            textvalue: widget.abovetxt!,
            cusines: widget.cusines!,
            showsortby: showsortby,
            storetypes: widget.storetypes!,
            sortbyid: sortbyid,
            sortby: shortby,
            fromsortshoerestuarent: true,
            cuisinesid: "",
            storetypeid: '',
            resetdata: false,

            addcheckcuisinesdata: false,
            freedelivery: widget.freedelivery,
            freedeliveryid: '',
            halal: '',
            promoid: '',
            freedeliverycolor: false, halalcolor: false,
            promocolor: false, checkcuisinesname: '',
            // halal: '',
            // promo: '',
          )
        : resetdata == true
            ? SearchPage(
                textvalue: widget.abovetxt!,
                cusines: '',
                showsortby: showsortby,
                storetypes: "",
                sortbyid: "",
                sortby: "",
                fromsortshoerestuarent: true,
                cuisinesid: "",
                storetypeid: '',
                resetdata: true,
                checkcuisinesname: '',
                addcheckcuisinesdata: false,
                freedelivery: widget.freedelivery, freedeliveryid: '',
                halal: '', promoid: '',
                freedeliverycolor: false,
                halalcolor: false, promocolor: false,
                // halal: '',
                // promo: '',
              )
            : Scaffold(
                body: SafeArea(
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.menu),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Sort by",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 167, 168, 169),
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color.fromARGB(
                                          255, 167, 168, 169)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Icon(
                                      Icons.close,
                                      size: 17,
                                      color: Colors.white,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      searchdata.isEmpty
                          ? Column(
                              children: const [
                                SizedBox(
                                  height: 10,
                                ),
                                Skeleton(
                                  radius: 2,
                                  height: 50,
                                  width: 340,
                                ),
                                SizedBox(
                                  height: 17,
                                ),
                                Skeleton(
                                  radius: 2,
                                  height: 50,
                                  width: 340,
                                ),
                                SizedBox(
                                  height: 200,
                                )
                              ],
                            )
                          : SizedBox(
                              height: 300,
                              child: ListView.builder(
                                itemCount: searchdata.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      RadioListTile(
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                        visualDensity: const VisualDensity(
                                            horizontal:
                                                VisualDensity.minimumDensity,
                                            vertical:
                                                VisualDensity.minimumDensity),
                                        dense: true,
                                        contentPadding: EdgeInsets.zero,
                                        activeColor: Colors.red,
                                        value: index,
                                        title: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  searchdata[index].name ==
                                                          "Rating"
                                                      ? const Icon(Icons.star)
                                                      : Transform.rotate(
                                                          angle: 120,
                                                          child: const Icon(Icons
                                                              .navigation_outlined)),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(
                                                    searchdata[index].name,
                                                    style: const TextStyle(
                                                      // color: Colors.blueGrey,
                                                      fontSize: 15,
                                                      // fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                            ],
                                          ),
                                        ),
                                        groupValue: selectedindex,
                                        onChanged: (value) {
                                          setState(() {
                                            // widget.showresetbtn == true;
                                            selectedindex = value!;
                                            showreset = true;
                                            log(selectedindex.toString());
                                          });
                                        },
                                      ),
                                      const Divider(
                                        thickness: 1,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                      const SizedBox(
                        height: 250,
                      ),
                      Card(
                        elevation: 10,
                        shadowColor: Colors.grey,
                        child: InkWell(
                          onTap: () {
                            if (widget.showbelowhomesearch == true) {
                              setState(() {
                                log("Pressed");
                                sortbyid =
                                    searchdata[selectedindex!].id.toString();
                                showsortby = false;
                                log("SORT BY ID : $sortbyid");
                              });
                              Navigator.pop(
                                context,
                                sortbyid,
                              );
                            } else {
                              setState(() {
                                log("Pressed");
                                sortbyid =
                                    searchdata[selectedindex!].id.toString();
                                showsortby = true;
                                log("SORT BY ID : $sortbyid");
                              });
                            }
                          },
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.red),
                            child: const Center(
                              child: Text(
                                "Search",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      //   widget.showresetbtn != true
                      widget.cusines!.isEmpty &&
                              shortby.isEmpty &&
                              widget.storetypes!.isEmpty
                          ? selectedindex == null
                              ? const SizedBox()
                              : Card(
                                  elevation: 20,
                                  shadowColor: Colors.grey,
                                  child: InkWell(
                                    onTap: () {
                                      if (widget.showbelowhomesearch == true) {
                                        log("press2");
                                        setState(() {
                                          resetdata = false;
                                        });
                                        Navigator.pop(context, "true");
                                      } else {
                                        setState(() {
                                          resetdata = true;
                                        });
                                      }
                                    },
                                    child: Container(
                                      height: 45,
                                      width: MediaQuery.of(context).size.width /
                                          1.1,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white),
                                      child: const Center(
                                        child: Text(
                                          "Reset Filters",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                          : Card(
                              elevation: 20,
                              shadowColor: Colors.grey,
                              child: InkWell(
                                onTap: () {
                                  if (widget.showbelowhomesearch == true) {
                                    log("press2");
                                    setState(() {
                                      resetdata = false;
                                    });
                                    Navigator.pop(context, "true");
                                  } else {
                                    setState(() {
                                      resetdata = true;
                                    });
                                  }
                                },
                                child: Container(
                                  height: 45,
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white),
                                  child: const Center(
                                    child: Text(
                                      "Reset Filters",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              );
  }
}
