import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import ModePrefs from '../util/ModePrefs';
import { ModeData, ModeParcelable } from '../model/ModeParcelable';
import { rpc } from '@kit.IPCKit';
import { vibrator } from '@kit.SensorServiceKit';

const DOMAIN = 0x0000;

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onCreate');

    // postCardAction 'call' is caught here
    this.callee.on('changeMode', (data: rpc.MessageSequence) => {
      // Obtain all parameters passed in the call event.
      const dataObj: ModeData = JSON.parse(data.readString());

      AppStorage.set('mode', dataObj.mode);
      ModePrefs.setMode(this.context, dataObj.mode);
      vibrator.startVibration({ type: 'time', duration: 200 }, { usage: 'physicalFeedback' });
      return new ModeParcelable(dataObj.mode);
    });
  }

  onDestroy(): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onDestroy');
    this.callee.off('changeMode');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(DOMAIN, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err));
        return;
      }
      hilog.info(DOMAIN, 'testTag', 'Succeeded in loading the content.');

      const mode = ModePrefs.getMode(this.context);
      PersistentStorage.persistProp('mode', mode);
      AppStorage.set('mode', mode);
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(DOMAIN, 'testTag', '%{public}s', `Ability onForeground ${ModePrefs.getMode(this.context)}`);
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onBackground');
  }
};