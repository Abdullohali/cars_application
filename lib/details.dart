import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:palette_generator/palette_generator.dart';
import 'strings.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

// ignore: must_be_immutable
class CarDetail extends StatefulWidget {
  int kelganIndex;
  CarDetail(this.kelganIndex);

  @override
  _CarDetailState createState() => _CarDetailState();
}

class _CarDetailState extends State<CarDetail> {
  @override
  void initState() {
    super.initState();
    _updatePaletteGenerator();
  }

  PaletteGenerator? paletteGenerator;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidPullToRefresh(
        key: _refreshIndicatorKey, // key if you want to add
        onRefresh: _handleRefresh, // refresh callback
        child: Center(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: paletteGenerator!.darkVibrantColor != null
                    ? paletteGenerator!.darkVibrantColor!.color
                    : Colors.white,
                stretch: true,
                title: Text(Cars.CAR_NAMES[widget.kelganIndex]),
                expandedHeight: 260.0,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    "assets/images/${Cars.CAR_NAMES[widget.kelganIndex].toLowerCase()}_katta${widget.kelganIndex}.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Container(
                  margin: EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text(
                        Cars.CAR_YEARS[widget.kelganIndex],
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13.0,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        Cars.CAR_INFO[widget.kelganIndex],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                      )
                    ],
                  ),
                )
              ]))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updatePaletteGenerator() async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      AssetImage(
        "assets/images/${Cars.CAR_NAMES[widget.kelganIndex].toLowerCase()}_katta${widget.kelganIndex}.jpeg",
      ),
      size: Size(400.0, 260.0),
    );
    setState(() {});
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 1; // number that changes when refreshed
  Stream<int> counterStream =
      Stream<int>.periodic(Duration(seconds: 1), (x) => refreshNum);

  ScrollController? _scrollController;

  static final List<String> _items = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N'
  ];
  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 1), () {
      completer.complete();
    });
    setState(() {
      var refreshNum = new Random().nextInt(100);
    });
    return completer.future.then<void>((_) {
      // ignore: deprecated_member_use
      _scaffoldKey.currentState?.showSnackBar(SnackBar(
          content: const Text('Refresh complete'),
          action: SnackBarAction(
              label: 'RETRY',
              onPressed: () {
                _refreshIndicatorKey.currentState!.show();
              })));
    });
  }
}
