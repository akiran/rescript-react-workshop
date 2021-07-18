type todoPrivateListState = {
  filter: string,
  clearInProgress: bool,
}

let initialState = {
  filter: "all",
  clearInProgress: false,
}

@react.component
let make = () => {
  let todosResult = TodosQuery.use()
  let (state, setState) = React.useState(_ => initialState)

  let filterResults = filter => {
    setState(_ => {
      ...state,
      filter: filter,
    })
  }

  let clearCompleted = _e => ()

  switch todosResult {
  | {loading: true} => <div> {React.string("Loading...")} </div>
  | {data: Some({todos}), error: None} => {
      let filteredTodos = switch state.filter {
      | "active" => Js.Array2.filter(todos, todo => todo.is_completed !== true)
      | "completed" => Js.Array2.filter(todos, todo => todo.is_completed === true)
      | _ => todos
      }

      let todoList = Js.Array2.mapi(filteredTodos, (todo, index) =>
        <TodoItem key={Js.Int.toString(index)} todo={todo} />
      )

      <React.Fragment>
        <div className="todoListWrapper"> <ul> {React.array(todoList)} </ul> </div>
        <TodoFilters
          todos={filteredTodos}
          currentFilter={state.filter}
          filterResultsFn={filterResults}
          clearCompletedFn={clearCompleted}
        />
      </React.Fragment>
    }
  | {error} => {
      Js.log(error)
      <div> {React.string("Error!")} </div>
    }
  }
}

let default = make
