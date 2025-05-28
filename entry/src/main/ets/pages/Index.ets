import { animationStyle,  } from '../utils/Animation';
import { PersistenceV2 } from '@kit.ArkUI';
import { saveUI } from '../utils/PersistenceV2';

@Entry
@ComponentV2
struct Index {
  @Local message: string = 'Hello World';

  aboutToAppear(): void {
    console.info('PersistenceV2 Keys:',JSON.stringify(PersistenceV2.keys()))
  }

  build() {
    Stack(){
    Row() {
      Column({ space: 20 }){
        if (animationStyle.isShow){
          List({space:10}){
            ForEach(['1','2','3','4','5'],(s: string, i: number)=>{
              ListItem(){
                Text(s)
                  .fontSize(12)
                  .fontColor(saveUI.themeColor)
              }
              .height(30)
              .backgroundColor('#ffffffff')
              .transition(animationStyle.isRotate(i))
              .borderRadius(20)
              .width('90%')
            })
          }
          .width('100%')
          .alignListItem(ListItemAlign.Center)
        }

        Text(this.message)
          .id('HelloWorld')
          .fontSize($r('app.float.page_text_font_size'))
          .fontWeight(FontWeight.Bold)
          .translate({ y: animationStyle.translateY })
          .scale({x: animationStyle.scaleSize, y: animationStyle.scaleSize})
          .padding(10)
          .fontColor(Color.White)
      }
      .justifyContent(FlexAlign.Center)
      .height(animationStyle.heightRow)
      .backgroundColor(saveUI.themeColor)
      .borderRadius(20)
      .onClick(async () => {
        animationStyle.shareAnim()
      })
      .transition(animationStyle.isScale())
      .clickEffect(animationStyle.isClick())
    }
    .height('100%')
    .width('100%')
    .alignItems(VerticalAlign.Top)
    .justifyContent(animationStyle.flexAlign)

      Button('清除', { buttonStyle: ButtonStyleMode.NORMAL, role: ButtonRole.NORMAL })
        .onClick(()=>{
          saveUI.clear()
      })

      Button('蓝色/红色/绿色', { buttonStyle: ButtonStyleMode.NORMAL, role: ButtonRole.NORMAL })
        .onClick(()=>{
          if (saveUI.themeColor == Color.Blue) {
            saveUI.themeColor = Color.Red
          }else if (saveUI.themeColor == Color.Red){
            saveUI.themeColor = Color.Green
          }else if (saveUI.themeColor == Color.Green){
            saveUI.themeColor = Color.Blue
          }
        }).position({ y: '90%'})
  }
    .height('100%')
    .width('100%')
  }
}