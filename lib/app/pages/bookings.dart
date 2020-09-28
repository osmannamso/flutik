import 'package:dummy/app/pages/pitch-information.dart';
import 'package:flutter/material.dart';
import 'booking-information.dart';

class BookingController {
  void Function() scrollTop;
}

class Bookings extends StatelessWidget {
  Bookings({this.navigatorKey, this.controller});
  final controller;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: 'bookings/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        if (settings.name == 'bookings/') {
          builder = (context) => BookingItemCover(controller: controller);
        } else if (settings.name == 'bookings/item') {
          builder = (context) => BookingPage();
        } else if (settings.name == 'bookings/pitch') {
          builder = (context) => PitchInformationPage();
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      }
    );
  }
}

class BookingItemCover extends StatefulWidget {
  BookingItemCover({this.controller});
  final controller;

  @override
  _BookingItemCoverState createState() => _BookingItemCoverState(controller);
}

class _BookingItemCoverState extends State<BookingItemCover> with AutomaticKeepAliveClientMixin<BookingItemCover> {
  _BookingItemCoverState(BookingController controller) {
    controller.scrollTop = scrollTop;
  }
  final List bookingItems = new List.generate(20, (index) => BookingItem()).toList();
  ScrollController scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Брони'),
        backgroundColor: Colors.amber[800]
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: bookingItems,
        )
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

class BookingItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, 'bookings/item');
      },
      child: Container(
        child: BookingItemRow(),
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

class BookingItemRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BookingItemRowLeft();
  }
}

class BookingItemRowLeft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '15:00 - 18:00, 25 сен',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
            )
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'bookings/pitch');
              },
              child: Text(
                'Мини футбольное поле',
                style: TextStyle(color: Colors.amber[800]),
              ),
            )
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Text('10 000 ТГ')
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Text('Абая Байтурсынова 45'),
          )
        ],
      )
    );
  }
}
