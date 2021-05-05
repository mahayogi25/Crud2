import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  //deklarasi variabel delay dan widged child
  final double delay;
  final Widget child;

  //penggunaan dan pemanggilan variable yang sudah dideklarasikan
  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    //membuat deklarasi final untuk menentukan trak=ck dari animasi
    final tween = MultiTrackTween([
      Track("opacity").add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      Track("translateY").add(
        Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),
        curve: Curves.easeOut)
    ]);

    //mengembalikan/return variable yang telah dideklarasikan
    return ControlledAnimation(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
          offset: Offset(0, animation["translateY"]), 
          child: child
        ),
      ),
    );
  }
}