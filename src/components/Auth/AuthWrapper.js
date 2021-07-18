import React, { useState, useEffect, useContext } from "react";
import createAuth0Client from "@auth0/auth0-spa-js";
import Loading from "./Loading.bs";
import Login from "./Login.bs";
import App from "../App.bs";

const onRedirectCallback = () =>
  window.history.replaceState({}, document.title, window.location.pathname);

export const Auth0Context = React.createContext();
export const useAuth0 = () => useContext(Auth0Context);
export const Auth0Provider = ({ children, ...initOptions }) => {
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [auth0Client, setAuth0] = useState();
  const [loading, setLoading] = useState(true);
  const [idToken, setIdToken] = useState("");

  useEffect(() => {
    const initAuth0 = async () => {
      const auth0FromHook = await createAuth0Client(initOptions);
      setAuth0(auth0FromHook);

      if (window.location.search.includes("code=")) {
        const { appState } = await auth0FromHook.handleRedirectCallback();
        onRedirectCallback(appState);
      }

      const isAuthenticated = await auth0FromHook.isAuthenticated();

      setIsAuthenticated(isAuthenticated);

      if (isAuthenticated) {
        const idTokenClaims = await auth0FromHook.getIdTokenClaims();
        setIdToken(idTokenClaims.__raw);
      }

      setLoading(false);
    };
    initAuth0();
    // eslint-disable-next-line
  }, []);

  if (loading) {
    return <Loading />;
  }
  if (!isAuthenticated) {
    return (
      <Auth0Context.Provider
        value={{
          isAuthenticated,
          loading,
          loginWithRedirect: (...p) => auth0Client.loginWithRedirect(...p),
          logout: (...p) => auth0Client.logout(...p),
        }}
      >
        <Login />
      </Auth0Context.Provider>
    );
  }

  return (
    <Auth0Context.Provider
      value={{
        isAuthenticated,
        loading,
        loginWithRedirect: (...p) => auth0Client.loginWithRedirect(...p),
        logout: (...p) => auth0Client.logout(...p),
      }}
    >
      {children}
      <App idToken={idToken} />
    </Auth0Context.Provider>
  );
};
