import { MuYu } from './MuYu';
import { media } from '@kit.MediaKit';
import { QiuQian } from './QiuQian';
import { MyAVPlayer } from './class/MyAVPlayer';
import { Menu } from './class/Menu'
import { TouTai } from './TouTai';


@Entry
@Component
struct Index {
  @State
  activeMenu: String = 'muyu'; // 选项卡下标，默认为第一个
  @State
  activeMenuName: String = '木鱼'
  private menuImgArr: Menu[] = [
    new Menu('muyu', '木鱼'),
    new Menu('yinyue', '木鱼'),
    // new Menu('shaoxiang', '烧香'),
    new Menu('qiuqian', '求签'),
    new Menu('toutai', '投胎'),
  ]
  @State
  avPlayer: media.AVPlayer | null = null;
  @State
  myAVPlayer: MyAVPlayer = new MyAVPlayer()

  // 通过Builder自定义标题栏，可以灵活的设置标题样式
  @Builder
  title() {
    Row() {
      Text('功德无量\n' + this.activeMenuName.toString())
        .fontSize(30)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Center)
        .width('100%')
    }
    .width('100%')
    .height(120)
    .backgroundColor('#2c3135')
  }

  // 通过builder自定义toolbar
  @Builder
  toolbar() {
    Row() {
      Flex({
        direction: FlexDirection.Row,
        justifyContent: FlexAlign.SpaceAround
      }) {
        ForEach(this.menuImgArr, (item: Menu) => {
          Image($r(`app.media.${item.path}`))
            .height(80)
            .margin({ bottom: 30 })
            .onClick(async e => {
              this.activeMenu = item.path.toString()
              this.activeMenuName = item.name.toString()

              // 如果点击音乐菜单直接播放
              if (this.activeMenu == 'yinyue') {
                if (this.avPlayer == null) {
                  // 初始化avPlayer
                  this.avPlayer = await this.myAVPlayer.avPlayerFdSrcDemo('fojing_audio.mp3')
                } else {
                  if (this.avPlayer.state != 'playing') {
                    // 重新播放
                    await this.myAVPlayer.avPlayerFdSrcDemo('fojing_audio.mp3')
                  } else {
                    // 停止播放
                    this.avPlayer.reset()
                  }
                }
              }
            })
        })
      }
    }
    .width('100%')
    .height(120)
    .backgroundColor('#2c3135')
  }

  build() {
    Row() {
      // 底部菜单
      Navigation() {
        if (this.activeMenu.toString() == 'muyu' || this.activeMenu.toString() == 'yinyue') {
          MuYu()
        } else if (this.activeMenu.toString() == 'shaoxiang') {
          // TODO
        } else if (this.activeMenu.toString() == 'qiuqian') {
          QiuQian()
        } else if (this.activeMenu.toString() == 'toutai') {
          TouTai()
        }
      }
      .title(this.title)
      .mode(NavigationMode.Auto)
      .toolbarConfiguration(this.toolbar())
      .backgroundColor('#2c3135')
      .width('100%')
    }
    .width('100%')
    .height('100%')
  }
}