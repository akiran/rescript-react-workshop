@react.component
let make = () => {
  <div>
    <Header />
    <div className="row container-fluid p-left-right-0 m-left-right-0">
      <div className="row col-md-9 p-left-right-0 m-left-right-0">
        <div className="col-md-6 sliderMenu p-30"> <TodoPrivateWrapper /> </div>
        <div className="col-md-6 sliderMenu p-30 bg-gray border-right" />
      </div>
      <div className="col-md-3 p-left-right-0">
        <div className="col-md-12 sliderMenu p-30 bg-gray"> <OnlineUsersWrapper /> </div>
      </div>
    </div>
  </div>
}

let default = make
