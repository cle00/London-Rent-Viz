import {observable} from "mobx";

export default class SummaryStore {
  @observable selected = false;
  @observable stop = 'aa';
  @observable avg_px = 100;
  @observable count = 10;
}
