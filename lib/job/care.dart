import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import '../utils/Colors.dart';
import 'CompanyCircle.dart';
import 'CustomDrawer.dart';
import 'DetailScreen.dart';
import 'Job.dart';

class CareScreen extends StatefulWidget {
  const CareScreen({Key? key}) : super(key: key);

  @override
  _CareScreenState createState() => _CareScreenState();
}

class _CareScreenState extends State<CareScreen> {
  List<Job> jobsList = [
    Job(location: '1524', dateAdded: '2225', company: '548161', url: 'tt', title: '6898'),
    Job(location: '1524', dateAdded: '2225', company: '548161', url: 'tt', title: '6898'),
    Job(location: '1524', dateAdded: '2225', company: '548161', url: 'tt', title: '6898'),
  ];

  //extract the link from the inner HTML
  getLink(String html) {
    if (html.length > 10) {
      String link = html.substring(9);
      var i = link.indexOf('" target="');
      link = link.replaceRange(i, link.length, "");
      return link;
    } else
      return "NoURL";
  }

  Future<List<String>> getData() async {
    //initialize a new list
    List<String> myList = [];

    //connect to flutter jobs web site
    http.Response response = await http.get(Uri(path: 'https://flutterjobs.info/'));

    //parse and extract the data from the web site
    dom.Document document = parser.parse(response.body);
    document.getElementsByTagName('tr').forEach((child) {
      jobsList.add(Job(
        title: child.getElementsByTagName('th').first.text,
        dateAdded: child.getElementsByTagName('th').last.text,
        location: child.getElementsByTagName('th')[2].text,
        company: child.getElementsByTagName('th')[1].text,
        url: getLink(child.getElementsByTagName("th").first.innerHtml.trim()),
      ));
    });
    // remove the first item which is the title item in the table
    jobsList.removeAt(0);

    print("data loaded");
    //just to wait until the get request completed
    return myList;
  }



  bool loading = false;

  @override
  void initState() {
    super.initState();
    getData().then((d) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.bkColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: JobsAppTitle(),
        ),
        drawer: CustomDrawer(),
        body: JobListView(list: jobsList),
        );


  }
}

class JobListView extends StatefulWidget {
  const JobListView({
    Key? key,
    required this.list,
  }) : super(key: key);
  final List<Job> list;

  @override
  JobListViewState createState() {
    return  JobListViewState();
  }
}

class JobListViewState extends State<JobListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: widget.list.isNotEmpty
            ? widget.list.map((item) {
          return Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Stack(
              children: <Widget>[
                Dismissible(
                  key: Key(item.company),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    setState(() {
                      widget.list.removeAt(widget.list.indexOf(item));
                    });
                  },
                  child: ClippedItem(item: item),
                ),
              ],
            ),
          );
        }).toList()
            : []);
  }
}

class ClippedItem extends StatefulWidget {
  const ClippedItem({
    Key ?key,
    required this.item,
  }) : super(key: key);

  final Job item;

  @override
  ClippedItemState createState() {
    return ClippedItemState();
  }
}

class ClippedItemState extends State<ClippedItem>
    with SingleTickerProviderStateMixin {
  late Animation <Offset> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    final CurvedAnimation curvedAnimation = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);
    animation = Tween<Offset>(begin: Offset(200.0, 0.0), end: Offset(0.0, 0.0))
        .animate(curvedAnimation);

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      child: Card(
        color: Color.fromRGBO(47, 65, 123, 1.0),
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Detail(widget.item),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, top: 20.0, right: 10.0, bottom: 20.0),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                          height: 50.0,
                          child: Text(
                            widget.item.title.trim(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 20.0, color: Colors.white),
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.date_range,
                      color: Colors.white70,
                    ),
                    Text(
                      widget.item.dateAdded.trim(),
                      style: TextStyle(color: Colors.white70),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Text(
                      widget.item.location.trim(),
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.location_city,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

