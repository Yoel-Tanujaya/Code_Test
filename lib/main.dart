import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

// Example holidays
final Map<DateTime, List> _holidays = {
  DateTime(2020, 1, 1): ['New Year\'s Day'],
  DateTime(2020, 1, 6): ['Epiphany'],
  DateTime(2020, 2, 14): ['Valentine\'s Day'],
  DateTime(2020, 4, 21): ['Easter Sunday'],
  DateTime(2020, 4, 22): ['Easter Monday'],
};

void main() {
  initializeDateFormatting().then((_) => runApp(SimpleCalendar()));
}

class SimpleCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calendar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TaskHome(name: 'Yoel Tanujaya'),
    );
  }
}

class TaskHome extends StatefulWidget {
  TaskHome({Key key, this.name}) : super(key: key);
  String name;

  @override
  _TaskHomeState createState() => _TaskHomeState(this.name);
}

class _TaskHomeState extends State<TaskHome> with TickerProviderStateMixin {
  _TaskHomeState(this.name);

  String name;
  Map<DateTime, List> _events;
  List _selectedEvents;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
                height: 100,
                color: Colors.blue[800],
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                      margin: EdgeInsets.only(left: 16, top: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Icon(Icons.supervised_user_circle, color: Colors.white, size: 60,),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.bottomLeft,
                                padding: EdgeInsets.only(bottom: 4),
                                child: Text('Hello, '+name, style: GoogleFonts.raleway(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text('2 Task for Today', style: GoogleFonts.raleway(fontSize: 18, color: Colors.orange[400], fontWeight: FontWeight.bold)),
                              ),
                            ],
                          )
                        ],
                      )
                  ),
                )
            ),
            tableCalendar(),
            Padding(
              padding: EdgeInsets.all(8),
              child: Divider(
                thickness: 1,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16),
              alignment: Alignment.centerLeft,
              child: Text("Task List", style: GoogleFonts.raleway(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 8, right: 32, top: 8),
                                  child: Text("09.00", style: GoogleFonts.rubik(fontSize: 14, color: Colors.black)),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 8, right: 32, top: 33),
                                  child: Text("-", style: GoogleFonts.rubik(fontSize: 14, color: Colors.black)),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 8, right: 32, top: 32),
                                  child: Text("10.00", style: GoogleFonts.rubik(fontSize: 14, color: Colors.black)),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 8, right: 32, top: 32),
                                  child: Text("-", style: GoogleFonts.rubik(fontSize: 14, color: Colors.black)),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 8, right: 32, top: 32),
                                  child: Text("11.00", style: GoogleFonts.rubik(fontSize: 14, color: Colors.black)),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 8, right: 32, top: 40),
                                  child: Text("-", style: GoogleFonts.rubik(fontSize: 14, color: Colors.black)),
                                ),
                              ],
                            ),
                            Container(
                              width: 160,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.only(left: 6, right: 8),
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.blue[100],
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Text("Daily Stand Up", style: GoogleFonts.raleway(fontSize: 14, color: Colors.blue[900], fontWeight: FontWeight.bold)),
                                              ),
                                              Align(
                                                child: Icon(Icons.more_vert, size: 18, color: Colors.blue[900],),
                                                alignment: Alignment.centerRight,
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 12, bottom: 12),
                                            child: Text("09.00 - 09.30", style: GoogleFonts.raleway(fontSize: 14, color: Colors.blue[900])),
                                          )
                                        ],
                                      )
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 6, right: 8, top: 32),
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.orangeAccent[100],
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Text("Meeting Client A", style: GoogleFonts.raleway(fontSize: 14, color: Colors.orange[900], fontWeight: FontWeight.bold)),
                                              ),
                                              Align(
                                                child: Icon(Icons.more_vert, size: 18, color: Colors.orange[900],),
                                                alignment: Alignment.centerRight,
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 12, bottom: 80),
                                            child: Text("10.00 - 11.15", style: GoogleFonts.raleway(fontSize: 14, color: Colors.orange[900])),
                                          )
                                        ],
                                      )
                                  ),
                                ],
                              )
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.pink[50]
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.check, size: 18, color: Colors.pinkAccent[700],),
                                        Text("Complete", style: GoogleFonts.raleway(fontSize: 14, color: Colors.pinkAccent[700])),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 72),
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.grey[200]
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.check, size: 18, color: Colors.grey[500],),
                                        Text("Complete", style: GoogleFonts.raleway(fontSize: 14, color: Colors.grey[500])),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            title: Text("Tasks", style: GoogleFonts.raleway(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 40,),
            title: Container(height: 0, width: 0,),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text("Settings", style: GoogleFonts.raleway(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
        ],

      ),
    );
  }

  Widget tableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      holidays: _holidays,
      initialCalendarFormat: CalendarFormat.week,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      calendarStyle: CalendarStyle(
        markersMaxAmount: 1,
        markersColor: Colors.transparent,
        outsideDaysVisible: false,
        weekdayStyle: GoogleFonts.raleway(fontSize: 14, color: Colors.black),
        weekendStyle: GoogleFonts.raleway(fontSize: 14, color: Colors.blue[800]),
        holidayStyle: GoogleFonts.raleway(fontSize: 14, color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: GoogleFonts.raleway(fontSize: 14, color: Colors.white),
        weekdayStyle: GoogleFonts.raleway(fontSize: 14, color: Colors.white),
      ),
      headerStyle: HeaderStyle(
        titleTextBuilder: (date, locale) => DateFormat.MMMEd(locale).add_y().format(date),
        titleTextStyle: GoogleFonts.raleway(fontSize: 18, color: Colors.blue[900], fontWeight: FontWeight.bold),
        formatButtonVisible: false,
        leftChevronVisible: false,
        rightChevronVisible: false,
        headerMargin: EdgeInsets.only(top: 12, left: 16, bottom: 0)
      ),
      rowHeight: 100,
      builders: CalendarBuilders(
        dayBuilder: (context, date, _) {
          return Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(bottom: 6.0, top: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[300],
              ),
              width: 60,
              height: 120,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: Text(
                      '',
                      style: GoogleFonts.raleway(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    child: Text(
                      '${DateFormat.E("en_EN").format(date)[0]}',
                      style: GoogleFonts.raleway(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    child: Text(
                      '${date.day}',
                      style: GoogleFonts.raleway(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )
          );
        },
        selectedDayBuilder: (context, date, _) {
            return Container(
                margin: const EdgeInsets.all(4.0),
                padding: const EdgeInsets.only(bottom: 6.0, top: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blue[700],
                ),
                width: 60,
                height: 120,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.orange,
                      radius: 6,
                    ),
                    Container(
                      child: Text(
                        '${DateFormat.E("en_EN").format(date)[0]}',
                        style: GoogleFonts.raleway(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      child: Text(
                        '${date.day}',
                        style: GoogleFonts.raleway(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  ],
                )
            );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(bottom: 6.0, top: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.deepOrange[300],
              ),
              width: 60,
              height: 120,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: Text(
                      '',
                      style: GoogleFonts.raleway(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    child: Text(
                      '${DateFormat.E("en_EN").format(date)[0]}',
                      style: GoogleFonts.raleway(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    child: Text(
                      '${date.day}',
                      style: GoogleFonts.raleway(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),

                ],
              )
          );
        },
      ),

      onDaySelected: (date, events, holidays) {
        _onDaySelected(date, events, holidays);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
            ? Colors.brown[300]
            : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
}
