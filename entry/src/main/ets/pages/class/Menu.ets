/**
 * 菜单实体类
 */
export class Menu {
  path: String = ''
  name: String = ''

  constructor(path: String, name: String) {
    this.path = path;
    this.name = name
  }
}
