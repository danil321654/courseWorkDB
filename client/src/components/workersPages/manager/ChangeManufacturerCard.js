import React, {Component, useState, useEffect} from "react";
import "./../../../App.css";
import axios from "axios";
import {connect} from "react-redux";
import {createUseStyles} from "react-jss";
import {changeOldManufacturer} from "./../../../actions/manager/changeOldManufacturer";
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
function ChangeManufacturerCard({
  shop,
  manufacturers,
  changeOldManufacturer,
  mngrDelete
}) {
  const classes = useStyles();

  //new drug info
  const [name, setName] = useState("");
  const [country, setCountry] = useState("");
  const [country1, setCountry1] = useState(0);

  const [oldManufacturer, setOldManufacturer] = useState(0);

  useEffect(() => {
    setName(oldManufacturer.name);
    setCountry(oldManufacturer.country);
  }, [shop, oldManufacturer]);

  const onSubmit = e => {
    e.preventDefault();
    changeOldManufacturer({
      name,
      country,
      id: oldManufacturer.id
    });
  };

  return (
    <div className={classes.card}>
      <select
        name="country1"
        onChange={e => {
          setCountry1(e.target.value);
          setOldManufacturer(0);
        }}
        value={country1}
      >
        <option value={0} disabled>
          choose country{" "}
        </option>
        {Array.from(new Set(manufacturers)).map(manufacturer => (
          <option value={manufacturer.country}>{manufacturer.country}</option>
        ))}
      </select>
      <select
        name="OldManufacturer"
        onChange={e => setOldManufacturer(JSON.parse(e.target.value))}
        value={JSON.stringify(oldManufacturer)}
      >
        <option value={0} disabled>
          choose manufacturer{" "}
        </option>
        {manufacturers
          .filter(manufacturer => manufacturer.country == country1)
          .map(manufacturer => (
            <option value={JSON.stringify(manufacturer)}>
              {manufacturer.name}
            </option>
          ))}
      </select>

      {oldManufacturer != 0 && (
        <form action="/changeOld" onSubmit={onSubmit}>
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
            Change Manufacturer
          </button>

          <button
            onClick={e =>
              mngrDelete({table: "Manufacturer", id: oldManufacturer.id})
            }
          >
            Delete Manufacturer
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
  changeOldManufacturer: changeOldManufacturer,
  mngrDelete: mngrDelete
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ChangeManufacturerCard);
