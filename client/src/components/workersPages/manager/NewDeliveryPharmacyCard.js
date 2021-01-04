import React, {Component, useState, useEffect, useReducer} from "react";
import "./../../../App.css";
import axios from "axios";
import {connect} from "react-redux";
import {createUseStyles} from "react-jss";
import {addNewDeliveryPharmacy} from "./../../../actions/manager/addNewDeliveryPharmacy";
const useStyles = createUseStyles({
  card: {
    margin: 10,
    backgroundColor: "rgb(228, 199, 123)",
    padding: 10,
    color: "white",
    border: "black 2px",
    borderRadius: "5px",
    cursor: "pointer",
    width: "max-content"
  },
  image: {
    borderRadius: "10px",
    width: "175px",
    height: "175px",
    overflow: "hidden"
  },
  loginGrid: {
    display: "grid",
    gridTemplateColumns: "200px max-content",
    gridGap: "20px",
    alignItems: "center"
  }
});
function NewDeliveryPharmacyCard({shop, addNewDeliveryPharmacy}) {
  const classes = useStyles();

  const [city, setCity] = useState("");
  const [name, setName] = useState("");
  const [address, setAddress] = useState("");

  const [, forceUpdate] = useReducer(x => x + 1, 0);

  useEffect(() => forceUpdate(), [shop]);

  const onSubmit = e =>
    addNewDeliveryPharmacy({
      city,
      name,
      address
    });

  return (
    <div className={classes.card}>
      <div className={classes.loginGrid}>
        <label htmlFor="city">City</label>
        <input
          type="text"
          id="city"
          name="city"
          value={city}
          onChange={e => setCity(e.target.value)}
          required
        />
      </div>
      <div className={classes.loginGrid}>
        <label htmlFor="name">Name</label>
        <input
          type="text"
          id="name"
          name="name"
          value={name}
          onChange={e => setName(e.target.value)}
          required
        />
      </div>
      <div className={classes.loginGrid}>
        <label htmlFor="address">Address</label>
        <input
          type="text"
          id="address"
          name="address"
          value={address}
          onChange={e => setAddress(e.target.value)}
          required
        />
      </div>
      <button type="submit" onClick={e => onSubmit(e)}>
        Add Delivery pharmacy
      </button>
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
  addNewDeliveryPharmacy: addNewDeliveryPharmacy
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(NewDeliveryPharmacyCard);
