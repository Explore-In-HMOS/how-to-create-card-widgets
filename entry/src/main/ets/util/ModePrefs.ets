import { Context } from '@kit.AbilityKit';
import { preferences } from '@kit.ArkData';
import { Mode } from '../model/Mode';

export default class ModePrefs {
  static setMode(context: Context, newMode: Mode) {
    let prefs = preferences.getPreferencesSync(context, { name: 'mode_data' });
    prefs.putSync('mode', newMode)
    prefs.flushSync()
  }

  static getMode(context: Context): Mode {
    let prefs = preferences.getPreferencesSync(context, { name: 'mode_data' });
    return prefs.getSync('mode', Mode.happy) as Mode
  }
}