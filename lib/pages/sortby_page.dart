import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwifi/logic/search/search_cubit.dart';
import 'package:foodwifi/model/searchModel.dart';
import 'package:foodwifi/pages/search_page.dart';
import 'package:foodwifi/pages/searchrestuarentfilter_page.dart';

class SortByPage extends StatefulWidget {
  const SortByPage(
      {super.key,
      required this.cusines,
      required this.storetypes,
      required this.showsearchrestuarent,
      required this.abovetxt});

  final String? cusines;
  final String? storetypes;
  final bool? showsearchrestuarent;
  final String? abovetxt;

  @override
  State<SortByPage> createState() => _SortByPageState();
}

class _SortByPageState extends State<SortByPage> {
  int? selectedindex;
  bool showsortby = false;
  String showresetfilter = "";
  String sortbyid = "";
  bool showreset = false;

  List<SortOption> searchdata = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SearcgCubit>().getsearch();
  }

  // void dispose() {
  //   super.dispose();

  //   // Your own cleanup code here...
  // }

  @override
  Widget build(BuildContext context) {
    final searcgstatus = context.watch<SearcgCubit>().state;
    if (searcgstatus.searchdata != null) {
      searchdata = searcgstatus.searchdata!.sortOptions;
    }

    return showsortby
        // ? SearchRestuarentFilter(
        //     itemname: widget.abovetxt!,
        //     fromsearchonly: false,
        //     cusinesid: searcgstatus
        //         .searchdata!.sortOptions[selectedindex!].id
        //         .toString(),
        //     sortbyid: selectedindex.toString(),
        //     cusines: '',
        //     sortby: 'Sort by',
        //     sorttypeid: '',
        //     storetypes: '',
        //   )
        ? SearchPage(
            textvalue: widget.abovetxt!,
            cusines: '',
            showsortby: showsortby,
            storetypes: '',
            sortbyid: "",
            sortby: 'Sort by',
            fromsortshoerestuarent: true,
            cuisinesid: '',
            storetypeid: '',
          )
        : Scaffold(
            body: SafeArea(
              child: Column(
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
                                  color: Color.fromARGB(255, 167, 168, 169)),
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
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: searchdata.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            RadioListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity),
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              activeColor: Colors.red,
                              value: index,
                              title: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        searchdata[index].name == "Rating"
                                            ? const Icon(Icons.star)
                                            : Transform.rotate(
                                                angle: 120,
                                                child: const Icon(
                                                    Icons.navigation_outlined)),
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
                                  selectedindex = value! + 1;
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
                    height: 260,
                  ),
                  Card(
                    elevation: 10,
                    shadowColor: Colors.grey,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          log("Pressed");
                          sortbyid = searchdata[selectedindex!].id.toString();
                          showsortby = true;
                        });
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => SearchPage(
                        //               textvalue: searcgstatus.searchdata!
                        //                   .sortOptions[selectedindex!].name,
                        //             )));
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
                  showresetfilter == widget.cusines ||
                          showresetfilter == widget.storetypes
                      //  || showreset == false
                      ? const SizedBox()
                      : Card(
                          elevation: 20,
                          shadowColor: Colors.grey,
                          // color: Colors.grey,
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width / 1.1,
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
                        )
                ],
              ),
            ),
          );
  }
}
