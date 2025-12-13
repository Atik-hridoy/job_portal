import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:ansicolor/ansicolor.dart'; 

class AppLogger {
  static final _green = AnsiPen()..green();
  static final _red = AnsiPen()..red();
  static final _blue = AnsiPen()..blue();
  static final _yellow = AnsiPen()..yellow();
  static final _magenta = AnsiPen()..magenta();

  //==== Log Request ====
  static void request(String method, String url,
      {Map<String, String>? headers, dynamic body}) {
    debugPrint(_blue('────────────── API REQUEST ──────────────'));
    debugPrint(_blue('METHOD : $method'));
    debugPrint(_blue('URL    : $url'));
    if (headers != null) debugPrint(_yellow('HEADERS: ${jsonEncode(headers)}'));
    if (body != null) debugPrint(_green('BODY   : ${jsonEncode(body)}'));
    debugPrint(_blue('──────────────────────────────────────────'));
  }

  //==== Log Response ====
  static void response(int statusCode, String url, dynamic data) {
    final color = (statusCode >= 200 && statusCode < 300) ? _green : _red;
    debugPrint(color('───────────── API RESPONSE ─────────────'));
    debugPrint(color('URL    : $url'));
    debugPrint(color('STATUS : $statusCode'));
    debugPrint(color('BODY   : ${const JsonEncoder.withIndent('  ').convert(data)}'));
    debugPrint(color('──────────────────────────────────────────'));
  }

  //==== Log Error ====
  static void error(String url, dynamic error, {StackTrace? stackTrace}) {
    debugPrint(_red('────────────── API ERROR ───────────────'));
    debugPrint(_red('URL   : $url'));
    debugPrint(_red('ERROR : $error'));
    if (stackTrace != null) debugPrint(_magenta('STACK : $stackTrace'));
    debugPrint(_red('─────────────────────────────────────────'));
  }
}