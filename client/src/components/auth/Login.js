import React, {useState, useEffect} from "react";

import {connect} from "react-redux";
import {login} from "../../actions/login";
import {auth} from "../../actions/auth";

import {BrowserRouter, Route, Redirect} from "react-router-dom";
import StorePage from "./../storePage/StorePage";
import ManagerPage from "./../workersPages/manager/ManagerPage";
import StockmanProfilePage from "./../workersPages/stockman/StockmanProfilePage";
import AdminProfilePage from "./../workersPages/admin/AdminProfilePage";
import {createUseStyles} from "react-jss";

const useStyles = createUseStyles({
  loginGrid: {
    display: "grid",
    gridTemplateColumns: "200px max-content",
    gridGap: "20px"
  }
});
const Login = ({authObj, login, auth}) => {
  const classes = useStyles();

  const [email, setEmail] = useState("t@t");
  const [password, setPassword] = useState("t");
  useEffect(() => {
    auth();
  }, []);

  const onSubmit = e => {
    e.preventDefault();
    console.log({
      email,
      password
    });
    login({email, password});
  };

  return (
    <React.Fragment>
      {authObj.user && authObj.user.role == "CLIENT" && (
        <Redirect to="/home" component={StorePage} />
      )}

      {authObj.user && authObj.user.role == "MANAGER" && (
        <Redirect to="/managerHome" component={ManagerPage} />
      )}

      {authObj.user && authObj.user.role == "STOCKMAN" && (
        <Redirect to="/stockmanProfilePage" component={StockmanProfilePage} />
      )}

      {authObj.user && authObj.user.role == "ADMIN" && (
        <Redirect to="/adminProfilePage" component={AdminProfilePage} />
      )}
      <h1>Login</h1>
      <h1>{authObj.logError}</h1>

      <form action="/login" method="POST" onSubmit={onSubmit}>
        <div  className={classes.loginGrid}>
          <label htmlFor="email">Email</label>
          <input
            type="email"
            id="email"
            name="email"
            value={email}
            onChange={e => setEmail(e.target.value)}
            required
          />
        </div>
        <div  className={classes.loginGrid}>
          <label htmlFor="password">Password</label>
          <input
            type="password"
            id="password"
            name="password"
            value={password}
            onChange={e => setPassword(e.target.value)}
            required
          />
        </div>

        <button type="submit">Login</button>
      </form>

      <a href="/Register">Register</a>
    </React.Fragment>
  );
};

const mapStateToProps = state => ({authObj: state.auth});

export default connect(mapStateToProps, {login, auth})(Login);
