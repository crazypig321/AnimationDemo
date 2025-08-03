import { animationStyle,  } from '../utils/Animation';
import { PersistenceV2 } from '@kit.ArkUI';
import { makeSaveUI, SaveUI } from '../utils/PersistenceV2';

@Entry
@ComponentV2
struct Index {
  @Local message: string = '点我触发动画';
  private ctx: UIContext = this.getUIContext();
  @Local saveUI: SaveUI = makeSaveUI()
  @Local switchOneColor: number = 0
  @Local switchOneAnim: number = 0

  aboutToAppear(): void {
    animationStyle.setContext(this.ctx)
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
                    .fontColor(this.saveUI.themeColor)
                }
                .height(30)
                .backgroundColor('#ffffffff')
                .transition(this.switchOneAnim == 0 ? animationStyle.isRotate(i) : animationStyle.isMove(i))
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
        .backgroundColor(this.saveUI.themeColor)
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

      Column({space: 10}){
        SwitchButton({
          buttonTextList: ['百叶窗效果', '折叠展开效果'],
          switchOne: this.switchOneAnim,
          WidthBp: 1,
          buttonNum: '2',
          onClickUse: (i: number)=>{
            this.switchOneAnim = i
          },
        })

        SwitchButton({
          buttonTextList: ['蓝色', '红色', '绿色'],
          switchOne: this.switchOneColor,
          WidthBp: 1,
          buttonNum: '3',
          onClickUse: (i: number)=>{
            this.colorChange(this.switchOneColor = i)
          },
        })
      }.position({ bottom: 25}).width('100%').padding({left: 16, right: 16})
      .transition(animationStyle.isScale())
    }
    .height('100%')
    .width('100%')
  }

  colorChange(i: number){
    if (i == 0) {
      this.saveUI.themeColor = Color.Blue
    }else if (i == 1){
      this.saveUI.themeColor = Color.Red
    }else {
      this.saveUI.themeColor = Color.Green
    }
  }
}

//横向切换按钮组件
@ComponentV2
export struct SwitchButton{
  @Require @Param buttonTextList: ResourceStr[]
  @Event onClickUse: (i: number) => void
  @Param switchOne: number = 0
  @Param WidthBp: number = 0
  @Param buttonNum: '2'|'3' = '2'

  build() {
    Row(){
      Stack(){
        Button({ type: ButtonType.Capsule })
          .width(this.buttonNum == '3' ? '33%' : '50%')
          .buttonSwitch(2, this.WidthBp < 2 ? 14 : 16, $r('app.color.switch_button'), FontWeight.Medium)

        Row(){
          Repeat<ResourceStr>(this.buttonTextList)
            .each((ri: RepeatItem<ResourceStr>) => {
              Button(ri.item, { type: ButtonType.Capsule, stateEffect: false })
                .clickEffect(animationStyle.isClick())
                .fontColor(this.switchOne == ri.index ? $r("sys.color.font") :
                $r("sys.color.icon_tertiary"))
                .buttonSwitch(2, this.WidthBp < 2 ? 14 : 16, Color.Transparent, this.switchOne == ri.index ? FontWeight.Bold : FontWeight.Medium)
                .width(this.buttonNum == '3' ? 'auto' : '49%')
                .onClick(()=> {
                  animationStyle.AnimTo(this.onClickUse(ri.index), 0)
                })
            }).key((item: string | Resource) => item.toString())
        }.width('100%').borderRadius(100).justifyContent(FlexAlign.SpaceAround)
      }
      .alignContent(this.buttonNum == '3' ?
        (this.switchOne == 0 ? Alignment.Start : this.switchOne == 1 ? Alignment.Center : Alignment.End) :
        (this.switchOne == 0 ? Alignment.Start : Alignment.End))
      //.animation(animationStyle.animNormalUtils(0))
    }
    .width('100%')
    .height(40)
    .borderRadius(100)
    .backgroundColor($r("app.color.settings_switch_button_floor"))
  }
}

//设置#顶部切换按钮样式
@Extend(Button)
function buttonSwitch(m: number, fontSize: Length, bkColor: ResourceColor, fontWeight: FontWeight){
  .margin(m)
  .fontSize(fontSize)
  .fontWeight(fontWeight)
  .backgroundColor(bkColor)
  .clickEffect(animationStyle.isClick())
}
