import 'package:flutter/widgets.dart';

extension ScrollEndNotificationExtension on ScrollEndNotification {
  /// For `NotificationListener<ScrollEndNotification>`: calls [onEnd] when the
  /// list is scrolled to its end (e.g. to load the next page). Returns true.
  bool onReachedEnd(VoidCallback onEnd) {
    if (metrics.pixels > 0 && metrics.atEdge) onEnd();
    return true;
  }
}
