import 'package:flutter/material.dart';
import 'package:flutter_devfest/agenda/day_bloc.dart';
import 'package:flutter_devfest/agenda/day_event.dart';
import 'package:flutter_devfest/agenda/first_day_page.dart';
import 'package:flutter_devfest/agenda/seckond_day_page.dart';
import 'package:flutter_devfest/config/config_bloc.dart';

class AgendaPage extends StatelessWidget {
  static const String routeName = "/agenda";

  @override
  Widget build(BuildContext context) {
    final dayBloc = DayBloc();
    return StreamBuilder<DayEvent>(
      stream: dayBloc.uiEvents,
      builder: (_, daySnap) {
        if (!daySnap.hasData || daySnap.data.runtimeType == FirstDayEvent)
          return FromNowhereAnimation(child: FirstDayPage());
        else
          return FromNowhereAnimation(child: SecondDayPage());
      },
    );
  }
}

class FromNowhereAnimation extends StatefulWidget {
  FromNowhereAnimation({this.child});

  final Widget child;

  @override
  _FromNowhereAnimationState createState() => _FromNowhereAnimationState();
}

class _FromNowhereAnimationState extends State<FromNowhereAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _animation = Tween<double>(begin: 1, end: 0).animate(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _controller.reset();
    _controller.forward();
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          color: ConfigBloc().darkModeOn ? Colors.black : Colors.white,
          child: Transform.translate(
//            scale: _animation.value,
            offset:
                Offset(MediaQuery.of(context).size.width * _animation.value, 0),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
