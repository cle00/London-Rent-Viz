import {observable, computed} from "mobx";

class SummaryStore {
  @observable selected = false;
  @observable stop = '';
  @observable place_name_slug = '';
  @observable avg_px = 0;
  @observable count = 0;
  @observable results = [];
  @observable timeseries_res = [];

  constructor({socket}) {
    this.socket = socket;
    this.socket.connect()
    //this.handleChannelConnect = this.handleChannelConnect.bind(this);
  }
  @computed get filter_results() {
    const pn = this.place_name_slug

    function filter_place_name(flat) {
      return flat.place_name == pn
    }
    return this.results.filter(filter_place_name)
  }
  @computed get gen_timeseries() {
    return this.timeseries_res.map((ann) => ann)
  }
  handleChannelConnect(){
    let channel = this.socket.channel("underground_stop:"+ this.place_name_slug, {})
    channel.join()
      .receive("ok", ({timeseries}) => {
        this.timeseries_res = timeseries
      })
      .receive("error", reason => console.log("join failed", reason));
  }
}
export default SummaryStore
