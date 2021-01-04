import React, {useState, useEffect} from "react";
import {BrowserRouter, Route, Redirect} from "react-router-dom";
import Login from "./../../auth/Login";
import Logout from "./../../auth/Logout";
import AdminAccountRow from "./AdminAccountRow";
import axios from "axios";
import {connect} from "react-redux";
import {createUseStyles} from "react-jss";
import {rollBack} from "./../../../actions/manager/rollBack";
import {backup} from "./../../../actions/manager/backup";
import {restore} from "./../../../actions/manager/restore";

import {FontAwesomeIcon} from "@fortawesome/react-fontawesome";
import fontawesome from "@fortawesome/fontawesome";
import {fas} from "@fortawesome/free-solid-svg-icons";

fontawesome.library.add(fas);
const useStyles = createUseStyles({
  Categories: {
    display: "flex",
    flexDirection: "row",
    justifyContent: "flex-start",
    flexWrap: "wrap",
    textAlign: "left",
    border: "2px white solid"
  },
  logElem: {
    margin: "10px",
    border: "2px white yellow"
  },
  CategoriesLighted: {
    display: "flex",
    flexDirection: "row",
    justifyContent: "flex-start",
    flexWrap: "wrap",
    textAlign: "left",
    border: "2px white solid",
    backgroundColor: "pink"
  },
  button: {
    position: "fixed",
    top: "100px",
    left: 0
  }
});

function AdminTransactions({shop, isAuthenticated, adminsAccounts, rollBack, backup, restore}) {
  const classes = useStyles();
  const [selected, setSelected] = useState(0);
  const [accounts, setAccounts] = useState([]);
  useEffect(() => {
    console.log(selected);

    setAccounts(adminsAccounts.sort((a, b) => (a.id < b.id ? 1 : -1)));
  }, [adminsAccounts]);

  return (
    <div>
      {!isAuthenticated && <Redirect to="/login" component={Login} />}
      <button className={classes.button} onClick={e => rollBack(selected)}>
        <FontAwesomeIcon icon={fas.faUndoAlt} />
      </button>
      <button onClick={e => backup()}>backup</button>

      <button onClick={e => rollBack(1)}>restore</button>
      {accounts.length > 0 &&
        accounts.map((tr, j) => (
          <div
            className={
              j < selected ? classes.CategoriesLighted : classes.Categories
            }
            onClick={e => setSelected(j + 1)}
          >
            {Object.keys(tr).map((keyName, i) => (
              <div className={classes.logElem} key={i}>
                {keyName}: {tr[keyName]}
              </div>
            ))}
          </div>
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

const mapDispatchToProps = {
  rollBack: rollBack,
  backup: backup,
  restore: restore
};

export default connect(mapStateToProps, mapDispatchToProps)(AdminTransactions);
