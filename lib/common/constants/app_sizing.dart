import 'package:flutter/material.dart';

/// A class that provides static methods to create [SizedBox] widgets with predefined heights and widths.
class AppSizing {
  /// Creates a vertical [SizedBox] with the given [height].
  static SizedBox vS(double height) {
    return SizedBox(height: height);
  }

  /// Creates a vertical [SizedBox] with a height of 4.
  static SizedBox vS4() {
    return const SizedBox(height: 4);
  }

  /// Creates a vertical [SizedBox] with a height of 6.
  static SizedBox vS6() {
    return const SizedBox(height: 6);
  }

  /// Creates a vertical [SizedBox] with a height of 8.
  static SizedBox vS8() {
    return const SizedBox(height: 8);
  }

  /// Creates a vertical [SizedBox] with a height of 12.
  static SizedBox vS12() {
    return const SizedBox(height: 12);
  }

  /// Creates a vertical [SizedBox] with a height of 16.
  static SizedBox vS16() {
    return const SizedBox(height: 16);
  }

  /// Creates a horizontal [SizedBox] with the given [width].
  static SizedBox hS(double width) {
    return SizedBox(width: width);
  }

  /// Creates a horizontal [SizedBox] with a width of 4.
  static SizedBox hS4() {
    return const SizedBox(width: 4);
  }

  /// Creates a horizontal [SizedBox] with a width of 6.
  static SizedBox hS6() {
    return const SizedBox(width: 6);
  }

  /// Creates a horizontal [SizedBox] with a width of 8.
  static SizedBox hS8() {
    return const SizedBox(width: 8);
  }

  /// Creates a horizontal [SizedBox] with a width of 12.
  static SizedBox hS12() {
    return const SizedBox(width: 12);
  }

  /// Creates a horizontal [SizedBox] with a width of 16.
  static SizedBox hS16() {
    return const SizedBox(width: 16);
  }
}