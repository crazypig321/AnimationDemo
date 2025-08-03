import { AppStorageV2, PersistenceV2 } from "@kit.ArkUI";
import { themeColor } from "./ThemeColor";

@ObservedV2
export class SaveUI{
  @Trace themeColor: ResourceColor | undefined = themeColor.colors?.brand

  clear(){
    PersistenceV2.remove(SaveUI)
    this.themeColor = themeColor.colors?.brand
  }
}

export const makeSaveUI = () => PersistenceV2.connect(SaveUI,'SaveUI', () => new SaveUI())!;