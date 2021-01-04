import React, {Component, useState, useEffect} from "react";
import {BrowserRouter, Route, Redirect} from "react-router-dom";
import "./../../App.css";
import BasketCard from "./BasketCard";
import axios from "axios";
import {connect} from "react-redux";
import {createUseStyles} from "react-jss";
import {order} from "./../../actions/shop/order.js";

const useStyles = createUseStyles({
  Basket: {
    zIndex: 1,
    position: "fixed",
    top: 0,
    right: 0,
    display: "flex",
    flexDirection: "row",
    backgroundColor: "rgb(222, 136, 57)",
    color: "white",
    border: "black 2px",
    borderRadius: "5px",
    cursor: "pointer",
    padding: "5px",
    minWidth: "50px",
    maxHeight: "50vh"
  },
  Items: {
    overflowY: "scroll",
    display: "flex",
    flexDirection: "column"
  },
  Row: {
    display: "flex",
    flexDirection: "row",
    justifyContent: "space-between"
  },
  ExpandButton: {
    backgroundColor: "rgb(222, 136, 57)",
    border: "none"
  }
});

function Basket({items, user, order, ordError}) {
  const classes = useStyles();
  const [fullCost, setFullCost] = useState(0);
  const [city1, setCity1] = useState(0);
  const [expanded, toggleExpanded] = useState(items.length > 0);
  const [deliveryWarn, toggleDeliveryWarn] = useState(true);
  const [prescription, setPrescriptionReq] = useState(false);
  const [deliveryPharmacies, setDeliveryPharmacies] = useState([]);
  const [deliveryPharmacy, setDeliveryPharmacy] = useState(0);

  useEffect(() => {
    setFullCost(
      items.length > 0 ? items.reduce((a, b) => a + b.quantity * b.price, 0) : 0
    );
    toggleExpanded(items.length > 0 || deliveryPharmacy != 0);
    axios
      .get("/deliverypharmacies")
      .then(resp => setDeliveryPharmacies(resp.data))
      .catch(err => console.log(err));
  }, [items]);

  return (
    <div className={classes.Basket}>
      <button
        className={classes.ExpandButton}
        onClick={e => {
          toggleExpanded(!expanded);
        }}
      >
        |||
      </button>
      {expanded && (
        <div className={classes.Items}>
          <div>
            <p>Basket </p>
            {items.length > 0 ? (
              items.map(item => <BasketCard item={item} />)
            ) : (
              <p style={{color: "rgb(252, 72, 72)"}}>empty</p>
            )}
          </div>
          <p
            style={
              deliveryWarn ? {color: "rgb(252, 72, 72)"} : {color: "white"}
            }
          >
            <select
              name="city1"
              onChange={e => {
                setCity1(e.target.value);
                setDeliveryPharmacy(0);
                document.getElementById(
                  "select delivery pharmacy"
                ).selectedIndex = 0;
              }}
              value={city1}
            >
              <option value={0} disabled>
                choose city{" "}
              </option>
              {Array.from(new Set(deliveryPharmacies)).map(deliveryPharmacy => (
                <option value={deliveryPharmacy.city}>
                  {deliveryPharmacy.city}
                </option>
              ))}
            </select>
            <select
              name="delivery pharmacy"
              id="select delivery pharmacy"
              onChange={e => {
                toggleDeliveryWarn(false);
                console.log(JSON.parse(e.target.value));
                setDeliveryPharmacy(JSON.parse(e.target.value));
              }}
              defaultValue={deliveryPharmacy}
            >
              <option value={0} disabled selected>
                choose delivery pharmacy
              </option>
              {deliveryPharmacies
                .filter(deliveryPharmacy => deliveryPharmacy.city == city1)
                .map(delPharm => (
                  <option value={JSON.stringify(delPharm)}>
                    {delPharm.address}({delPharm.name})
                  </option>
                ))}
            </select>
            {items.length > 0 &&
              items
                .filter(item => item.prescription)
                .map(item => (
                  <div style={{color: "rgb(252, 72, 72)"}}>
                    {`prescription on ${item.name} is needed`}{" "}
                  </div>
                ))}
          </p>
          <div className={classes.Row}>
            <div>{`Sum of order: ${fullCost}$$`}</div>{" "}
            <button
              disabled={
                items.length < 1 || deliveryWarn || deliveryPharmacy == 0
              }
              onClick={e =>
                order({
                  items: items,
                  fullCost: fullCost,
                  user: user,
                  deliveryPharmacy: deliveryPharmacy
                })
              }
            >
              Order
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
const mapStateToProps = state => {
  return {
    items: state.shop.basketItems.map(item => {
      return {...item, fullPrice: item.quantity * item.price};
    }),
    user: state.auth.user,
    ordError: state.shop.ordError
  };
};

const mapDispatchToProps = {
  order: order
};
export default connect(mapStateToProps, mapDispatchToProps)(Basket);
