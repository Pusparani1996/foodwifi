import 'package:flutter/material.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(shrinkWrap: true, children: [
        Container(
          color: const Color.fromARGB(255, 235, 232, 232),
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height / 13,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 8, top: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "My orders",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
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
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height / 1,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 2.5,
                            width: MediaQuery.of(context).size.height / 3.2,
                            child: Image.asset(
                              "assets/images/burgermyorder.png",
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "You have not placed any orders yet!",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 172, 173, 177),
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
