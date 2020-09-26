import 'package:dummy/app/pages/pitch-information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/search',
      routes: {
        '/search': (context) => SearchPageTabController(),
        '/search/pitch': (context) => PitchInformationPage()
      }
    );
  }
}

class SearchPageTabController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber[800],
            bottom: TabBar(
              indicatorColor: Colors.amber[100],
              tabs: [
                Tab(
                    text: 'Списком'
                ),
                Tab(
                    text: 'На карте'
                ),
              ],
            ),
            title: Text('Поиск'),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              PitchItemsCover(),
              Icon(Icons.map)
            ],
          )
      ),
    );
  }

}

class PitchItemsCover extends StatefulWidget {
  @override
  _PitchItemsCoverState createState() => _PitchItemsCoverState();
}

class _PitchItemsCoverState extends State<PitchItemsCover> with AutomaticKeepAliveClientMixin<PitchItemsCover> {
  final List pitchItems = new List.generate(20, (index) => PitchItem()).toList();

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: pitchItems,
        )
    );
  }
}

class PitchItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/search/pitch');
      },
      child: Container(
          child: PitchItemRow(),
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.symmetric(vertical: 5),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 2), // changes position of shadow
                )
              ]
          )
      ),
    );
  }
}

class PitchItemRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: NetworkImage('https://i.pinimg.com/474x/98/e2/50/98e250ec387ad722631735e33246565b.jpg'),
            width: 110,
          ),
          PitchItemRowLeft()
        ]
    );
  }
}

class PitchItemRowLeft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                '10 000 ТГ',
                style: TextStyle(fontWeight: FontWeight.bold)
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                'Мини футбольное поле',
                style: TextStyle(color: Colors.amber[800]),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text('Абая Байтурсынова 45'),
            ),
            Container(
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Text('(36)')
                  ],
                )
            )
          ],
        )
    );
  }

}
