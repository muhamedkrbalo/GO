// import 'package:flutter/material.dart';
// import 'dart:developer';
// import '../../../../core/enum/cubit_state/cubit_status.dart';

// class CustomNotificationListener extends StatefulWidget {
//   final Widget child;
//   final VoidCallback onLoadMore;
//   final bool isLastPage;
//   final CubitStatus paginationStatus;

//   const CustomNotificationListener({
//     super.key,
//     required this.child,
//     required this.onLoadMore,
//     required this.isLastPage,
//     required this.paginationStatus,
//   });

//   @override
//   State<CustomNotificationListener> createState() => _CustomNotificationListenerState();
// }

// class _CustomNotificationListenerState extends State<CustomNotificationListener> {
//   DateTime? _lastTriggerTime;

//   @override
//   Widget build(BuildContext context) {
//     return NotificationListener<ScrollNotification>(
//       onNotification: (notification) {
//         // Only handle scroll updates from primary scrollable
//         if (notification is ScrollUpdateNotification && notification.depth == 0) {
//           final scrollPosition = notification.metrics.pixels;
//           final maxScrollExtent = notification.metrics.maxScrollExtent;
//           final remainingDistance = maxScrollExtent - scrollPosition;

//           final now = DateTime.now();

//           // Debounce: don't trigger if we triggered recently
//           if (_lastTriggerTime != null && now.difference(_lastTriggerTime!).inMilliseconds < 1000) {
//             return false;
//           }

//           // Trigger when user is 150 pixels from bottom
//           final shouldLoadMore =
//               remainingDistance <= 150 &&
//               !widget.isLastPage &&
//               widget.paginationStatus != CubitStatus.loading;

//           if (shouldLoadMore) {
//             _lastTriggerTime = now;
//             log('[Pagination] Triggering onLoadMore - remaining: $remainingDistance');
//             widget.onLoadMore();
//           }
//         }
//         return false; // Allow other listeners
//       },
//       child: widget.child,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_hr_erb/core/enum/cubit_state/cubit_status.dart';

class CustomNotificationListener extends StatelessWidget {
  final Widget child;
  final VoidCallback onLoadMore;
  final bool isLastPage;
  final CubitStatus paginationStatus;

  const CustomNotificationListener({
    super.key,
    required this.child,
    required this.onLoadMore,
    required this.isLastPage,
    required this.paginationStatus,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final scrollPosition = notification.metrics.pixels;
        final maxScrollExtent = notification.metrics.maxScrollExtent;
        final scrollThreshold = maxScrollExtent * 0.7;

        if (scrollPosition >= scrollThreshold &&
            !isLastPage &&
            paginationStatus != CubitStatus.loading) {
          onLoadMore();
        }

        return false;
      },
      child: child,
    );
  }
}
