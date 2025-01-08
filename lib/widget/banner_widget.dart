import 'package:flutter/material.dart';

import '../models/story.dart';

class BannerWidget extends StatefulWidget {
  final List<Story> stories;

  const BannerWidget({
    Key? key,
    required this.stories,
  }) : super(key: key);

  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: PageView(
              controller: _pageController,
              children: widget.stories
                  .map(
                    (story) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                story.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.white),
                              ),
                              Text(
                                story.description,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      ClipOval(

                        child: Image.network(
                          fit: BoxFit.fill,
                          story.urlPhoto == ""
                              ? "https://cdn.creazilla.com/silhouettes/7966870/cat-footprint-silhouette-000000-xl.png"
                              : story.urlPhoto,
                          width: 140, // Set a fixed width
                          height: 140, // Set the same fixed height
                          loadingBuilder:
                              (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child; // Image loaded
                            }
                            return const CircularProgressIndicator(); // While loading
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error); // Display on error
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  .toList(),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.stories.length, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              width: _currentPage == index ? 12.0 : 8.0,
              height: _currentPage == index ? 12.0 : 8.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index
                    ? Colors.orangeAccent
                    : Colors.orangeAccent.withOpacity(0.5),
              ),
            );
          }),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
