import React, {Component, useState} from "react";
import {BrowserRouter, Route, Redirect} from "react-router-dom";
import "./App.css";
import axios from "axios";
import {connect} from "react-redux";
import Register from "./components/auth/Register";
import Login from "./components/auth/Login";
import StorePage from "./components/storePage/StorePage";
import ManagerPage from "./components/workersPages/manager/ManagerPage";
import ManagerProfilePage from "./components/workersPages/manager/ManagerProfilePage";
import AdminProfilePage from "./components/workersPages/admin/AdminProfilePage";
import StockmanProfilePage from "./components/workersPages/stockman/StockmanProfilePage";
import ProfilePage from "./components/profilePage/ProfilePage";
import {login} from "./actions/login";
import {register} from "./actions/register";
import {logout} from "./actions/logout";

import {createUseStyles} from "react-jss";

const useStyles = createUseStyles({
  App: {
    minHeight: "100vh",
    backgroundColor: "#282c34",
    fontSize: "calc(10px + 2vmin)",
    padding: "70px",
    color: "white"
  }
});

function App({auth}) {
  const classes = useStyles();
  return (
    <div className={classes.App}>
      <header>
        <BrowserRouter>
          <Route path="/login" component={Login} />
          <Route path="/home" component={StorePage} />
          <Route path="/managerHome" component={ManagerPage} />
          <Route path="/managerProfilePage" component={ManagerProfilePage} />
          <Route path="/stockmanProfilePage" component={StockmanProfilePage} />
          <Route path="/adminProfilePage" component={AdminProfilePage} />
          <Route path="/profile" component={ProfilePage} />
          <Route path="/register" component={Register} />
          <Route exact path="/">
            {!auth.isAuthenticated ? (
              <Redirect to="/login" component={Login} />
            ) : (
              <Redirect to="/home" component={StorePage} />
            )}
          </Route>
        </BrowserRouter>
      </header>
    </div>
  );
}

const mapStateToProps = state => {
  return {
    auth: state.auth
  };
};

const mapDispatchToProps = {
  login: login,
  register: register,
  logout: logout
};

export const Container = connect(mapStateToProps, mapDispatchToProps)(App);
