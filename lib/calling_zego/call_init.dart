  import 'package:cehpoint_marketplace_seller/utility.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class CallInitPage {
  Future onUserLogin(String userID, String userName) async {
    try {
      await ZegoUIKitPrebuiltCallInvitationService().init(
        appID: Utils.appId,
        appSign: Utils.appSign,
        userID: userID,
        userName: userName,
        plugins: [ZegoUIKitSignalingPlugin()],
      );
    // ignore: empty_catches
    } catch (e) {}
  }
}
