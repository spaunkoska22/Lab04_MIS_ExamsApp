import 'package:flutter/material.dart';
import '../model/list_item.dart';
import '../screens/login_screen.dart';
import '../screens/calendar_screen.dart';
import '../widgets/createNewElement.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../services/notifications_service.dart';
import '../services/simple_map.dart';

class MainScreen extends StatefulWidget {
  static const String idScreen = "mainScreen";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final LocalNotificationsService service;

  @override
  void initState(){
    service = LocalNotificationsService();
    service.initialize();
    super.initState();
  }
  final List<ListItem> _ispiti = [
    ListItem(
      id: "1",
      ime: "Мобилни информациски системи",
      datum: DateTime.parse("2023-01-21 15:00:00"),
    ),
    ListItem(
      id: "2",
      ime: "Програмирање видео игри",
      datum: DateTime.parse("2023-01-24 11:00:00"),
    ),
    ListItem(
      id: "3",
      ime: "Анализа и дизајн на ИС",
      datum: DateTime.parse("2023-01-26 08:00:00"),
    )
  ];

  void _showModal(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: createNewElement(_addNewTerm),
        );
      },
    );
  }

  void _addNewTerm(ListItem termin) {
    setState(() {
      _ispiti.add(termin);
    });
  }

  void _deleteTerm(String id) {
    setState(() {
      _ispiti.removeWhere((termin) => termin.id == id);
    });
  }

  String _modifyDate(DateTime date) {
    String dateString = DateFormat("yyyy-MM-dd HH:mm:ss").format(date);
    List<String> dateParts = dateString.split(" ");
    String modifiedTime = dateParts[1].substring(0, 5);
    return dateParts[0] + ' во ' + modifiedTime + 'h';
  }

  Future _signOut() async {
    try {
      await FirebaseAuth.instance.signOut().then((value) {
        print("User signed out");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LogInScreen()));
      });
    } on FirebaseAuthException catch (e) {
      print("ERROR HERE");
      print(e.message);
    }
  }

  PreferredSizeWidget _createAppBar(BuildContext context) {
    //final user = FirebaseAuth.instance.currentUser?.email;
    return AppBar(
      title: Text("Мои испити"),
      actions: [
        IconButton(
            icon: Icon(Icons.add_box), onPressed: () => _showModal(context)),
        ElevatedButton(
          child: Text("Одјави се"),
          onPressed: _signOut,
        )
      ],
    );
  }

  Widget _createBody(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: _ispiti.isEmpty
                  ? Text("Нема повеќе испити")
                  : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _ispiti.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 2,
                    margin:
                    EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    child: ListTile(
                      tileColor: Colors.teal[50],
                      title: Text(
                        _ispiti[index].ime,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        _modifyDate(_ispiti[index].datum),
                        style: TextStyle(color: Colors.grey),
                      ),
                      trailing: IconButton(
                          onPressed: () => _deleteTerm(_ispiti[index].id),
                          icon: Icon(Icons.delete_outline)),
                    ),
                  );
                },
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalendarScreen(_ispiti),
                  ),
                );
              },
              tooltip: 'Calendar',
              child: const Icon(Icons.calendar_month),
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SimpleMap(),
                  ),
                );
              },
              tooltip: 'Map',
              child: const Icon(Icons.map),
            ),
            ElevatedButton(
              onPressed: () async{
                await service.showNotification(id: 0, title: 'Колоквиум/испит', body: 'Провери го твојот календар за полагање испити!');
              },
              child: Text("Прикажи нотификација", style: TextStyle(fontSize: 20)),
            ),
            ElevatedButton(
              onPressed: () async{
                await service.showScheduledNotification(id: 0, title: 'Колоквиум/испит', body: 'Провери го твојот календар за полагање испити!', seconds: 3);
              },
              child: Text("Намести нотификација", style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppBar(context),
      body: _createBody(context),
    );
  }
}
