import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const BottomBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 70,
      color: Color(0xFFA889FC),
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      elevation: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Sol ikon
          IconButton(
            icon: Icon(
              Icons.article_outlined,
              color: currentIndex == 0 ? Colors.white : Colors.deepPurple,
            ),
            onPressed: () => onTap(0),
          ),

          const SizedBox(width: 40), // Ortadaki oyuk için boşluk
          // Sağ ikon
          IconButton(
            icon: Icon(
              Icons.location_city_outlined,
              color: currentIndex == 2 ? Colors.white : Colors.deepPurple,
            ),
            onPressed: () => onTap(2),
          ),
        ],
      ),
    );
  }
}
