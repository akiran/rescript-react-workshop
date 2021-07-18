%raw("require('./styles/App.css')")
let {render, querySelector} = module(ReactDOM)

let authConfig = Auth0Variables.authConfig

switch querySelector("#root") {
| None => ()
| Some(e) =>
  render(
    <AuthWrapper.Auth0Provider
      domain={authConfig.domain}
      client_id={authConfig.clientId}
      redirect_uri={authConfig.callbackUrl}
    />,
    e,
  )
}
