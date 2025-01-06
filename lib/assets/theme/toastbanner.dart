import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastHelper {
  // Simplified toast method
  static void toastBanner(
    BuildContext context,
    String message,
    ToastType type, {
    Duration? duration,
    Alignment? alignment,
  }) {
    final config = _getToastConfig(type);

    toastification.show(
      context: context,
      type: config.toastificationType,
      title: Text(message),
      autoCloseDuration: duration ?? const Duration(seconds: 3),
      alignment: alignment ?? Alignment.bottomCenter,
      animationDuration: const Duration(milliseconds: 500),
      showProgressBar: true,
      closeOnClick: true,
      style: ToastificationStyle.flatColored,
      backgroundColor: config.backgroundColor,
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  // Detailed toast method with all options
  static void showCustomToast({
    required BuildContext context,
    required String title,
    String? description,
    ToastType type = ToastType.info,
    Duration? duration,
    Alignment? alignment,
    Duration? animationDuration,
    bool? showProgressBar,
    bool? closeOnClick,
    ToastificationStyle? style,
    Color? backgroundColor,
    Widget? leading,
    Widget? trailing,
    VoidCallback? onTap,
    bool? applyBlurEffect,
  }) {
    final config = _getToastConfig(type);

    toastification.show(
      context: context,
      type: config.toastificationType,
      title: Text(title),
      description: description != null ? Text(description) : null,
      autoCloseDuration: duration ?? const Duration(seconds: 3),
      alignment: alignment ?? Alignment.bottomCenter,
      animationDuration: animationDuration ?? const Duration(milliseconds: 500),
      showProgressBar: showProgressBar ?? true,
      closeOnClick: closeOnClick ?? true,
      style: style ?? ToastificationStyle.flatColored,
      backgroundColor: backgroundColor ?? config.backgroundColor,
      applyBlurEffect: applyBlurEffect ?? false,
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}

// Toast types enum
enum ToastType {
  success,
  error,
  warning,
  info,
}

// Configuration class for toast types
class _ToastConfig {
  final ToastificationType toastificationType;
  final Color backgroundColor;

  const _ToastConfig({
    required this.toastificationType,
    required this.backgroundColor,
  });
}

// Helper method to get toast configuration
_ToastConfig _getToastConfig(ToastType type) {
  switch (type) {
    case ToastType.success:
      return _ToastConfig(
        toastificationType: ToastificationType.success,
        backgroundColor: Colors.green,
      );
    case ToastType.error:
      return _ToastConfig(
        toastificationType: ToastificationType.error,
        backgroundColor: Colors.red,
      );
    case ToastType.warning:
      return _ToastConfig(
        toastificationType: ToastificationType.warning,
        backgroundColor: Colors.orange,
      );
    case ToastType.info:
      return _ToastConfig(
        toastificationType: ToastificationType.info,
        backgroundColor: Colors.blue,
      );
  }
}
