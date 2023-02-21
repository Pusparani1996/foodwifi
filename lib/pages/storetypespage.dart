import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwifi/logic/search/search_cubit.dart';
import 'package:foodwifi/model/searchModel.dart';
import 'package:foodwifi/pages/search_page.dart';
import 'package:foodwifi/pages/searchrestuarentfilter_page.dart';
import 'package:foodwifi/widget/firstlistContainerSkeleton.dart';

class StoreTypesPage extends StatefulWidget {
  const StoreTypesPage({
    super.key,
    required this.cusines,
    required this.storetypes,
    required this.showsearchrestuarent,
    required this.abovetxt,
    required this.sortby,
    required this.showresetbtn,
    required this.freedilivery,
    required this.storetypeid,
    required this.radiostoretypeidlist,
    this.showbelowhomesearch,
  });

  final String? cusines;
  final String? storetypes;
  final bool? showsearchrestuarent;
  final String? abovetxt;
  final String? sortby;
  final bool? showresetbtn;
  final String freedilivery;
  final String storetypeid;
  final List radiostoretypeidlist;
  final bool? showbelowhomesearch;

  @override
  State<StoreTypesPage> createState() => _StoreTypesPageState();
}

class _StoreTypesPageState extends State<StoreTypesPage> {
  int? selectedindex;
  bool showsortby = false;
  String showresetfilter = "";
  String storetypeid = "";
  bool showreset = false;
  bool resetdata = false;

  List<StoreType> searchdata = [];
  List<StoreType> radiostoretype = [];
  List radiostoretypelist = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SearcgCubit>().getsearch();
    log("from storetype : ${widget.radiostoretypeidlist}");
    log("from storetype id : ${widget.storetypeid}");

    if (widget.storetypeid.isNotEmpty) {
      setState(() {
        selectedindex = widget.radiostoretypeidlist.indexOf(widget.storetypeid);
      });
      log("SELECTED INDEX FROM STORETYPE : $selectedindex");
      log(widget.radiostoretypeidlist.toString());
      log(widget.storetypeid.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final searcgstatus = context.watch<SearcgCubit>().state;
    if (searcgstatus.searchdata != null) {
      searchdata = searcgstatus.searchdata!.storeTypes;
      for (var element in radiostoretype) {
        radiostoretypelist.add(element.id);
        log("id :" + element.id);
      }
    }

    return showsortby
        ? SearchPage(
            textvalue: widget.abovetxt!,
            cusines: widget.cusines!,
            showsortby: showsortby,
            storetypes: 'Store types',
            sortbyid: "",
            sortby: widget.sortby!,
            fromsortshoerestuarent: true,
            cuisinesid: "",
            storetypeid: storetypeid,
            resetdata: false,
            checkcuisinesname: '',
            addcheckcuisinesdata: false,
            freedelivery: widget.freedilivery,
            freedeliveryid: "",
            halal: '',
            promoid: '',
            freedeliverycolor: false,
            halalcolor: false,
            promocolor: false,
          )
        : resetdata == true
            ? SearchPage(
                textvalue: widget.abovetxt!,
                cusines: "",
                showsortby: showsortby,
                freedelivery: widget.freedilivery,
                storetypes: "",
                sortbyid: "",
                sortby: "",
                fromsortshoerestuarent: true,
                cuisinesid: "",
                storetypeid: '',
                resetdata: true,
                checkcuisinesname: '',
                addcheckcuisinesdata: false,
                freedeliveryid: '',
                halal: '',
                promoid: '',
                freedeliverycolor: false,
                halalcolor: false,
                promocolor: false,
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
                                Icon(
                                  Icons.store,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  "Store types",
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: RadioListTile(
                                          // controlAffinity: ListTileControlAffinity.trailing,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    // searchdata[index].name == "Rating"
                                                    //     ? const Icon(Icons.star)
                                                    //     : Transform.rotate(
                                                    //         angle: 120,
                                                    //         child: const Icon(
                                                    //             Icons.navigation_outlined)),

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
                                              selectedindex = value;
                                              showreset = true;
                                              log(selectedindex.toString());
                                            });
                                          },
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

                                storetypeid = searchdata[selectedindex!].id;
                                //  bool for navigate to searchpage
                                //showsortby = false;
                              });
                              Navigator.pop(
                                context,
                                storetypeid,
                              );
                            } else {
                              setState(() {
                                log("Pressed");

                                storetypeid = searchdata[selectedindex!].id;
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
                          ? selectedindex == null
                              ? const SizedBox()
                              : Card(
                                  elevation: 20,
                                  shadowColor: Colors.grey,
                                  // color: Colors.grey,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        resetdata = true;
                                        // cuisinsid = searchdata[selectedindex!]
                                        //     .id
                                        //     .toString();
                                      });
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
                                  setState(() {
                                    resetdata = true;
                                    // cuisinsid = searchdata[selectedindex!]
                                    //     .id
                                    //     .toString();
                                  });
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
