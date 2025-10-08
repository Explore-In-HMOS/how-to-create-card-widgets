import { Mode } from '../model/Mode';
import { ModeData } from '../model/ModeParcelable';
import ModePrefs from '../util/ModePrefs';
import WidgetIdPrefs from '../util/WidgetIdPrefs';
import { formBindingData, formProvider } from '@kit.FormKit';


@Entry
@Component
struct Index {
  @StorageLink('mode') mode: Mode = ModePrefs.getMode(this.getUIContext().getHostContext() as Context)

  build() {
    Row({ space: 8 }) {
      Button('😭')
        .fontSize(18)
        .backgroundColor(this.mode === Mode.sad ? Color.Red : Color.Grey)
        .type(ButtonType.Circle)
        .layoutWeight(1)
        .onClick(() => {
          this.changeMode(Mode.sad)
        })
      Button('😑')
        .fontSize(18)
        .backgroundColor(this.mode === Mode.neutral ? Color.Yellow : Color.Grey)
        .type(ButtonType.Circle)
        .layoutWeight(1)
        .onClick(() => {
          this.changeMode(Mode.neutral)
        })
      Button('😊')
        .fontSize(18)
        .backgroundColor(this.mode === Mode.happy ? Color.Green : Color.Grey)
        .type(ButtonType.Circle)
        .layoutWeight(1)
        .onClick(() => {
          this.changeMode(Mode.happy)
        })
    }
    .padding(8)
    .height('100%')
    .backgroundColor($r('sys.color.comp_background_primary'))
  }

  changeMode(newMode: Mode) {
    if (this.mode !== newMode) {
      this.mode = newMode
      ModePrefs.setMode(this.getUIContext().getHostContext() as Context, newMode)
      const ids = WidgetIdPrefs.getFormIDs(this.getUIContext().getHostContext() as Context)
      ids.forEach((id: string) => {
        const data: ModeData = { 'mode': newMode }
        let formInfo: formBindingData.FormBindingData = formBindingData.createFormBindingData(data);
        formProvider.updateForm(id, formInfo)
      })
    }
  }
}