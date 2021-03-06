import 'package:dummy/app/pages/pitch-information.dart';
import 'package:dummy/values/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class SearchController {
  void Function() scrollTop;
}

class Search extends StatefulWidget {
  Search({this.navigatorKey, this.controller});
  final GlobalKey<NavigatorState> navigatorKey;
  final SearchController controller;

  @override
  _SearchState createState() => _SearchState(navigatorKey: navigatorKey, scrollController: controller);
}

class _SearchState extends State<Search> with AutomaticKeepAliveClientMixin<Search> {
  _SearchState({this.navigatorKey, this.scrollController});
  final scrollController;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Navigator(
      initialRoute: 'search/',
      key: navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        if (settings.name == 'search/') {
          builder = (context) => SearchPageTabController(scrollController: scrollController);
        } else if (settings.name == 'search/pitch') {
          builder = (context) => PitchInformationPage();
        } else {
          throw Exception('Invalid route name: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}

class SearchPageTabController extends StatelessWidget {
  SearchPageTabController({this.scrollController});
  final scrollController;

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
            PitchItemsCover(scrollController: scrollController),
            YandexMapCover()
          ],
        )
      ),
    );
  }
}

class YandexMapCover extends StatefulWidget {
  @override
  _YandexMapCoverState createState() => _YandexMapCoverState();
}

class _YandexMapCoverState extends State<YandexMapCover> with AutomaticKeepAliveClientMixin<YandexMapCover> {
  Position position = Position(latitude: DEFAULT_MAP_CENTER['lat'], longitude: DEFAULT_MAP_CENTER['lon']);
  YandexMapController yandexMapController;
  List<Widget> extraWidgets = [];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Stack(
      children: [
        YandexMap(
          onMapCreated: (controller) async {
            yandexMapController = controller;
            final Position gotPosition = await getLastKnownPosition();
            if (gotPosition != null) {
              final ByteData meIcon = await rootBundle.load('assets/icons/myself-position.png');
              position = gotPosition;
              controller.addPlacemark(
                  Placemark(
                      point: Point(
                          latitude: gotPosition.latitude,
                          longitude: gotPosition.longitude
                      ),
                      rawImageData: meIcon.buffer.asUint8List()
                  )
              );
            }

            // Delete this lines
            final ByteData mapItem = await rootBundle.load('assets/icons/map-item.png');
            controller.addPlacemark(
                Placemark(
                    point: Point(
                        latitude: DEFAULT_MAP_CENTER['lat'],
                        longitude: DEFAULT_MAP_CENTER['lon']
                    ),
                    rawImageData: mapItem.buffer.asUint8List(),
                    onTap: (point) async {
                      showPitchInfo();
                    }
                )
            );
            // Delete this lines
            moveToStartPosition(controller, duration: 0.0);
          }
        ),
        Positioned(
          right: 20,
          bottom: 10,
          child: Column(
            children: [
              InkWell(
                  onTap: () async {
                    moveToStartPosition(yandexMapController);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
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
                    ),
                    child: Icon(
                        Icons.gps_fixed_rounded
                    ),
                  )
              )
            ],
          ),
        ),
        ...extraWidgets
      ],
    );
  }

  moveToStartPosition(controller, {duration = 0.2}) {
    controller.move(
      zoom: DEFAULT_MAP_ZOOM,
      point: Point(
          latitude: position.latitude,
          longitude: position.longitude
      ),
      animation: MapAnimation(
        duration: duration
      )
    );
  }

  showPitchInfo() {
    setState(() {
      extraWidgets.add(
        Positioned(
          bottom: 0,
          child: Container(
            height: 160,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    if (extraWidgets.isNotEmpty) {
                      setState(() {
                        extraWidgets.removeLast();
                      });
                    }
                  },
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: 200,
                    height: 3,
                    margin: EdgeInsets.only(top: 6, bottom: 9),
                    child: SizedBox.shrink(),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5)
                    ),
                  )
                ),
                InkWell(
                  onTap: () async {
                    Navigator.pushNamed(context, 'search/pitch');
                  },
                  child: Container(
                    height: 130,
                    width: double.infinity,
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(
                            image: NetworkImage('https://i.pinimg.com/474x/98/e2/50/98e250ec387ad722631735e33246565b.jpg'),
                            width: 110,
                          ),
                          PitchItemRowLeft()
                        ]
                      )
                    ),
                  )
                )
              ],
            )
          )
        )
      );
    });
  }
}

class PitchItemsCover extends StatefulWidget {
  PitchItemsCover({this.scrollController});
  final scrollController;

  @override
  _PitchItemsCoverState createState() => _PitchItemsCoverState(scrollController);
}

class _PitchItemsCoverState extends State<PitchItemsCover> with AutomaticKeepAliveClientMixin<PitchItemsCover> {
  _PitchItemsCoverState(scrollController) {
    scrollController.scrollTop = scrollTop;
  }
  final List pitchItems = new List.generate(20, (index) => PitchItem()).toList();
  ScrollController scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      controller: scrollController,
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: pitchItems,
      )
    );
  }

  void scrollTop () {
    scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }
}

class PitchItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, 'search/pitch');
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
