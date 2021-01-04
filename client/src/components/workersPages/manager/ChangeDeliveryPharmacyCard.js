import React, {Component, useState, useEffect} from "react";
import "./../../../App.css";
import axios from "axios";
import {connect} from "react-redux";
import {createUseStyles} from "react-jss";
import {changeOldDeliveryPharmacy} from "./../../../actions/manager/changeOldDeliveryPharmacy";
import {mngrDelete} from "./../../../actions/manager/mngrDelete";
const useStyles = createUseStyles({
  card: {
    margin: 10,
    backgroundColor: "rgb(228, 199, 123)",
    padding: 10,
    color: "white",
    border: "black 2px",
    borderRadius: "5px",
    cursor: "pointer",
    width: "max-content",
    height: "min-content"
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
function ChangeDeliveryPharmacyCard({
  shop,
  deliveryPharmacies,
  changeOldDeliveryPharmacy,
  mngrDelete
}) {
  const classes = useStyles();

  const [address, setAddress] = useState("");
  const [name, setName] = useState("");
  const [city, setCity] = useState("");
  const [city1, setCity1] = useState(0);

  const [oldDeliveryPharmacy, setOldDeliveryPharmacy] = useState(0);

  useEffect(() => {
    setName(oldDeliveryPharmacy.name);
    setAddress(oldDeliveryPharmacy.address);
    setCity(oldDeliveryPharmacy.city);
  }, [shop, oldDeliveryPharmacy]);

  const onSubmit = e => {
    e.preventDefault();
    changeOldDeliveryPharmacy({
      address,
      name,
      city,
      id: oldDeliveryPharmacy.id
    });
  };

  return (
    <div className={classes.card}>
      <select
        name="city1"
        onChange={e => {
          setCity1(e.target.value);
          setOldDeliveryPharmacy(0);
        }}
        value={city1}
      >
        <option value={0} disabled>
          choose city{" "}
        </option>
        {Array.from(new Set(deliveryPharmacies)).map(deliveryPharmacy => (
          <option value={deliveryPharmacy.city}>{deliveryPharmacy.city}</option>
        ))}
      </select>
      <select
        name="OldDeliveryPharmacy"
        onChange={e => setOldDeliveryPharmacy(JSON.parse(e.target.value))}
        value={JSON.stringify(oldDeliveryPharmacy)}
      >
        <option value={0} disabled>
          choose deliveryPharmacy{" "}
        </option>
        {deliveryPharmacies
          .filter(deliveryPharmacy => deliveryPharmacy.city == city1)
          .map(deliveryPharmacy => (
            <option value={JSON.stringify(deliveryPharmacy)}>
              {`${deliveryPharmacy.name}(${deliveryPharmacy.address})`}
            </option>
          ))}
      </select>

      {oldDeliveryPharmacy != 0 && (
        <form action="/changeOld" onSubmit={onSubmit}>
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
            Change DeliveryPharmacy
          </button>

          <button
            onClick={e =>
              mngrDelete({
                table: "Delivery_pharmacy",
                id: oldDeliveryPharmacy.id
              })
            }
          >
            Delete delivery pharmacy
          </button>
        </form>
      )}
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
  changeOldDeliveryPharmacy: changeOldDeliveryPharmacy,
  mngrDelete: mngrDelete
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ChangeDeliveryPharmacyCard);
