import { media } from '@kit.MediaKit';
import { MyAVPlayer } from './class/MyAVPlayer';

@Entry
@Component
export struct MuYu {
  // 第一步: 声明相关状态变量
  @State
  rotateValue: number = 20; // 旋转角度
  @State
  opacityValue: number = 0; // 透明度
  @State
  translateYValue: number = 0; // 上移
  @State
  count: number = 0 //功德数量
  @State
  avPlayer: media.AVPlayer | null = null;
  @State
  myAVPlayer: MyAVPlayer = new MyAVPlayer()

  build() {
    Row() {
      // 功能区
      Column() {
        // 功德+1
        Text('功德+1')
          .width(100)
          .height(30)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#f39c12')
          .margin({ left: 25, bottom: 30 })
          .translate({ y: this.translateYValue })
          .opacity(this.opacityValue)

        // 木棍图片-初始位置
        Image($r('app.media.gun'))
          .id('gunImg')
          .width(200)
          .height(50)
          .rotate({ angle: this.rotateValue })
          .margin({ left: 140, bottom: -20 })

        // 木鱼图片
        Image($r("app.media.beat"))
          .width(260)
          .height(200)// 敲击动画
          .onClick(async e => {
            this.count++
            this.avPlayer = await this.myAVPlayer.avPlayerFdSrcDemo('beat_fast_audio.mp3')
            // 定时器同步敲击音频和动画
            setTimeout(() => {
              animateTo({
                duration: 300,
                curve: Curve.Friction,
                // 敲击结束动画
                onFinish: () => {
                  animateTo({
                    duration: 100,
                    curve: Curve.Friction
                  }, () => {
                    this.rotateValue = 20;
                    this.opacityValue = 0
                  })
                }
              }, () => {
                this.rotateValue = 5;
                this.opacityValue = 1
              })
            }, 200)
          })

        // 功德数
        Text('功德: ' + this.count.toString())
          .width(200)
          .height(36)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor('#f39c12')
          .textAlign(TextAlign.Center)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    // 背景图
    .backgroundImage($r('app.media.fz'))
    .backgroundColor('#2c3135')
    .backgroundImageSize({
      width: '100%',
      height: '100%'
    })
  }
}