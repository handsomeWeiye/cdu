import 'package:cdu_helper/constants/constants.dart';
import 'package:cdu_helper/utils/shared_preference_utils.dart';

class ThemeUtils {
  static void setDark(bool isDark) {
    Themes.isDark = isDark;
    spSetBrightnessDark(isDark);
    Instances.eventBus.fire(BrightnessChangedEvent(isDark));
    Instances.navigatorKey.currentState.setState(() {});
  }

  // 获取设置的夜间模式
  static bool spGetBrightnessDark() {
    return SpUtils.sp.getBool(SpUtils.spBrightness);
  }

  // 设置选择的夜间模式
  static Future spSetBrightnessDark(bool isDark) async {
    await SpUtils.sp.setBool(SpUtils.spBrightness, isDark);
  }
}
