import { AnimationStyle } from '../utils/Animation';


@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @StorageLink ('AnimationStyle') animationStyle: AnimationStyle = new AnimationStyle()


  build() {
    Row() {
      Column({ space: 20 }){
        if (this.animationStyle.isShow){
          List({space:10}){
            ForEach(['1','2','3','4','5'],(s: string, i: number)=>{
              ListItem(){
                Text(s)
                  .fontSize(12)
                  .fontColor(Color.Orange)
              }
              .height(30)
              .backgroundColor('#ffffffff')
              .transition(this.animationStyle.isMove(i))
              .borderRadius(20)
              .width('90%')
            })
          }
        //  .height(this.heightRow)
          .width('100%')
          .alignListItem(ListItemAlign.Center)
        }

        Text(this.message)
          .id('HelloWorld')
          .fontSize($r('app.float.page_text_font_size'))
          .fontWeight(FontWeight.Bold)
          .translate({ y: this.animationStyle.translateY })
          .scale({x: this.animationStyle.scaleSize, y: this.animationStyle.scaleSize})
            // .clickEffect(animationStyle.isClick())
          .transition(this.animationStyle.isScale())
          .padding(10)
          .fontColor(Color.White)
      }
      .justifyContent(FlexAlign.Center)
      .height(this.animationStyle.heightRow)
      .backgroundColor('#ffb5d6e3')
      .borderRadius(20)
      .onClick(() => {
        animateTo(this.animationStyle.animSpringUtils(),()=>{
          this.animationStyle.shareAnim()
        })
      })
    }
    .height('100%')
    .width('100%')
    .alignItems(VerticalAlign.Top)
    .justifyContent(this.animationStyle.flexAlign)
  }
}