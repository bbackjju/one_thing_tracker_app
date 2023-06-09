import 'package:flutter/material.dart';
import '../components/Setting.dart';

class OneThingBefore extends StatefulWidget {
  OneThingBefore({super.key, this.changeOneThing});

  var changeOneThing;
  @override
  State<OneThingBefore> createState() => _OneThingBeforeState();
}

class _OneThingBeforeState extends State<OneThingBefore> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => Setting(changeOneThing: widget.changeOneThing,)));
            },
            child: Icon(
              Icons.add,
              size: 150,
            ),
          ),
          Text('당신의 OneThing을 설정하세요', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
        ],
      ),
    );
  }
}