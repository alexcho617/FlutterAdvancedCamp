import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Divider(
              height: 10,
              thickness: 3,
            ),
            Text(
              'Flutter Advanced Camp 2021-Winter @ HGU with Software Factory',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Hiver Clone Coding Using GetX'),
            
            Row(children: [
              Text('Made With'),
              Text(
                '♥',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
              Text('By '),Text('alexcho617, '),
            Text('growbook91, '),
            Text('glowisn'),
            ])
          ],
        ),
      ),
    );
  }
}
