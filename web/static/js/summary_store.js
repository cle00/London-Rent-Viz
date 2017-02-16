import {observable, computed} from "mobx";

export default class SummaryStore {
  @observable selected = false;
  @observable stop = '';
  @observable place_name_slug = '';
  @observable avg_px = 0;
  @observable count = 0;
  @observable results = [];

  @computed get filter_results() {
    const pn = this.place_name_slug

    function filter_place_name(flat) {
      return flat.place_name == pn
    }
    return this.results.filter(filter_place_name)
  }
}
