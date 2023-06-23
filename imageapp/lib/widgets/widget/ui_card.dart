import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:imageapp/util/item_%20model.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../provider/item_provider.dart';
import '../description_page.dart';

class UICard extends StatefulWidget {
  final List<Item> items;
  const UICard({super.key, required this.items});

  @override
  State<UICard> createState() => _UICardState();
}

class _UICardState extends State<UICard> {
  double rating = 4.0;
  @override
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ItemProvider>(context, listen: false);
    return Container(
      child: widget.items.isNotEmpty
          ? CarouselSlider.builder(
              options: CarouselOptions(
                  viewportFraction: 0.68,
                  scrollDirection: Axis.vertical,
                  reverse: true,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.scale,
                  onPageChanged: (i, e) {
                    provider.setBgUrl(provider.items[i].image);
                  }),
              itemCount: widget.items.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return ChangeNotifierProvider.value(
                  value: widget.items[index],
                  child: InkWell(
                    onTap: () {
                      var item = widget.items[index];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DescriptionPage(
                            item: item,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 19,
                        vertical: 6,
                      ),
                      child: Card(
                        color: Colors.transparent,
                        shadowColor: Colors.white,
                        elevation: 10.0,
                        child: GridTile(
                          header: Padding(
                            padding: const EdgeInsets.all(22.0),
                            child: Text(
                              widget.items[index].name,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          footer: GridTileBar(
                            title: StatefulBuilder(
                              builder: (context, setStateStart) {
                                return SmoothStarRating(
                                  rating: rating,
                                  size: 26,
                                  filledIconData: Icons.star,
                                  halfFilledIconData: Icons.star_half,
                                  defaultIconData: Icons.star_border,
                                  starCount: 5,
                                  spacing: 1.0,
                                  color: Colors.yellow,
                                  borderColor: Colors.yellow,
                                  onRatingChanged: (value) {
                                    setStateStart(() {
                                      rating = value;
                                    });
                                  },
                                );
                              },
                            ),
                            subtitle: Text(
                              widget.items[index].description,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            trailing: Consumer<Item>(
                              builder: (context, item, child) {
                                return InkWell(
                                  onTap: () {
                                    item.toggleIsFavorite();
                                    Provider.of<ItemProvider>(context,
                                            listen: false)
                                        .handleCountItem();
                                  },
                                  child: Icon(
                                    Icons.favorite,
                                    size: 30.0,
                                    color: item.isFavorite
                                        ? Colors.red
                                        : Colors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              image: DecorationImage(
                                image:
                                    NetworkImage(provider.items[index].image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : const Text("No data"),
    );
  }
}
