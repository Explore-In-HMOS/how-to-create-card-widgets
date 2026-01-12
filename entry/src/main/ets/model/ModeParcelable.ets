import { Mode } from './Mode';
import { rpc } from '@kit.IPCKit';

export interface ModeData {
  mode: Mode;
}


export class ModeParcelable implements rpc.Parcelable {
  mode: Mode;

  constructor(mode: Mode) {
    this.mode = mode;
  }

  marshalling(messageSequence: rpc.MessageSequence): boolean {
    messageSequence.writeInt(this.mode);
    return true;
  }

  unmarshalling(messageSequence: rpc.MessageSequence): boolean {
    const dataObj: ModeData = JSON.parse(messageSequence.readString());
    this.mode = dataObj.mode;
    return true;
  }
}