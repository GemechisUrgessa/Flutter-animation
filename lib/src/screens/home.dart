import 'package:flutter/material.dart';
import '../widget/cat.dart';
import 'dart:math';

class Home extends StatefulWidget {

  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  late Animation<double> catAnimation;
  late Animation<double> boxAnimation;
  late AnimationController boxController;
  late AnimationController catController;

  @override
  void initState() {
    super.initState();

    boxController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
    );

    boxAnimation = Tween(begin: pi*0.6, end: pi*0.65)
    .animate(
      CurvedAnimation(parent: boxController, curve: Curves.easeInOut),
      );

    boxAnimation.addStatusListener((status) { 
      if (status == AnimationStatus.completed) {
        boxController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });
    boxController.forward();

    catController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
    );

    catAnimation = Tween(begin: -25.0, end: -80.0)
    .animate(
      CurvedAnimation(parent: catController, curve: Curves.easeIn),
      );
  }
  onTap() {
    boxController.stop();
    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
      boxController.forward();
    }else if (catController.status == AnimationStatus.dismissed) {
      catController.forward();
      boxController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Animation'),),
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            overflow: Overflow.visible,
            children: [
              rightWing(),
              buildAnimation(),
              buildBox(),
              leftWing(),
            ],
        ),),
        onTap: onTap,
      ),
      
    );
  }

  Widget buildAnimation(){
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child){
        return Positioned(
          child: child!,
          top: catAnimation.value,
          left: 0.0,
          right: 0.0,
          );
      },
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(
      width: 200.0,
      height: 200.0,
      color: Colors.brown,
    );
  }

  Widget leftWing() {
    return Positioned(
      left: 6.70,
      top: 2.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10,
          width: 115,
          color: Colors.brown,
        ),
        builder: (context, child){
          return Transform.rotate(
            alignment: Alignment.topLeft,
            angle: boxAnimation.value,
            child: child,
          );
        },
      ),
    );
  }

  Widget rightWing() {
    return Positioned(
      right: 6.70,
      top: 2.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10,
          width: 115,
          color: Colors.brown,
        ),
        builder: (context, child){
          return Transform.rotate(
            alignment: Alignment.topRight,
            angle: -boxAnimation.value,
            child: child,
          );
        },
      ),
    );
  }
}