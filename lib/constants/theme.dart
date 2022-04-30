import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:sands/constants/color.dart';
import 'package:sands/teacher/ttableteacher.dart';


final DarkTheme = ThemeData.dark().copyWith(
  primaryColor: blue,
  primaryColorLight: lightblue,
  primaryColorDark: darkblue,
);
final LightTheme = ThemeData.dark().copyWith(
  textTheme: const TextTheme(
      displayMedium: TextStyle(
        color: white,
        fontWeight: FontWeight.w500, 
        fontSize: 25),
      displayLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color:  white
        ),
      bodyLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color:  bluetext
      ),
      bodyMedium: TextStyle(
                color: white,
                fontSize: 19,
                fontWeight: FontWeight.normal
                ),
      bodySmall: TextStyle(
                color: darkbluetext,
                fontSize: 19,
                fontWeight: FontWeight.normal
                )
                
  ),
  disabledColor: darkdarkblue,
  highlightColor: white,
  primaryColor: blue,
  primaryColorLight: lightblue,
  primaryColorDark: darkblue,
);