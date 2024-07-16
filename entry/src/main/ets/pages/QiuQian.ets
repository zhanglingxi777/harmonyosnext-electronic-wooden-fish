import { JSON } from '@kit.ArkTS';
import { common } from '@kit.AbilityKit';
import util from '@ohos.util';
import { Qian } from './class/Qian';

@Entry
@Component
export struct QiuQian {
  @State
  qian: Qian | null = null
  @State
  showQian: Boolean = false
  @State
  showJie: Boolean = false

  /**
   * 求签
   * @returns 随机签
   */
  async qiu(): Promise<Qian | null> {
    let context = getContext(this) as common.UIAbilityContext;
    let qianJson = await context.resourceManager.getRawFileContent('qian.json');
    let textDecoder = util.TextDecoder.create('utf-8', { ignoreBOM: true });
    let json = JSON.parse(textDecoder.decodeWithStream(qianJson, { stream: false }))
    if (json != null) {
      let qians = Object.values(json) as Qian[]
      let rand = Math.floor(Math.random() * 100)
      return qians[rand]
    }
    return null
  }

  build() {
    Row() {
      Column() {
        /**
         * 签
         */
        Column() {
          if (this.qian != null) {
            // 标题
            Text(this.qian.title.toString())
              .fontSize(26)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
              .height(60)
            // 内容-0
            Text(this.qian.content.toString().split('。')[0])
              .fontSize(20)
              .fontColor(Color.White)
            // 内容-0
            Text(this.qian.content.toString().split('。')[1])
              .fontSize(20)
              .fontColor(Color.White)
              .margin({ top: 5 })
          }
        }
        .visibility(this.showQian ? Visibility.Visible : Visibility.None)

        /**
         * 解
         */
        Column() {
          if (this.qian != null) {
            // 诗意
            Text('诗意: ' + this.qian.sy.toString())
              .fontSize(16)
              .fontColor('#bdc3c7')
            // 解曰
            Text('解曰: ' + this.qian.jy.toString())
              .fontSize(16)
              .fontColor('#bdc3c7')
              .margin({ top: 5 })
          }
        }
        .margin({ left: 10, top: 20 })
        .alignItems(HorizontalAlign.Start)
        .visibility(this.showJie ? Visibility.Visible : Visibility.None)

        Button(this.qian == null ? '求签' : '解签')
          .width(100)
          .height(50)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .backgroundColor('#ff0b0d0e')
          .onClick(async e => {
            if (this.qian == null) {
              // 求签
              this.qian = await this.qiu()
              this.showQian = true
            } else {
              // 解签
              this.showJie = true
            }
          })
          .visibility((this.showQian && this.showJie) ? Visibility.None : Visibility.Visible)
      }
      .width('100%')
    }
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