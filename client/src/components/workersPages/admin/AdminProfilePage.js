import React, {useState, useEffect} from "react";
import {BrowserRouter, Route, Redirect} from "react-router-dom";
import Login from "./../../auth/Login";
import Logout from "./../../auth/Logout";
import AdminAccountsTable from "./AdminAccountsTable";
import AdminTransactions from "./AdminTransactions";

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
  },
  row: {
    display: "flex",
    flexDirection: "row",
    justifyContent: "space-around",
    flexWrap: "wrap"
  }
});

function AdminProfilePage({shop, isAuthenticated}) {
  const classes = useStyles();
  const [curTab, changeCurTab] = useState("CLIENT");
  const [accounts, setAccounts] = useState({
    clients: [],
    managers: [],
    stockmans: [],
    admins: []
  });

  useEffect(() => {
    axios
      .get("/adminInfo")
      .then(resp => {
        let tempAdmins = resp.data.admins.map(adm => adm.client_id);
        let resAdmins = resp.data.clients.filter(client =>
          tempAdmins.includes(client.id)
        );
        let tempManagers = resp.data.managers.map(man => man.client_id);
        let resManagers = resp.data.clients.filter(client =>
          tempManagers.includes(client.id)
        );

        let tempStockmans = resp.data.stockmans.map(stm => stm.client_id);
        let resStockmans = resp.data.clients
          .filter(client => tempStockmans.includes(client.id))
          .map(client => {
            return {
              ...client,
              delivery_pharmacy_id: resp.data.stockmans.filter(
                stockman => stockman.client_id == client.id
              )[0].delivery_pharmacy_id
            };
          });

        let resClients = resp.data.clients.filter(
          client =>
            !tempStockmans.includes(client.id) &&
            !tempManagers.includes(client.id) &&
            !tempAdmins.includes(client.id)
        );
        console.log({
          clients: resClients,
          managers: resManagers,
          stockmans: resStockmans,
          admins: resAdmins,
          transactions: resp.data.transactions
        });
        setAccounts({
          clients: resClients,
          managers: resManagers,
          stockmans: resStockmans,
          admins: resAdmins,
          transactions: resp.data.transactions
        });
      })
      .catch(err => console.log(err));
  }, [shop, curTab]);

  return (
    <div>
      {!isAuthenticated && <Redirect to="/login" component={Login} />}
      <div className={classes.row}>
        <div onClick={e => changeCurTab("CLIENT")}>CLIENT</div>{" "}
        <div onClick={e => changeCurTab("MANAGER")}>MANAGER</div>{" "}
        <div onClick={e => changeCurTab("STOCKMAN")}>STOCKMAN</div>{" "}
        <div onClick={e => changeCurTab("ADMIN")}>ADMIN</div>{" "}
        <div onClick={e => changeCurTab("TRANSACTIONS")}>TRANSACTIONS</div>
      </div>
      {curTab == "CLIENT" && (
        <AdminAccountsTable adminsAccounts={accounts.clients} role={curTab} />
      )}
      {curTab == "MANAGER" && (
        <AdminAccountsTable adminsAccounts={accounts.managers} role={curTab} />
      )}
      {curTab == "STOCKMAN" && (
        <AdminAccountsTable adminsAccounts={accounts.stockmans} role={curTab} />
      )}
      {curTab == "ADMIN" && (
        <AdminAccountsTable adminsAccounts={accounts.admins} role={curTab} />
      )}
      {curTab == "TRANSACTIONS" && (
        <AdminTransactions adminsAccounts={accounts.transactions} />
      )}
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

export default connect(mapStateToProps, null)(AdminProfilePage);
