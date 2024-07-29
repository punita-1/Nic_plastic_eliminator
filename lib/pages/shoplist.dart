import 'dart:async';
import 'package:flutter/material.dart';
import 'package:plastic_eliminator/pages/shopsdetailpage';

class ShopList extends StatefulWidget {
  const ShopList({super.key});

  @override
  _ShopListState createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  final ScrollController _shopScrollController = ScrollController();
  Timer? _scrollTimer;
  Timer? _inactivityTimer;
  final Duration _inactivityDuration = const Duration(seconds: 5);
  bool _scrollingForward = true; // Track the scroll direction

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
    _shopScrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_shopScrollController.offset >=
            _shopScrollController.position.maxScrollExtent &&
        !_shopScrollController.position.outOfRange) {
      // Reached the end
      setState(() {
        _scrollingForward = false;
      });
    } else if (_shopScrollController.offset <=
            _shopScrollController.position.minScrollExtent &&
        !_shopScrollController.position.outOfRange) {
      // Reached the start
      setState(() {
        _scrollingForward = true;
      });
    }
  }

  void _startAutoScroll() {
    _scrollTimer =
        Timer.periodic(const Duration(milliseconds: 2000), (Timer timer) {
      if (_shopScrollController.hasClients) {
        _shopScrollController.animateTo(
          _shopScrollController.offset + (_scrollingForward ? 50 : -50),
          duration: const Duration(milliseconds: 2000),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _stopAutoScroll() {
    _scrollTimer?.cancel();
  }

  void _resumeAutoScroll() {
    _startAutoScroll();
  }

  void _onUserInteraction() {
    _stopAutoScroll();
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(_inactivityDuration, _resumeAutoScroll);
  }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    _inactivityTimer?.cancel();
    _shopScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:
          120.0, // Increase height to accommodate both the circle and the text
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: _shopScrollController,
        itemCount: 8,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _onUserInteraction();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShopDetailPage(
                    shopName: 'Shop ${index + 1}',
                    phoneNumber: '2345678',
                    address: 'sdfghjk',
                  ),
                ),
              );
            },
            onLongPress: () {
              _onUserInteraction();
            },
            onPanUpdate: (details) {
              _onUserInteraction();
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6.0,
                          offset: Offset(0.0, 6.0),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image.asset(
                        'Assets/images/shopping-cart.png',
                        height: 50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0), // Space between circle and text
                  Text(
                    'Shop ${index + 1}', // Shop name text outside the circle
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
