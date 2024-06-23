import 'package:flutter/material.dart';

class Catagory extends StatelessWidget {
  const Catagory({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const TCatagory(
            title: 'Genre',
            showActionButton: false,
          ),
          SizedBox(
            height: 100, // Adjust the height as needed
            child: ListView.builder(
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/images/horror.png', // Replace with your image asset path
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                      SizedBox(
                        width: 60,
                      child: Text(
                        'Category ',
                        style: TextStyle(color: Colors.black),
                      ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TCatagory extends StatelessWidget {
  const TCatagory({
    super.key,
    this.textColor,
    this.showActionButton = true,
    required this.title,
    this.buttonTitle = 'View All',
    this.onPressed,
  });

  final Color? textColor;
  final bool showActionButton;
  final String title, buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.apply(color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton)
          TextButton(
            onPressed: onPressed,
            child: Text(buttonTitle),
          ),
      ],
    );
  }
}
