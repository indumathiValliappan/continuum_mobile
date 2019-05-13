import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';

class ProgressionsList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Progressions'),
      ),
        body: CarouselSlider(
          height: 900.0,
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
          items: [1,2,3,4,5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                    child: ListView(
                      padding: const EdgeInsets.all(8.0),
                      children: <Widget>[
                        Container(
                          height: 200.0,
                          color: Colors.white,
                          child: const Center(child: Text('Entry A')),
                        ),
                        Container(
                          height: 200.0,
                          color: Colors.white,
                          child: const Center(child: Text('Entry B')),
                        ),
                        Container(
                          height: 200.0,
                          color: Colors.white,
                          child: const Center(child: Text('Entry C')),
                        ),
                        Container(
                          height: 200.0,
                          color: Colors.white,
                          child: const Center(child: Text('Entry D')),
                        ),
                        Container(
                          height: 200.0,
                          color: Colors.white,
                          child: const Center(child: Text('Entry E')),
                        ),
                        Container(
                          height: 200.0,
                          color: Colors.white,
                          child: const Center(child: Text('Entry F')),
                        ),
                        Container(
                          height: 200.0,
                          color: Colors.white,
                          child: const Center(child: Text('Entry G')),
                        ),
                        Container(
                          height: 200.0,
                          color: Colors.white,
                          child: const Center(child: Text('Entry H')),
                        ),
                        Container(
                          height: 200.0,
                          color: Colors.white,
                          child: const Center(child: Text('Entry I')),
                        )
                      ],
                    )
                  // Text('text $i \n $testData', style: TextStyle(fontSize: 16.0), maxLines: 60)
                );
              },
            );
          }).toList(),
        ),
      );
  }
}
