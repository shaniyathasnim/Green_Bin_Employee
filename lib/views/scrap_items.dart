import 'package:flutter/material.dart';
import 'package:green_bin_employee/widget/scrap_card.dart';
import '../utils/app_colors.dart';
import '../data/scrap_items_data.dart';

class ScrapItemPage extends StatefulWidget {
  const ScrapItemPage({super.key});

  @override
  State<ScrapItemPage> createState() => _ScrapItemPageState();
}

class _ScrapItemPageState extends State<ScrapItemPage> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final int crossAxisCount = screenWidth > 600 ? 4 : 2;

    return Scaffold(
      backgroundColor: White,

      appBar: AppBar(
        backgroundColor: White,
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Black,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Scrap Items',
          style: TextStyle(
            color: Black,
            fontSize: 18,
            fontWeight: FontWeight.w800,

          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),

            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                physics: const BouncingScrollPhysics(),

                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.1,
                ),

                // Correct list
                itemCount: ScrapItemsData.scrapItems.length,

                itemBuilder: (context, index) {
                  // Correct list
                  final item = ScrapItemsData.scrapItems[index];

                  return ScrapCard(
                    item: item,
                    onTap: () {
                      debugPrint(
                        'Selected: ${item.title}',
                      );
                    },
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                10,
                20,
                20,
              ),
              child: Center(
                child: Text(
                  'Check the latest market prices for your '
                      'recyclable items. Prices are subject to '
                      'quality and purity.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Grey,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    height: 1.4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}