import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rounded_triangle/rounded_triangle.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Rounded triangle demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Timer _timer;
  final _animationDuration = const Duration(seconds: 1);
  late Color _fillColor;
  late Color? _borderColor;
  late bool _isBorder;
  late double _triangleSize;
  final double _triangleMaxSize = 200;
  final double _triangleMinSize = 24;
  final _textStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

  @override
  void initState() {
    super.initState();
    // Set 1s timer, update triangles
    _timer = Timer.periodic(_animationDuration, (timer) => _updateTriangles());

    // Set basic values
    _fillColor = Colors.white;
    _borderColor = Colors.black;
    _triangleSize = 48;
    _isBorder = true;
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.symmetric(vertical: 16)),
          Text('Set different sizes', style: _textStyle),
          Flexible(
              child: SizedBox(
                  height: _triangleMaxSize,
                  width: _triangleMaxSize,
                  child: RoundedTriangle(
                    fillColor: Colors.white,
                    borderColor: Colors.black,
                    iconSize: _triangleSize,
                  ))),
          Text('Set different colors', style: _textStyle),
          const Padding(padding: EdgeInsets.symmetric(vertical: 16)),
          Flexible(
              child: SizedBox(
                  height: _triangleMaxSize,
                  width: _triangleMaxSize,
                  child: RoundedTriangle(
                    fillColor: _fillColor,
                    borderColor: _borderColor,
                    iconSize: _triangleMaxSize,
                  ))),
        ],
      )),
    );
  }

  /// Set random values for fill/border colors and size
  void _updateTriangles() {
    setState(() {
      _fillColor = _getRandomColor();
      _isBorder = !_isBorder;
      _borderColor = _isBorder ? _getRandomColor() : null;
      _triangleSize = (_triangleMinSize +
              math.Random().nextInt(_triangleMaxSize.round() - _triangleMinSize.round()))
          .toDouble();
    });
  }

  /// Returns random color
  Color _getRandomColor() {
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }
}
