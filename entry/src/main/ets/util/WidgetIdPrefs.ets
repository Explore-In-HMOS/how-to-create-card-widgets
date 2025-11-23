import { Context } from '@kit.AbilityKit';
import { preferences } from '@kit.ArkData';

export default class WidgetIdPrefs {
  static addFormID(context: Context, formID: string) {
    let prefs = preferences.getPreferencesSync(context, { name: 'ids' });
    prefs.putSync(formID, formID)
    prefs.flushSync()
  }

  static removeFormID(context: Context, formID: string) {
    let prefs = preferences.getPreferencesSync(context, { name: 'ids' });
    prefs.deleteSync(formID)
    prefs.flushSync()
  }

  static getFormIDs(context: Context): string[] {
    let prefs = preferences.getPreferencesSync(context, { name: 'ids' });
    return Object.values(prefs.getAllSync())
  }
}