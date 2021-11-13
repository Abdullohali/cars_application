import 'dart:async';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'strings.dart';
import 'details.dart';

class MyIsh extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[500],
        elevation: 0,
        title: Text(
          Cars.app_name,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: LiquidPullToRefresh(
          key: _refreshIndicatorKey, // key if you want to add
          onRefresh: _handleRefresh, // refresh callback
          child: Center(
              child: Container(
            color: Colors.blue[500],
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              // ignore: non_constant_identifier_names
              itemBuilder: (ctx, i) {
                return inside(ctx, i);
              },
              itemCount: Cars.CAR_NAMES.length,
            ),
          )),
        ),
      ),
    );
  }

  Future<void> yangila() {
    return Future.delayed(Duration(seconds: 1), () {
      setState(() {});
    });
  }

  Widget inside(BuildContext ctx, int i) {
    return Card(
      child: ListTile(
        onLongPress: () {
          AwesomeDialog(
            // btnOkIcon: Icons.done,
            // btnCancelIcon: Icons.error,
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.LEFTSLIDE,
            title: "Textni O'chirish",
            desc: "Textni o'chirishni hohlaysizmi",
            //btnCancelOnPress: () {},
            btnOkOnPress: () {},
            btnCancelOnPress: () {}, 
          )..show();
        },
        mouseCursor: MouseCursor.defer,
        leading: CircleAvatar(
          backgroundImage: AssetImage(
            "assets/images/${Cars.CAR_NAMES[i].toLowerCase()}$i.jpeg",
          ),
        ),
        title: Text(
          Cars.CAR_NAMES[i],
        ),
        subtitle: Text(Cars.CAR_YEARS[i]),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            ctx,
            MaterialPageRoute(
              builder: (ctx) => CarDetail(i),
            ),
          );
        },
      ),
    );
  }

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 3), () {
      completer.complete();
    });
    return completer.future.then<void>((_) {
      _scaffoldKey.currentState?.showSnackBar(SnackBar(
          content: const Text('Refresh complete'),
          action: SnackBarAction(
              textColor: Colors.blue,
              label: 'RETRY',
              onPressed: () {
                _refreshIndicatorKey.currentState!.show();
              })));
    });
  }
}

class _scaffoldKey {
  static var currentState;
}
