import { HashMap } from '@kit.ArkTS'

@Entry
@Component
export struct TouTai {

  private continentDict: HashMap<String, String> = new HashMap();

  build() {
    Row() {
      Column() {
        Button('投胎')
          .width(100)
          .height(50)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .backgroundColor('#ff0b0d0e')
          .onClick(async e => {

          })
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