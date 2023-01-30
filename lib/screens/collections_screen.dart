import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/collections.dart';
import '../screens/collection_screen.dart';

class CollectionsScreen extends StatelessWidget {
  static const routeName = '/collectionsScreen';
  const CollectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final collxnData = Provider.of<Collections>(context);
    final collxnList = collxnData.items;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.keyboard_arrow_left_rounded,
              size: 30,
              color: Color.fromARGB(190, 51, 51, 51),
            ),
          ),
        ),
        title: const Text(
          'Collections',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
          itemCount: collxnList.length,
          itemBuilder: (ctx, i) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => CollectionScreen(collxnList[i]),
                  ),
                );
              },
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.7), BlendMode.dstATop),
                    image: NetworkImage(collxnList[i].bannerUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Text(
                    collxnList[i].name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'BodoniModa-Italic',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
