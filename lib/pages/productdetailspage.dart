import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwifi/logic/productdetails/productdetails_cubit.dart';

import 'package:foodwifi/model/joinmodel.dart';
import 'package:foodwifi/widget/firstlistContainerSkeleton.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../logic/productdetails/productdetails_state.dart';

class ProductDetailsPage extends StatefulWidget {
  // final List<JoinReviewBellowModel>? finaljoinreviewandbelowlist;
  // final int categoryindex;
  // final int productindex;

  final Product? products;

//  final String category_id;

  const ProductDetailsPage({
    super.key,
    required this.products,
    // required this.finaljoinreviewandbelowlist,
    // required this.categoryindex,
    // required this.productindex,
    // required this.category_id
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int? selectedindex;
  int itemcount = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<ProductsDetailsCubit>()
        .getproductsdetails(widget.products!.id.toString()
            // widget
            //   .finaljoinreviewandbelowlist![widget.categoryindex]
            //   .products[widget.productindex]
            //   .id
            //   .toString()
            );
    log(widget.products!.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    final datastatus = context.watch<ProductsDetailsCubit>().state;
    log("product details data : $datastatus");

    switch (datastatus.status) {
      case DetailsStatus.initial:
        return Container();
      case DetailsStatus.loading:
        return Center(
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
        );

      case DetailsStatus.loaded:
        return Scaffold(
          body: SingleChildScrollView(
            child: Stack(children: [
              Column(
                children: [
                  SizedBox(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      "https://globizs.sgp1.cdn.digitaloceanspaces.com/foodwifi/${widget.products!.img}",
                      fit: BoxFit.cover,
                      alignment: const Alignment(-0.1, -1),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.products!.name,
                                style: const TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Text(
                                    widget.products!.price ==
                                            widget.products!.offer.offerPrice
                                        ? ""
                                        : "₹${widget.products!.price}",
                                    style: const TextStyle(
                                        color: Colors.black87,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    maxLines: 3,
                                    widget.products!.offer.offerPrice == null
                                        ? ""
                                        : "₹${widget.products!.offer.offerPrice!.toInt()}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              widget.products!.offer.description!.isEmpty
                                  ? Container()
                                  : Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0),
                                        color: const Color.fromARGB(
                                            255, 25, 132, 95),
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
                                              widget.products!.offer.description
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              const Text(
                                "Starting price",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 181, 179, 179)),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              widget.products!.description.toString(),
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 174, 169, 169)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Container(
                    // height: 300,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    Text(
                                      "Select one",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 246, 22, 6),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 20,
                                      //width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          color: const Color.fromARGB(
                                              255, 255, 255, 7)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, right: 4),
                                        child: Row(
                                          children: const [
                                            Icon(
                                              Icons.warning_amber,
                                              color: Colors.black,
                                              size: 10,
                                            ),
                                            Text(
                                              "Required",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          const Divider(
                            height: 20,
                            thickness: 1,
                            indent: 0,
                            endIndent: 0,
                            color: Color.fromARGB(255, 227, 221, 221),
                          ),
                          SizedBox(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  datastatus.productdetails!.variants.length,
                              itemBuilder: (context, index) {
                                return datastatus
                                        .productdetails!.variants.isEmpty
                                    ? const Skeleton(
                                        radius: 10,
                                        height: 40,
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: RadioListTile(
                                              visualDensity:
                                                  const VisualDensity(
                                                      horizontal: VisualDensity
                                                          .minimumDensity,
                                                      vertical: VisualDensity
                                                          .minimumDensity),
                                              dense: true,
                                              contentPadding: EdgeInsets.zero,
                                              activeColor: Colors.red,
                                              value: index,
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    datastatus.productdetails!
                                                        .variants[index].unit
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        datastatus
                                                                    .productdetails!
                                                                    .variants[
                                                                        index]
                                                                    .price ==
                                                                datastatus
                                                                    .productdetails!
                                                                    .variants[
                                                                        index]
                                                                    .offerPrice
                                                            ? ""
                                                            : '₹${datastatus.productdetails!.variants[index].price}',
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.black,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "₹${datastatus.productdetails!.variants[index].offerPrice!.toInt()}",
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              groupValue: selectedindex,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedindex = value;
                                                  log(selectedindex.toString());
                                                });
                                              },
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 25),
                                            child: Divider(
                                              height: 20,
                                              thickness: 1,
                                              indent: 20,
                                              endIndent: 0,
                                              color: Color.fromARGB(
                                                  255, 199, 194, 194),
                                            ),
                                          ),
                                        ],
                                      );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text(
                                "Note to restuarants",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                "Optional",
                                style: TextStyle(color: Colors.black54),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Add your request ( subject to restaurant's discretion)",
                            style: TextStyle(
                                color: Color.fromARGB(137, 71, 69, 69)),
                          ),
                          const Divider(
                            height: 20,
                            thickness: 1,
                            indent: 20,
                            endIndent: 0,
                            color: Color.fromARGB(255, 227, 221, 221),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  //color: Colors.green[900]
                                ),
                                child: Row(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (itemcount > 1) {
                                              itemcount--;
                                            }
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: const Icon(
                                            Icons.remove,
                                            color:
                                                Color.fromARGB(255, 5, 121, 9),
                                            size: 20,
                                          ),
                                        )),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 3),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 3, vertical: 2),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: Colors.white),
                                      child: Text(
                                        itemcount.toString(),
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            itemcount++;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: const Icon(
                                            Icons.add,
                                            color:
                                                Color.fromARGB(255, 2, 125, 6),
                                            size: 20,
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 200,
                    color: const Color.fromARGB(255, 237, 232, 232),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 55, left: 15, right: 15),
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.black45,
                  child: Center(
                    child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Center(
                          child: Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ),
              ),
            ]),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            padding: const EdgeInsets.all(20),
            height: 90,
            color: Colors.white,
            child: SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: FloatingActionButton(
                elevation: 10,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(2)),
                backgroundColor: Colors.red,
                child: const Text("Add to Cart"),
                onPressed: () {},
              ),
            ),
          ),
        );
      case DetailsStatus.error:
        return Container();
    }

    // ProductDetailsModel? productdetailsdata = productdetails.productdetails;
  }

  // Widget _buildBody() {
  //   return Scaffold(
  //     body: Center(
  //       child: Text("tgfhjn"),
  //     ),
  //   );
  // }

  // Widget _loading() {
  //   return Scaffold(
  //     body: Center(
  //       child: Text("tgfhjn"),
  //     ),
  //   );
  // }
}
