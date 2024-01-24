import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:resident_app/src/core/core_service.dart';
import 'package:stacked/stacked_annotations.dart';

@LazySingleton()
class LocationService extends CoreService {
  Location location = Location();

  Future<LatLng?>? getCurrentPosition() async {
    try {
      LocationData _locationData;
      _locationData = await location
          .getLocation()
          .timeout(const Duration(seconds: 10))
          .catchError((Object e, StackTrace s) {
        print('Failed to get current position, $e');
      });
      return LatLng(
        _locationData.latitude ?? 0.0,
        _locationData.longitude ?? 0.0,
      );
    } catch (e) {
      print('Failed to get current position, $e');
      return null;
    }
  }

  Future<String> getAddressFromCoordinates(LatLng? coordinates) async {
    List<geocoding.Placemark> placeMarks =
    await geocoding.placemarkFromCoordinates(
      coordinates?.latitude ?? 0.0,
      coordinates?.longitude ?? 0.0,
    );
    return '${placeMarks.first.street}, ${placeMarks.first.thoroughfare}, ${placeMarks.first.subLocality}, ${placeMarks.first.locality}, ${placeMarks.first.subAdministrativeArea}' ;
  }
}
