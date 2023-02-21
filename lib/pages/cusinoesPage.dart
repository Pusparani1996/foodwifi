import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwifi/logic/search/search_cubit.dart';
import 'package:foodwifi/model/searchModel.dart';
import 'package:foodwifi/pages/search_page.dart';
import 'package:foodwifi/router/router.gr.dart';
import 'package:foodwifi/widget/firstlistContainerSkeleton.dart';

class CusinesPage extends StatefulWidget {
  const CusinesPage(
      {super.key,
      required this.cusines,
      required this.storetypes,
      required this.showsearchrestuarent,
      required this.abovetxt,
      required this.sortby,
      required this.showresetbtn,
      required this.checkcuisines,
      required this.cuisinesitems,
      required this.freedilivery,
      required this.cuisinesid,
      this.showbelowhomesearch,
      required this.allcuisines});

  final String? cusines;
  final String? storetypes;
  final String? sortby;
  final bool? showsearchrestuarent;
  final String? abovetxt;
  final bool? showresetbtn;
  // cuisinesitems
  final List<dynamic> cuisinesitems;
  final Map checkcuisines;
  final String freedilivery;
  final String cuisinesid;
  final bool? showbelowhomesearch;
  final String allcuisines;

  @override
  State<CusinesPage> createState() => _CusinesPageState();
}

class _CusinesPageState extends State<CusinesPage> {
  int? selectedindex;
  bool showsortby = false;
  String showresetfilter = "";
  String cuisinsid = "";
  bool resetdata = false;

  List<Cuisine> searchdata = [];

  //USED FOR CHECKBOX
  Map values = {};
  String allcuisines = "";
  bool addcheckcuisinesdata = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // context.read<SearcgCubit>().getsearch();
    log("Cuisines id : ${widget.cuisinesid}");
    log("allcuisines : ${widget.allcuisines}");
    log("checkcuisines : ${widget.checkcuisines}");
    log("cuisinesitems : ${widget.cuisinesitems}");
    log("showsearchrestuarent : ${widget.showsearchrestuarent}");
    log("shoehomerestuarents : ${widget.showbelowhomesearch}");

