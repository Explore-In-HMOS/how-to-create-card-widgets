import { Mode } from '../../model/Mode'

let ls = new LocalStorage();

@Entry(ls)
@Component
struct MyModeCard {
  @LocalStorageProp('mode') mode: Mode = Mode.happy

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
    .onClick(() => {
      postCardAction(this, {
        action: 'router',
        abilityName: 'EntryAbility',
      });
    })
  }

  changeMode(newMode: Mode) {
    if (this.mode !== newMode) {
      this.mode = newMode
      this.postCardActionCall(newMode)
    }
  }

  postCardActionCall(newMode: Mode) {
    postCardAction(this, {
      action: 'call',
      abilityName: 'EntryAbility',
      params: {
        // function name
        method: 'changeMode',
        // additional parameters
        mode: newMode
      }
    });
  }
}