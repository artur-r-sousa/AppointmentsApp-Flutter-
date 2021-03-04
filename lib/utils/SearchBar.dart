import 'package:appointment/db/Controller.dart';
import 'package:flutter/material.dart';
import 'package:appointment/models/entities/Pacient.dart';

class SearchBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> {

  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(_showCardInfo);
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  _showCardInfo() {
    return Card(
        child: Text('hello there')
    );
  }

  String holder = "";
  List holderList = new List();


  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          TextField(
            controller: myController,
            onChanged: (text) async {
              List<Pacient> p = await DBController().getPacientsByPNLike(text);
              if (text == "" || p.length == 0) {
                holder = text;
                holderList = new List();
              } else {
                holderList = []..addAll(p);
                holder = p[0].name;
              }
              setState(() {

              });
            },
          ),
          SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: holderList.length,
                  itemBuilder: (context, int position) {
                    return ListTile(
                        title: Text(holderList[0] == null || holderList[0] == "" ? "Search patient name above" : holderList[position].toString())
                    );
                  }
                )
              ],
            ),
          )
      ]
    );
  }
}