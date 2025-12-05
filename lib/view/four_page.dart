import 'package:flutter/material.dart';

class FourPage extends StatefulWidget {
  const FourPage({super.key});

  @override
  State<FourPage> createState() => _FourPageState();
}

class _FourPageState extends State<FourPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadiusGeometry.circular(
                                50,
                              ),
                          child: Image.asset(
                            'images/바쁨.jpg',
                          ),
                        ),
                      ),
                      Text('Log in을 하세요'),
                      Text(''),
                      ElevatedButton(
                        onPressed: () {
                          //
                        },
                        child: Text('Log in'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
