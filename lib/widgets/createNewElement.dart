import 'package:flutter/material.dart';
import 'package:nanoid/nanoid.dart';
import '../model/list_item.dart';

class createNewElement extends StatefulWidget {
  final Function addTermin;
  createNewElement(this.addTermin);

  @override
  State<StatefulWidget> createState() => _NewElementState();
}

class _NewElementState extends State<createNewElement> {
  final _imePredmetController = TextEditingController();
  final _datumController = TextEditingController();

  void _submitData() {
    if (_imePredmetController.text.isEmpty || _datumController.text.isEmpty) {
      return;
    }

    int check1 = '-'.allMatches(_datumController.text).length;
    int check2 = ':'.allMatches(_datumController.text).length;

    if (_datumController.text.length < 16 || check1 != 2 || check2 != 1) {
      print("Please enter date in the right format!");
      return;
    }

    final String stringDate = _datumController.text + ':00';
    DateTime date = DateTime.parse(stringDate);

    final newTermin = ListItem(
      id: nanoid(5),
      ime: _imePredmetController.text,
      datum: date,
    );
    widget.addTermin(newTermin);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: "Име на предмет"),
            controller: _imePredmetController,
            onSubmitted: (_) => _submitData(),
          ),
          TextField(
            decoration:
            InputDecoration(labelText: "Датум (пр. 2022-10-15 13:00)"),
            controller: _datumController,
            onSubmitted: (_) => _submitData(),
          ),
        ],
      ),
    );
  }
}
