import React, {useState, useEffect} from "react";
import {BrowserRouter, Route, Redirect} from "react-router-dom";
import Login from "./../../auth/Login";
import Logout from "./../../auth/Logout";
import StockmanOrderCard from "./StockmanOrderCard";
import "./../../../App.css";
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

function StockmanProfilePage({shop, isAuthenticated}) {
  const classes = useStyles();
  const [orders, setOrders] = useState([]);

  useEffect(() => {
    axios
      .get("/stockmanOrders")
      .then(resp => {
        console.log(resp.data);
        setOrders(resp.data);
      })
      .catch(err => console.log(err));
  }, [shop]);

  return (
    <div>
      {!isAuthenticated && <Redirect to="/login" component={Login} />}

      <div className={classes.Categories}>
        {orders.length > 0 && orders.map(order => <StockmanOrderCard order={order} />)}
      </div>
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

export default connect(mapStateToProps, null)(StockmanProfilePage);
