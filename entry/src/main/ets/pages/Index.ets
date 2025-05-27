import { animationStyle,  } from '../utils/Animation';
import {
  ItemRestriction,
  PersistenceV2, SegmentButton, SegmentButtonItemTuple, SegmentButtonOptions,
  SegmentButtonTextItem } from '@kit.ArkUI';
import { saveUI } from '../utils/PersistenceV2';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State tabOptions: SegmentButtonOptions = SegmentButtonOptions.tab({
    buttons: [{ text: '蓝色' }, { text: '红色' }, {
      text: '绿色'
    }] as ItemRestriction<SegmentButtonTextItem>,
    backgroundBlurStyle: BlurStyle.BACKGROUND_THICK
  })
  @State tabSelectedIndexes: number[] = [0]

  aboutToAppear(): void {
    this.tabSelectedIndexes = saveUI.tabSelectedIndexes
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

      SegmentButton({
        options: this.tabOptions,
        selectedIndexes: $tabSelectedIndexes,
        onItemClicked: (i: number)=>{
          this.tabSelectedIndexes = [i]
          saveUI.tabSelectedIndexes = [i]
          if (i == 0) {
            saveUI.themeColor = Color.Blue
          }else if (i == 1) {
            saveUI.themeColor = Color.Red
          }
          else if (i == 2) {
            saveUI.themeColor = Color.Green
          }
        }
      })
        .position({ y:'90%' })
  }
    .height('100%')
    .width('100%')
  }
}