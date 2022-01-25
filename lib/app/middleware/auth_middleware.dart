import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../services/auth_service.dart';
import '../routes/app_pages.dart';

class EnsureAuthMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    // you can do whatever you want here
    // but it's preferable to make this method fast
    User? loggedInUser = await AuthService.to.authCheck();
    if (loggedInUser == null) {
      final newRoute = Routes.LOGIN_THEN(route.location!);
      return GetNavConfig.fromRoute(newRoute);
    }else{
        return await super.redirectDelegate(route);
    }
  }
}

class EnsureNotAuthedMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    if (AuthService.to.auth.value.currentUser != null) {
      //NEVER navigate to auth screen, when user is already authed
      // return null;
      //OR redirect user to another screen
      return GetNavConfig.fromRoute(Routes.PROFILE);
    }
    return await super.redirectDelegate(route);
  }
}
