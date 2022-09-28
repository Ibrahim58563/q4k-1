import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:q4k/test.dart';

class IT extends StatefulWidget {
  const IT({super.key});

  @override
  State<IT> createState() => _ITState();
}

class _ITState extends State<IT> {
  @override
  Widget build(BuildContext context) {
    const primaryColor = const Color(0xff253D5B);
    const lightColor = const Color(0xffF8F8FF);
    const goldenColor = const Color(0xffC9A959);
    List<String> section_name = ['PDF', 'Audio', 'jkldsf'];
    List<String> pictures_url = [
      'https://www.pngitem.com/pimgs/m/534-5347598_pdf-icon-png-transparent-png.png',
      'https://d1nhio0ox7pgb.cloudfront.net/_img/g_collection_png/standard/512x512/headphones.png',
      'lksdfj'
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'IT',
          style: TextStyle(
              color: goldenColor, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          width: 400,
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: 3,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 16),
              itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: primaryColor,
                              width: 3,
                              style: BorderStyle.solid,
                            )),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            CachedNetworkImage(
                              imageUrl: pictures_url[index],
                              height: 110,
                              width: 110,
                            ),
                            Text(
                              section_name[index],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
        ),
      ]),
    );
  }
}
