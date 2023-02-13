import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwifi/logic/search/search_cubit.dart';
import 'package:foodwifi/model/searchModel.dart';
import 'package:foodwifi/pages/search_page.dart';
import 'package:foodwifi/pages/searchrestuarentfilter_page.dart';

class CusinesPage extends StatefulWidget {
  const CusinesPage(
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
  State<CusinesPage> createState() => _CusinesPageState();
}

class _CusinesPageState extends State<CusinesPage> {
  int? selectedindex;
  bool showsortby = false;
  String showresetfilter = "";
  String cuisinsid = "";
  bool showreset = false;

  List<Cuisine> searchdata = [];
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
      searchdata = searcgstatus.searchdata!.cuisines;
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
            cusines: 'Cuisines',
            showsortby: showsortby,
            storetypes: '',
            sortbyid: "",
            sortby: '',
            fromsortshoerestuarent: true,
            cuisinesid: cuisinsid,
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
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: RadioListTile(
                                // controlAffinity: ListTileControlAffinity.trailing,
                                visualDensity: const VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                    vertical: VisualDensity.minimumDensity),
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
                                          Text(
                                            searchdata[index].cuisineName,
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
                    height: 260,
                  ),
                  Card(
                    elevation: 10,
                    shadowColor: Colors.grey,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          log("Pressed");
                          cuisinsid = searchdata[selectedindex!].id.toString();
                          log("Cuisines page cuisinesid :${searchdata[selectedindex!].id}");
                          showsortby = true;
                        });
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
