type auth0Hook = {loading: bool, logout: unit => unit, loginWithRedirect: unit => unit}
@module("../components/Auth/AuthWrapper") external useAuth0: unit => auth0Hook = "useAuth0"

module Auth0Provider = {
  @module("../components/Auth/AuthWrapper") @react.component
  external make: (~domain: string, ~client_id: string, ~redirect_uri: string) => React.element =
    "Auth0Provider"
}
