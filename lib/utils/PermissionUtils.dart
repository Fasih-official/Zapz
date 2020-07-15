import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static PermissionUtils _permissionUtils;
  final PermissionHandler _permissionHandler = PermissionHandler();

  PermissionUtils._();

  static PermissionUtils getInstance() {
    if (_permissionUtils == null) {
      _permissionUtils = PermissionUtils._();
    }
    return _permissionUtils;
  }

  Future<bool> _requestPermission(PermissionGroup permission) async {
    var result = await _permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  Future<bool> requestLocationPermission() async {
    return _requestPermission(PermissionGroup.location);
  }

}
