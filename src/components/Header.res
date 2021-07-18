open ReactBootstrap

@react.component
let make = () =>
  <Navbar className="justify-content-between">
    <Navbar.Brand> {"GraphQL Tutorial App"->React.string} </Navbar.Brand>
  </Navbar>

let default = make
