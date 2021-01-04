import React, {Component, useState, useEffect, useReducer} from "react";
import "./../../../App.css";
import axios from "axios";
import {connect} from "react-redux";
import {createUseStyles} from "react-jss";
import {addNewManufacturer} from "./../../../actions/manager/addNewManufacturer";
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
function NewManufacturerCard({shop, addNewManufacturer}) {
  const classes = useStyles();

  //new drug info
  const [name, setName] = useState("");
  const [country, setCountry] = useState("");

  const [, forceUpdate] = useReducer(x => x + 1, 0);

  useEffect(() => forceUpdate(), [shop]);

  const onSubmit = e =>
    addNewManufacturer({
      name,
      country
    });

  return (
    <div className={classes.card}>
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
        <label htmlFor="country">Country</label>
        <input
          type="text"
          id="country"
          name="country"
          value={country}
          onChange={e => setCountry(e.target.value)}
          required
        />
      </div>
      <button type="submit" onClick={e => onSubmit(e)}>
        Add Manufacturer
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
  addNewManufacturer: addNewManufacturer
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(NewManufacturerCard);
