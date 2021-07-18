@react.component
let make = (~isPublic=false) => {
  let (todoInput, setTodoInput) = React.useState(_ => "")

  let resetInput = _e => {
    setTodoInput(_ => "")
  }
  <form className="formInput" onSubmit={resetInput}>
    <input
      className="input"
      value={todoInput}
      placeholder="What needs to be done?"
      onChange={e => setTodoInput(ReactEvent.Form.target(e)["value"])}
    />
    <i className="inputMarker fa fa-angle-right" />
  </form>
}

let default = make
