import 'package:flutter/material.dart';
import 'package:flutter_devfest/agenda/day_bloc.dart';
import 'package:flutter_devfest/agenda/day_event.dart';
import 'package:flutter_devfest/agenda/first_day_page.dart';
import 'package:flutter_devfest/agenda/seckond_day_page.dart';
import 'package:flutter_devfest/config/config_bloc.dart';
import 'package:flutter_devfest/universal/dev_scaffold.dart';

class AgendaPage extends StatefulWidget {
  static const String routeName = "/agenda";

  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final _dayBloc = DayBloc();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DayEvent>(
        stream: _dayBloc.uiEvents,
        builder: (context, snapshot) {
          final isFirstDay =
              !snapshot.hasData || snapshot.data is FirstDayEvent;
          if (isFirstDay)
            _tabController.animateTo(0);
          else
            _tabController.animateTo(1);
          return DevScaffold(
            title: isFirstDay ? "First day" : "Second day",
            body: TabBarView(
              controller: _tabController,
              children: <Widget>[FirstDayPage(), SecondDayPage()],
            ),
            fab: FloatingActionButton.extended(
              label: Text(isFirstDay ? "Show 2 day" : "Show 1 day"),
              onPressed: () => _dayBloc.events.add(ChangeDayEvent()),
            ),
          );
        });
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
