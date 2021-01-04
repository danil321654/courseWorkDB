import React, {useState, useEffect} from "react";
import {BrowserRouter, Route, Redirect} from "react-router-dom";
import Login from "./../../auth/Login";
import Logout from "./../../auth/Logout";
import AdminAccountRow from "./AdminAccountRow";
import axios from "axios";
import {connect} from "react-redux";
import {createUseStyles} from "react-jss";

const useStyles = createUseStyles({
  Categories: {
    display: "flex",
    flexDirection: "row",
    justifyContent: "flex-start",
    flexWrap: "wrap",
    textAlign: "left"
  }
});

function AdminAccountsTable({shop, isAuthenticated, adminsAccounts, role}) {
  const classes = useStyles();
  const [accounts, setAccounts] = useState([]);
  useEffect(() => {
  }, [adminsAccounts]);

  return (
    <div>
      {!isAuthenticated && <Redirect to="/login" component={Login} />}
      <AdminAccountRow
        account={{login: "login", email: "email", name: "name"}}
      />
      {adminsAccounts.map(acc => (
        <AdminAccountRow account={{...acc, role: role}} />
      ))}
      <Logout />
    </div>
  );
}

const mapStateToProps = state => {
  return {
    isAuthenticated: state.auth.isAuthenticated,
    shop: state.shop
  };
};

export default connect(mapStateToProps, null)(AdminAccountsTable);
