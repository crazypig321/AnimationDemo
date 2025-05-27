
/*
* 属性动画参数使用方法：.animation(animationStyle.animationStyle.animationUtils())
* 属性变化使用方法：animationStyle.animationStyle.attributeAnim(i为属性变化数值)
* 显示动画参数使用方法：animationStyle.animationUtils()
* 转场动画使用方法：.transition(animationStyle.animationStyle.isScale())
* 点击动效使用方法：.clickEffect(animationStyle.animationStyle.isClick())
 */

import {  curves, PersistenceV2 } from "@kit.ArkUI"

//通用动画参数
let animationUtils: AnimateParam
let transitionEffect: TransitionEffect
let clickEffect: ClickEffect

@ObservedV2
export class AnimationStyle{
  @Trace i?: number | string | FlexAlign | undefined
  @Trace translateY: number = 0
  @Trace scaleSize: number = 1
  @Trace heightRow: number | string = ''
  @Trace flexAlign: FlexAlign = FlexAlign.Start
  @Trace isShow: boolean = false

  /*通用动画参数*/
  //弹性动画参数
  public animSpringUtils(){
    animationUtils = {
      //动画持续时长
      duration: 1000,
      //弹簧动画参数
      curve: curves.springMotion(0.5, 0.7, 0.6),
      //动画播放次数
      iterations: 1,
      //动画播放形式
      playMode: PlayMode.Normal,
      //动画延迟
      delay:50
    }
    return animationUtils
  }

  //普通递增动画参数
  public animNormalAddUtils(d: number){
    animationUtils = {
      duration: 500,
      curve: Curve.EaseOut,
      iterations: 1,
      playMode: PlayMode.Normal,
      delay:d*50 + 50
    }
    return animationUtils
  }

  //普通递减动画参数
  public animNormalMinusUtils(d: number){
    animationUtils = {
      duration: 300,
      curve: Curve.EaseOut,
      iterations: 1,
      playMode: PlayMode.Normal,
      delay:100 - d*30
    }
    return animationUtils
  }

  /* 属性动画 */
  public attributeAnim(i: number | string | FlexAlign | undefined){
    animateTo(this.animSpringUtils(),()=> {
      this.i = i
    })
  }

  ///共享元素动画参数
  public shareAnim(){
    animateTo(this.animSpringUtils(),()=>{
      if (this.translateY == 0 && this.scaleSize == 1 && this.flexAlign == FlexAlign.Start && this.heightRow == '') {
        this.translateY = 0;
        this.scaleSize = 1.5;
        this.flexAlign = FlexAlign.Center;
        this.heightRow = '50%';
        this.isShow = true;
      }else {
        this.translateY = 0;
        this.scaleSize = 1;
        this.flexAlign = FlexAlign.Start;
        this.heightRow = '';
        this.isShow = false
      }
    })
  }

  /* 转场动画 */
  // 缩放转场动画
  public isScale(){
    transitionEffect=
        TransitionEffect.OPACITY
          .combine(TransitionEffect.scale({x: 0, y: 0}))
          .animation(this.animSpringUtils())

    return transitionEffect
  }

  //移动转场动画
  public isMove(d: number){
    transitionEffect=
      TransitionEffect.asymmetric(
      TransitionEffect.OPACITY
        .combine(TransitionEffect.move(TransitionEdge.TOP))
        .animation(this.animNormalAddUtils(d)),

        TransitionEffect.OPACITY
          .combine(TransitionEffect.move(TransitionEdge.TOP))
          .combine(TransitionEffect.scale({x: 0, y: 1, centerX:0, centerY: 0}))
          .animation(this.animNormalMinusUtils(d)),
      )
    return transitionEffect
  }

  public isRotate(d: number){
    transitionEffect=
      TransitionEffect.asymmetric(
        TransitionEffect.OPACITY
          .combine(TransitionEffect.rotate({ x: 1, angle: 270, perspective: 20 }))
          .combine(TransitionEffect.scale({ x:0.7, y:0.7 }))
          .animation(this.animNormalAddUtils(d)),

        TransitionEffect.OPACITY
          .combine(TransitionEffect.rotate({ x: 1, angle: 270, perspective: 50 }))
          .combine(TransitionEffect.scale({ x: 0, y: 0, centerX:0, centerY: 0 }))
          .animation(this.animNormalMinusUtils(d))
      )
    return transitionEffect
  }

  /* 点击动效 */
  //点击动效
  public isClick(){
    clickEffect =
       { level: ClickEffectLevel.MIDDLE, scale: 0.8 }

    return clickEffect
  }

}

export const animationStyle: AnimationStyle = PersistenceV2.connect(AnimationStyle, () => new AnimationStyle())!;
