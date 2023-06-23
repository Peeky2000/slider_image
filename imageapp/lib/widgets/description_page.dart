import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../provider/item_provider.dart';
import '../util/item_ model.dart';

class DescriptionPage extends StatefulWidget {
  DescriptionPage({Key? key, required this.item}) : super(key: key);


  var item;

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  double rating = 4.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.item.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                  top: 22.0,
                  left: 17.0,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.item.name,
                        style: const TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SmoothStarRating(
                        rating: rating,
                        size: 31,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        starCount: 5,
                        spacing: 1.0,
                        color: Colors.yellow,
                        borderColor: Colors.grey,
                        onRatingChanged: (value) {
                          setState(() {
                            rating = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 21.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.item.description,
                        style: const TextStyle(
                          fontSize: 21.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
