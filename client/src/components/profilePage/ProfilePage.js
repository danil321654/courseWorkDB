import React, {useState, useEffect} from "react";
import {BrowserRouter, Route, Redirect} from "react-router-dom";
import Login from "./../auth/Login";
import Logout from "./../auth/Logout";
import Basket from "./../storePage/Basket";
import OrderCard from "./OrderCard";
import StorePage from "./../storePage/StorePage";
import "./../../App.css";
import axios from "axios";
import {connect} from "react-redux";
import {createUseStyles} from "react-jss";

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
    textAlign: "left"
  },
  button: {
    position: "fixed",
    top: "50px",
    left: 0
  }
});

function ProfilePage({shop, isAuthenticated}) {
  const classes = useStyles();
  const [orders, setOrders] = useState([]);
  const [receipts, setReceipts] = useState([]);
  const [goToStore, goToStorePage] = useState(false);

  useEffect(() => {
    axios
      .get("/orders")
      .then(resp => {
        console.log(resp.data);
        setOrders(resp.data.normalizedOrders);
        setReceipts(resp.data.clientReceipts);
      })
      .catch(err => console.log(err));
  }, [shop]);

  return (
    <div>
      {!isAuthenticated && <Redirect to="/login" component={Login} />}
      {goToStore && <Redirect to="/home" component={StorePage} />}
      <button className={classes.button} onClick={e => goToStorePage(true)}>
        <FontAwesomeIcon icon={fas.faStore}/>
      </button>

      <div className={classes.Categories}>
        {orders.length > 0 &&
          orders.map(order => (
            <OrderCard
              order={order}
              receipt={receipts.filter(rec => rec.order_id == order.id)[0]}
            />
          ))}
      </div>
      <Logout />
      <Basket />
    </div>
  );
}

const mapStateToProps = state => {
  return {
    isAuthenticated: state.auth.isAuthenticated,
    shop: state.shop
  };
};

export default connect(mapStateToProps, null)(ProfilePage);
