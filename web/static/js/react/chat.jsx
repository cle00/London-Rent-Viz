import React from "react";

function ChatMessages(props){
  const messageList = props.messages.map((message, index) =>
    <p key={message.id}>{message.body}, {message.id}</p>
  );
  return (
    <div>{messageList}</div>
  )
}

export default class Chat extends React.Component {
  handleChannelConnect(channel){
    channel.on("new_annotation", (resp) => {
      this.setState({
        messages: this.state.messages.concat([resp])
      });
    });

    channel.join()
      .receive("ok", ({annotations}) => {
        this.setState({
          messages: annotations.map((ann) => ann )
        });
      })
      .receive("error", reason => console.log("join failed", reason));
  }

  constructor(props) {
    super(props);
    this.state = {
      text: '',
      messages: [],
      channel: props.socket.channel("videos:" + props.videoId)
    }

    this.updateInput = this.updateInput.bind(this);
    this.submit = this.submit.bind(this);
    this.handleChannelConnect = this.handleChannelConnect.bind(this);

    this.handleChannelConnect(this.state.channel);
  }

  submit(ev) {
    ev.preventDefault();
    let payload = {body: this.state.text, at:0};
    this.state.channel.push("new_annotation", payload)
                      .receive("error", e => console.log(e) );
  }

  updateInput(ev) {
    this.setState({
      text: ev.target.value
    });
  }

  render() {
    return (
      <div>
        <ChatMessages messages = {this.state.messages}/>
        <form onSubmit={this.submit}>
          <input onChange={this.updateInput}
            type="text"
            placeholder="Your message" />
          <input type="submit" value="Send" />
        </form>
      </div>
    )
  }
}
