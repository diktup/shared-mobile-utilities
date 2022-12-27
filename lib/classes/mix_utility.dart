import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sharedmobileutilities/classes/enums.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// BOOL FUNCTIONS

bool isValidEmail(String string) => RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(string);

bool isColor(String string) => (string == null) ? false : int.tryParse("FF${string.replaceAll("#", '')}", radix: 16) != null;

bool isAppGranted(String app, List<String> appList) => appList.where((element) => element == app).isNotEmpty;

bool isDouble(String string) => (string == null) ? false : double.tryParse(string) != null;

bool isInt(String string) => (string == null) ? false : int.tryParse(string) != null;

// STRING FUNCTIONS

String getStringThemeData(ThemeData themeData, ThemeData darkTheme) => themeData == darkTheme ? DeviceTheme.DARK.name : DeviceTheme.LIGHT.name;

String getHexFromColor(Color color) => "#${color.value.toRadixString(16).substring(2, color.value.toRadixString(16).length)}".toUpperCase();

String getFormattedPrice(double value) => NumberFormat.currency(locale: "fr_tn", name: "DT", decimalDigits: 3).format(value);

String getStringCapitalized(String string) {
  if (string.isEmpty) return '';
  if (string.length == 1) return string.toUpperCase();
  return "${string.substring(0, 1).toUpperCase()}${string.substring(1, string.length).toLowerCase()}";
}

String getFormattedDouble(double value, {int maximumFractionDigits}) {
  NumberFormat numberFormat = NumberFormat();
  numberFormat.minimumFractionDigits = 0;
  numberFormat.maximumFractionDigits = maximumFractionDigits ?? 2;
  return numberFormat.format(value);
}

// INT FUNCTIONS

int getIntFromString(String string) => isInt(string) ? int.parse(string) : 0;

// COLOR FUNCTIONS

Color getColorFromHex(String string) => Color((int.parse("FF${string.replaceAll("#", '')}", radix: 16)));

// DOUBLE FUNCTIONS

double getDoubleFromString(String string) => isDouble(string) ? double.parse(string) : 0.0;

// THEME DATA FUNCTIONS

ThemeData getThemeDataFromString(String string, ThemeData darkTheme, ThemeData lightTheme) => (string.toString().toUpperCase() == DeviceTheme.DARK.name) ? darkTheme : lightTheme;

// LOCALE FUNCTIONS

Locale getLocaleFromString(String string) => Locale(string.split("_").first.toLowerCase(), string.split("_").last.toUpperCase());

// LATLNG FUNCTIONS

LatLng getLatLngFromString(String string) => string == null ? const LatLng(0.0, 0.0) : LatLng(double.parse(string.split("_").first), double.parse(string.split("_").last));

// VOIDS

void openGoogleMapsWithLatLng(LatLng latLng) => openUrl("https://www.google.com/maps/search/?api=1&query=${latLng.latitude},${latLng.longitude}");

void exitTheFullScreen() => SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);

void openTheKeyboard(BuildContext context, FocusNode focusNode) => FocusScope.of(context).requestFocus(focusNode);

void openUrl(String string) => launchUrl(Uri.parse(string), mode: LaunchMode.inAppWebView);

void setTheFullScreen() => SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

void closeTheKeyboard(BuildContext context) => FocusScope.of(context).unfocus();

void showToast(BuildContext context, String string, Color color, BorderRadiusGeometry borderRadius, TextStyle style) {
  FToast fToast = FToast();
  fToast.init(context);
  fToast.showToast(
    toastDuration: const Duration(seconds: 3),
    gravity: ToastGravity.TOP,
    child: Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: color,
      ),
      child: Text(
        string,
        textAlign: TextAlign.center,
        style: style,
      ),
    ),
  );
}
