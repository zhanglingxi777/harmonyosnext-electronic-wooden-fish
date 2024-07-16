export class Qian {
  /**
   * 编号
   */
  num: String = ''
  /**
   * 标题
   */
  title: String = ''
  /**
   * 内容
   */
  content: String = ''
  /**
   * 诗意
   */
  sy: String = ''
  /**
   * 解日
   */
  jy: String = ''

  constructor(num: String, title: String, content: String, sy: String, jy: String) {
    this.num = num
    this.title = title
    this.content = content
    this.sy = sy
    this.jy = jy
  }
}