    if (widget.showsearchrestuarent == true ||
        widget.showbelowhomesearch == true) {
      if (widget.allcuisines.isNotEmpty) {
        log(" first IF all cuisines : ${widget.allcuisines}");
        List data = widget.allcuisines.split(',');
        log("DATA : $data");
        for (var element in widget.cuisinesitems) {
          if (data.contains(widget.checkcuisines[element].toString())) {
            values[element] = true;
          } else {
            values[element] = false;
          }
        }
      } else {
        for (var element in widget.cuisinesitems) {
          values[element] = false;
        }
      }
    } else {
      if (widget.cuisinesid.isNotEmpty) {
        log(" second else all cuisines : ${widget.allcuisines}");
        if (widget.allcuisines.isNotEmpty) {
          List data = widget.allcuisines.split(',');
          log(" second else data : ${data}");
          for (var element in widget.cuisinesitems) {
            if (data.contains(widget.checkcuisines[element].toString())) {
              values[element] = true;
            } else {
              values[element] = false;
            }
          }
          log(" second else  values : $values");
        } else {
          for (var element in widget.cuisinesitems) {
            if (widget.checkcuisines[element].toString() == widget.cuisinesid) {
              values[element] = true;
            } else {
              values[element] = false;
            }
          }
        }
      } else {
        for (var element in widget.cuisinesitems) {
          values[element] = false;
        }
      }
    }
  }

  var temparray = [];
  getcgeckboxitems() {
    values.forEach((key, value) {
      if (value == true) {
        log("value : $value");
        temparray.add(widget.checkcuisines[key]);
      }
    });
    setState(() {
      allcuisines = temparray.join(',');
    });
    log("FROM FUNCTION ALLCUISINES : $allcuisines");
  }

  @override
  Widget build(BuildContext context) {
    final searcgstatus = context.watch<SearcgCubit>().state;
    if (searcgstatus.searchdata != null) {
      searchdata = searcgstatus.searchdata!.cuisines;
    }

    return showsortby
        ? SearchPage(
            textvalue: widget.abovetxt!,
            cusines: 'Cuisines',
            showsortby: showsortby,
            storetypes: widget.storetypes!,
            sortbyid: "",
            sortby: widget.sortby!,
            fromsortshoerestuarent: true,
            cuisinesid: cuisinsid,
            storetypeid: '',
            resetdata: false,
            checkcuisinesname: allcuisines,
            addcheckcuisinesdata: addcheckcuisinesdata,
            freedelivery: widget.freedilivery, freedeliveryid: '', halal: '',
            promoid: '',
            freedeliverycolor: false, halalcolor: false, promocolor: false,

            // freedelivery: "",
            // halal: '', promo: ''
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
                checkcuisinesname: allcuisines,
                addcheckcuisinesdata: addcheckcuisinesdata,
                freedelivery: widget.freedilivery, freedeliveryid: '',
                halal: '', promoid: '',
                freedeliverycolor: false, halalcolor: false, promocolor: false,
                //   freedelivery: '', halal: '', promo: ''
                //  ,
              )
            : Scaffold(
                body: SafeArea(
                  child: ListView(
//child: Column(
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
                                Icon(Icons.restaurant_menu_rounded),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Cuisines",
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
                                          255, 162, 172, 182)),
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
                                  height: 17,
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
                                  height: 27,
                                ),
                              ],
                            )
                          : SizedBox(
                              height: 300,
                              child: ListView.builder(
                                itemCount: searchdata.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: CheckboxListTile(
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity),
                                          dense: true,
                                          contentPadding: EdgeInsets.zero,
                                          activeColor: Colors.red,
                                          value: values[
                                              widget.cuisinesitems[index]],
                                          onChanged: (value) {
                                            setState(() {
                                              values[widget
                                                      .cuisinesitems[index]] =
                                                  value;
                                              addcheckcuisinesdata = true;
                                            });
                                          },

                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15, right: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      searchdata[index]
                                                          .cuisineName,
                                                      style: const TextStyle(
                                                        fontSize: 15,
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
                                          // groupValue: selectedindex,
                                        ),
                                      ),
                                      const Divider(
                                        thickness: 1,
                                        indent: 70,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                      const SizedBox(
                        height: 260,
                      ),
                      Card(
                        elevation: 10,
                        shadowColor: Colors.grey,
                        child: InkWell(
                          onTap: () {
                            if (widget.showbelowhomesearch == true) {
                              getcgeckboxitems();
                              setState(() {
                                // log("Cuisines page cuisinesid :${searchdata[selectedindex!].id}");
                                showsortby = false;
                                addcheckcuisinesdata = true;
                              });
                              Navigator.pop(context, allcuisines);
                            } else {
                              getcgeckboxitems();
                              setState(() {
                                showsortby = true;
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
                      // widget.showresetbtn != true
                      widget.cusines!.isEmpty &&
                              widget.sortby!.isEmpty &&
                              widget.storetypes!.isEmpty
                          ? addcheckcuisinesdata == false
                              ? const SizedBox()
                              : Card(
                                  elevation: 20,
                                  shadowColor: Colors.grey,
                                  // color: Colors.grey,
                                  child: InkWell(
                                    onTap: () {
                                      log("press");
                                      if (widget.showbelowhomesearch == true) {
                                        setState(() {
                                          resetdata = false;
                                        });
                                        Navigator.pop(context);
                                      } else {
                                        setState(() {
                                          resetdata = true;
                                          // showsortby = true;
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
                              // color: Colors.grey,
                              child: InkWell(
                                onTap: () {
                                  if (widget.showbelowhomesearch == true) {
                                    log("press2");
                                    setState(() {
                                      resetdata = false;
                                    });
                                    Navigator.pop(context);
                                  } else {
                                    setState(() {
                                      resetdata = true;
                                      // showsortby = true;
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
                //   ),
              );
  }
}
