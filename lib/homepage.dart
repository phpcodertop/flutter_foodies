import 'dart:convert';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List placesList = [];

  Future<List> getJsonList(BuildContext context) async {
    final jsonData =
        await DefaultAssetBundle.of(context).loadString('assets/data.json');
    List jsonList = jsonDecode(jsonData);
    return jsonList;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      placesList = await getJsonList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    var bannerItems = ["Burger", "Cheese Chilly", "Noodles", "Pizza"];
    var bannerImage = [
      "images/burger.jpg",
      "images/cheesechilly.jpg",
      "images/noodles.jpg",
      "images/pizza.jpg"
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: const [
          Icon(
            Icons.person,
            size: 30,
          ),
          SizedBox(
            width: 20,
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: const Text(
          'Foodies',
          style: TextStyle(
            fontFamily: 'Samantha',
            fontSize: 60,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // top slider
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final (index, item) in bannerItems.indexed)
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(16),
                          width: screenWidth * 0.80,
                          height: 250,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              backgroundBlendMode: BlendMode.darken,
                              borderRadius: BorderRadius.circular(40),
                              image: DecorationImage(
                                image: AssetImage(bannerImage[index]),
                                fit: BoxFit.cover,
                              )),
                        ),
                        Container(
                          margin: const EdgeInsets.all(16),
                          width: screenWidth * 0.80,
                          height: 250,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        Positioned(
                          top: 170,
                          left: 17,
                          height: 70,
                          child: Container(
                            height: 70,
                            width: screenWidth * 0.8,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.9),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                )),
                          ),
                        ),
                        Positioned(
                          top: 170,
                          left: 30,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                'More than 40% off',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(16),
                  //
                  //   child: Container(
                  //     margin: const EdgeInsets.only(left: 25),
                  //     child: Image.asset(
                  //       bannerImage[index],
                  //       height: 250,
                  //       width: screenWidth * 0.80,
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   margin: const EdgeInsets.all(20),
                  //   height: 250,
                  //   width: screenWidth * 0.80,
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //       image: AssetImage(bannerImage[index]),
                  //       fit: BoxFit.cover,
                  //     ),
                  //     borderRadius: BorderRadius.circular(40),
                  //   ),
                  // ),
                ],
              ),
            ),

            for (final place in placesList)
              Card(
                elevation: 5,
                margin: const EdgeInsets.all(15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      place['placeImage'],
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        top: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            place['placeName'],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              (place['placeItems'])!.join(' | '),
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Text(
                            "Min. Order: ${place["minOrder"]}",
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
