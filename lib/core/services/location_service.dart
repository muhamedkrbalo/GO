// import 'dart:developer';
// import 'package:location/location.dart' as loc;
// import 'package:permission_handler/permission_handler.dart' as permission;
// import 'package:geocoding/geocoding.dart' as geocoding;

// class LocationService {
//   final loc.Location _location = loc.Location();

//   /// Get current device location
//   Future<loc.LocationData?> getCurrentLocation() async {
//     try {
//       // Check location permissions
//       final bool hasPermission = await _checkLocationPermission();
//       if (!hasPermission) {
//         log('Location permission not granted');
//         return null;
//       }

//       // Check if location service is enabled
//       bool serviceEnabled = await _location.serviceEnabled();
//       if (!serviceEnabled) {
//         serviceEnabled = await _location.requestService();
//         if (!serviceEnabled) {
//           log('Location service not enabled');
//           return null;
//         }
//       }

//       // Get location with high accuracy
//       final loc.LocationData locationData = await _location.getLocation();
//       log('Current location: ${locationData.latitude}, ${locationData.longitude}');
//       return locationData;
//     } catch (e) {
//       log('Error getting current location: $e');
//       return null;
//     }
//   }

//   /// Check and request location permission
//   Future<bool> _checkLocationPermission() async {
//     try {
//       loc.PermissionStatus permissionStatus = await _location.hasPermission();

//       if (permissionStatus == loc.PermissionStatus.denied) {
//         permissionStatus = await _location.requestPermission();

//         if (permissionStatus == loc.PermissionStatus.denied) {
//           log('Location permission denied');
//           return false;
//         }
//       }

//       if (permissionStatus == loc.PermissionStatus.deniedForever) {
//         log('Location permission denied forever');
//         // Open app settings
//         await permission.openAppSettings();
//         return false;
//       }

//       return permissionStatus == loc.PermissionStatus.granted;
//     } catch (e) {
//       log('Error checking location permission: $e');
//       return false;
//     }
//   }

//   /// Get address from coordinates
//   Future<String?> getAddressFromCoordinates(double latitude, double longitude) async {
//     try {
//       List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(
//         latitude,
//         longitude,
//       );

//       if (placemarks.isNotEmpty) {
//         final geocoding.Placemark place = placemarks[0];
//         return '${place.street}, ${place.locality}, ${place.country}';
//       }

//       return null;
//     } catch (e) {
//       log('Error getting address from coordinates: $e');
//       return null;
//     }
//   }

//   /// Get coordinates from address
//   Future<geocoding.Location?> getCoordinatesFromAddress(String address) async {
//     try {
//       List<geocoding.Location> locations = await geocoding.locationFromAddress(address);

//       if (locations.isNotEmpty) {
//         return locations[0];
//       }

//       return null;
//     } catch (e) {
//       log('Error getting coordinates from address: $e');
//       return null;
//     }
//   }

//   /// Listen to location changes
//   Stream<loc.LocationData> get onLocationChanged => _location.onLocationChanged;

//   /// Stop location stream
//   void dispose() {
//     // Location service doesn't need explicit disposal
//     log('LocationService disposed');
//   }
// }
