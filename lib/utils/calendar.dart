import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'app_styles.dart';

class calendar_today extends StatefulWidget {
  final int isMode;
  const calendar_today({super.key, required this.isMode});

  @override
  State<calendar_today> createState() => _calendar_todayState();
}

class _calendar_todayState extends State<calendar_today> {

   DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusdDay ) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    var isMode = widget.isMode;
    return TableCalendar(
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
         color: AppTheme.getModeColor(AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
      ),
      ),
      calendarStyle: CalendarStyle(
        defaultTextStyle: TextStyle(
          color: AppTheme.getModeColor(AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
        ),
        disabledTextStyle: TextStyle(
          color: AppTheme.getModeColor(AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
        )
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          color: AppTheme.getModeColor(AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
        ),
            weekendStyle: TextStyle(
          color: AppTheme.getModeColor(AppTheme.lightBlue1, AppTheme.lightWhite, isMode),
      )
      ),

      availableGestures: AvailableGestures.all,
      selectedDayPredicate: (day) => isSameDay(day, today),
      firstDay: DateTime.utc(2021, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: DateTime.now(),
      onDaySelected: _onDaySelected,
      pageAnimationDuration: Durations.extralong4,
    );
  }
}
