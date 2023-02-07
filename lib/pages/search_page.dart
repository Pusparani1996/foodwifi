import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwifi/logic/search/search_cubit.dart';

class SearchPage extends StatefulWidget {
  final String textvalue;

  const SearchPage({
    super.key,
    required this.textvalue,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = widget.textvalue;
  }

  @override
  Widget build(BuildContext context) {
    var data = context.watch<SearcgCubit>().state;
    //log(data.searchdata!.toJson().toString());
    return SafeArea(
      child: Container(
        color: const Color.fromARGB(255, 229, 224, 224),
        child: Column(
          children: [
            Container(
              height: 65,
              color: Colors.white,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
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
                      child: TextFormField(
                        controller: controller,
                        decoration: const InputDecoration(
                            //  hintText: "jhghfytryutr",
                            hintStyle:
                                TextStyle(fontSize: 20, color: Colors.black),
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              color: Colors.black,
                            ),
                            suffix: Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Container(
              height: 200,
              color: Colors.white,
              child: Text(data.searchdata.toString()),
            )
          ],
        ),
      ),
    );
  }
}
