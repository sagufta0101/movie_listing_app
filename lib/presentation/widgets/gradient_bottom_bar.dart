import 'package:flutter/material.dart';

class GradientBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const GradientBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);
  Widget _buildGradientIcon(IconData iconData, int index) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return currentIndex == index
            ? LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.red, Colors.white],
              ).createShader(bounds)
            : LinearGradient(
                colors: [Colors.white54, Colors.white54],
              ).createShader(bounds);
      },
      child: Icon(
        iconData,
        size: 30,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // backgroundColor: Colors.black,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: _buildGradientIcon(Icons.home_filled, 0),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 30,
                width: 30,
              ),
              if (currentIndex == 1)
                CircleAvatar(
                  radius: 10,
                ),
              _buildGradientIcon(Icons.play_circle_rounded, 1),
            ],
          ),
          label: 'Play',
        ),
        BottomNavigationBarItem(
          icon: _buildGradientIcon(Icons.person_2, 2),
          label: 'Profile',
        ),
      ],
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white60,
    );
  }
}
