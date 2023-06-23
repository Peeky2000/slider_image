import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:imageapp/provider/item_provider.dart';
import 'package:imageapp/util/item_%20model.dart';
import 'package:imageapp/widgets/widget/ui_card.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double rating = 4.0;
  late Future items;
  bool isFavorite = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    items = Provider.of<ItemProvider>(context, listen: false).readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<ItemProvider>(
            builder: (context, item, child) {
              return Badge(
                label: Text(
                  item.countItemFavorite.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                child: const Icon(
                  Icons.favorite,
                ),
              );
            },
          ),
        ),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              setState(
                () {
                  if (value == 1) {
                    isFavorite = false;
                  } else {
                    isFavorite = true;
                  }
                },
              );
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                    Text("All Images"),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    Icon(
                      Icons.favorite_border,
                      color: Colors.black,
                    ),
                    Text("Favorite Images"),
                  ],
                ),
              ),
            ],
            offset: const Offset(0, 50),
            color: Colors.grey,
            elevation: 2,
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Consumer<ItemProvider>(
            builder: (context, value, child) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.bounceIn,
                child: value.bgUrl.isNotEmpty
                    ? Image.network(
                        value.bgUrl,
                        fit: BoxFit.cover,
                      )
                    : null,
              );
            },
          ),
          Positioned.fill(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: const SizedBox()),
          ),
          FutureBuilder(
            future: items,
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (asyncSnapshot.hasData) {
                final List<Item> _data = asyncSnapshot.data as List<Item>;
                var data = isFavorite ? _data.where((element) => element.isFavorite == true).toList() : _data;
                return UICard(items: data);
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
