import { animationStyle,  } from '../utils/Animation';

@Entry
@ComponentV2
struct Index {
  @Local message: string = 'Hello World';

  build() {
    Row() {
      Column({ space: 20 }){
        if (animationStyle.isShow){
          List({space:10}){
            ForEach(['1','2','3','4','5'],(s: string, i: number)=>{
              ListItem(){
                Text(s)
                  .fontSize(12)
                  .fontColor(Color.Orange)
              }
              .height(30)
              .backgroundColor('#ffffffff')
              .transition(animationStyle.isMove(i))
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
          .fontColor(Color.Green)
      }
      .justifyContent(FlexAlign.Center)
      .height(animationStyle.heightRow)
      .backgroundColor('#ffb5d6e3')
      .borderRadius(20)
      .onClick(() => {
        animationStyle.shareAnim()
      })
      .transition(animationStyle.isScale())
      .clickEffect(animationStyle.isClick())
    }
    .height('100%')
    .width('100%')
    .alignItems(VerticalAlign.Top)
    .justifyContent(animationStyle.flexAlign)
  }
}