import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:one_thing_tracker_app/main.dart';
import 'package:provider/provider.dart';

import '../notification.dart';

class Setting extends StatelessWidget {
  Setting({super.key, this.changeOneThing});

  final textController1 = TextEditingController();
  final textController2 = TextEditingController();

  var changeOneThing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '당신의 OneThing은 무엇인가요?',
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              controller: textController1,
            ),
            Text(
              '매일 정해진 시간에 알림을 전송할까요?',
              style: TextStyle(fontSize: 18),
            ),
            TimePick(),
            SizedBox(
              height: 6,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  changeOneThing(textController1.text);
                  context.read<store1>().saveOneThing(textController1.text);
                },
                child: Text('저장'))
          ],
        )),
      ),
    );
  }
}

class TimePick extends StatefulWidget {
  const TimePick({super.key});

  @override
  State<TimePick> createState() => _TimePickState();
}

class _TimePickState extends State<TimePick> {
  var index = 0;
  @override
  Widget build(BuildContext context) {
    return [
      ElevatedButton(
          onPressed: () {
            Future<TimeOfDay?> selectedTime =
                showTimePicker(context: context, initialTime: TimeOfDay.now());
            selectedTime.then((timeOfDay) =>
                context.read<store1>().changeNotificationTime(timeOfDay));
            setState(() {
              index = 1;
            });
          },
          child: Text('시간 정하기')),
      ElevatedButton(
          onPressed: () {
            FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
                FlutterLocalNotificationsPlugin();
            flutterLocalNotificationsPlugin
                .resolvePlatformSpecificImplementation<
                    AndroidFlutterLocalNotificationsPlugin>()
                ?.requestPermission();
            showNotification(context.read<store1>().notificationTime);
          },
          child: Text('권한 허용을 눌러주세요')),
    ][index];
  }
}
