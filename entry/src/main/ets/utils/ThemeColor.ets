import { CustomTheme, CustomColors, ThemeControl } from '@kit.ArkUI';

// 自定义主题颜色
@ObservedV2
class BlueColors implements CustomColors {
 @Trace brand = Color.Blue; //品牌色
}

class PageCustomTheme implements CustomTheme {
  colors?: CustomColors;

  constructor(colors: CustomColors) {
    this.colors = colors;
  }
}
// 创建实例
export const themeColor =  new PageCustomTheme(new BlueColors())
// 在页面build之前执行ThemeControl.setDefaultTheme，设置App默认样式风格为BlueColorsTheme。
ThemeControl.setDefaultTheme(themeColor);
