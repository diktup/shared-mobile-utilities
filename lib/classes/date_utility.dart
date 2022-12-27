// ignore_for_file: library_prefixes

import 'package:sharedmobileutilities/classes/navigation_service.dart';
import 'package:time_ago_provider/time_ago_provider.dart' as timeAgo;
import 'package:sharedmobileutilities/classes/locator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'mix_utility.dart';

BuildContext? context = navigationService!.navigatorKey.currentContext;
NavigationService? navigationService = locator<NavigationService>();

DateTime getLastDayOfTheWeek() => DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).add(Duration(days: DateTime.daysPerWeek - DateTime.now().weekday));

// FULL DATE WITHOUT HOURS

String getYMMMMEEEEd(String value, String locale) => getStringCapitalized(DateFormat.yMMMMEEEEd(locale).format(DateTime.parse(value)));

// HOUR AND MINUTE AM:PM
String getJm(String value) => DateFormat.jm().format(getDateFromString(value));

DateTime getDateFromString(String value) => DateTime.parse(value);

String getTimeAgo(String value, String locale) => getStringCapitalized(timeAgo.format(DateTime.parse(value), locale: locale));

// FULL NAME OF THE DAY

String getEEEE(String date, String locale) => getStringCapitalized(DateFormat.EEEE(locale).format(getDateFromString(date)));

// FULL NAME OF THE MONTH

String getMMM(String date, String locale) => getStringCapitalized(DateFormat.MMM(locale).format(getDateFromString(date)));

// SHORT FULL DATE WITHOUT HOURS

String getYMEd(String value, String locale) => getStringCapitalized(DateFormat.yMEd(locale).format(DateTime.parse(value)));
