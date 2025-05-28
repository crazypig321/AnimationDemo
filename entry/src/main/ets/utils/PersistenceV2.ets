import { AppStorageV2, PersistenceV2 } from "@kit.ArkUI";
import { themeColor } from "./ThemeColor";

@ObservedV2
class SaveUI{
  @Trace themeColor: ResourceColor | undefined = themeColor.colors?.brand

  clear(){
    PersistenceV2.remove(SaveUI)
    this.themeColor = themeColor.colors?.brand
  }
}

export const saveUI: SaveUI = PersistenceV2.connect(SaveUI,'SaveUI', () => new SaveUI())!;