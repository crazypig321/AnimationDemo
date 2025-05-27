import { PersistenceV2 } from "@kit.ArkUI";
import { themeColor } from "./ThemeColor";

@ObservedV2
class SaveUI{
  @Trace themeColor = themeColor.colors?.brand
  @Trace tabSelectedIndexes: number[] = [0]

}

export const saveUI: SaveUI = PersistenceV2.connect(SaveUI,'SaveUI', () => new SaveUI())!;