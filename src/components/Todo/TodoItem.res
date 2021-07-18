@react.component
let make = (~todo: TodosQuery.Inner.t_todos) => {
  let removeTodo = _e => ()
  let toggleTodo = _e => ()

  <li>
    <div className="view">
      <div className="round">
        <input
          checked={todo.is_completed}
          type_="checkbox"
          id={Js.Int.toString(todo.id)}
          onChange={toggleTodo}
        />
        <label htmlFor={Js.Int.toString(todo.id)} />
      </div>
    </div>
    <div className={"labelContent" ++ (todo.is_completed ? " completed" : "")}>
      <div> {todo.title->React.string} </div>
    </div>
    <button className="closeBtn" onClick={removeTodo}> {"x"->React.string} </button>
  </li>
}

let default = make
