import React, {Component, useState, useEffect, useReducer} from "react";
import "./../../../App.css";
import axios from "axios";
import {connect} from "react-redux";
import {createUseStyles} from "react-jss";
import {addNewDrug} from "./../../../actions/manager/addNewDrug";
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
function NewDrugCard({shop, categories, drugs, manufacturers, addNewDrug}) {
  const classes = useStyles();

  //new drug info
  const [name, setName] = useState("");
  const [price, setPrice] = useState(0);
  const [single_weight, setSingleWeight] = useState(0);
  const [in_stock, setInStock] = useState(0);
  const [active_substance, setActiveSubstance] = useState("");
  const [description, setDescription] = useState("");
  const [prescription, togglePrescription] = useState(false);
  const [release_form, setReleaseForm] = useState("");
  const [category, setCategory] = useState(0);
  const [manufacturer, setManufacturer] = useState(0);
  const [pictures, setPictures] = useState([]);

  const [, forceUpdate] = useReducer(x => x + 1, 0);

  useEffect(() => forceUpdate(), [
    shop,
    categories,
    drugs
  ]);

  const onSubmit = e => {
    if (category != 0 && manufacturer != 0)
      addNewDrug({
        name,
        price,
        active_substance,
        release_form,
        prescription,
        single_weight,
        in_stock,
        description,
        category,
        manufacturer,
        pictures
      });
  };

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
          <label htmlFor="price">Price</label>
          <input
            type="number"
            id="price"
            name="price"
            value={price}
            onChange={e => {
              if (e.target.value >= 0) setPrice(e.target.value);
            }}
            required
          />
        </div>

        <div className={classes.loginGrid}>
          <label htmlFor="active_substance">Description</label>
          <textArea
            type="text"
            id="description"
            name="description"
            value={description}
            onChange={e => setDescription(e.target.value)}
            required
          />
        </div>

        <div className={classes.loginGrid}>
          <label htmlFor="pictures">Pictures (через перенос)</label>
          <textArea
            type="text"
            id="pictures"
            name="pictures"
            value={pictures.join("\n")}
            onChange={e => setPictures(e.target.value.split("\n"))}
            required
          />
        </div>
        <div className={classes.loginGrid}>
          <label htmlFor="active_substance">Active substance</label>
          <input
            type="text"
            id="active_substance"
            name="active_substance"
            value={active_substance}
            onChange={e => setActiveSubstance(e.target.value)}
            required
          />
        </div>
        <div className={classes.loginGrid}>
          <label htmlFor="prescription">Prescription</label>
          <input
            type="checkbox"
            id="prescription"
            name="prescription"
            checked={prescription}
            onChange={e => togglePrescription(!prescription)}
          />
        </div>
        <div className={classes.loginGrid}>
          <label htmlFor="in_stock">In stock</label>
          <input
            type="number"
            id="in_stock"
            name="in_stock"
            value={in_stock}
            onChange={e => {
              if (e.target.value >= 0) setInStock(e.target.value);
            }}
            required
          />
        </div>

        <div className={classes.loginGrid}>
          <label htmlFor="release_form">Release form</label>
          <input
            type="text"
            id="release_form"
            name="release_form"
            value={release_form}
            onChange={e => setReleaseForm(e.target.value)}
            required
          />
        </div>
        <div className={classes.loginGrid}>
          <label htmlFor="single_weight">Single dose(mg)</label>
          <input
            type="number"
            id="single_weight"
            name="single_weight"
            value={single_weight}
            onChange={e => {
              if (e.target.value >= 0) setSingleWeight(e.target.value);
            }}
            required
          />
        </div>

        <div className={classes.loginGrid}>
          <label htmlFor="category">Category</label>
          <select
            name="category"
            onChange={e => setCategory(JSON.parse(e.target.value))}
            defaultValue={category}
          >
            <option value={0} disabled>
              choose category{" "}
            </option>
            {categories.map(category => (
              <option value={JSON.stringify(category)}>{category.name}</option>
            ))}
          </select>
        </div>

        <div className={classes.loginGrid}>
          <label htmlFor="manufacturer">Manufacturer</label>
          <select
            name="manufacturer"
            onChange={e => setManufacturer(JSON.parse(e.target.value))}
            defaultValue={manufacturer}
          >
            <option value={0} disabled>
              choose manufacturer{" "}
            </option>
            {manufacturers.map(manufacturer => (
              <option
                value={JSON.stringify(manufacturer)}
              >{`${manufacturer.name}(${manufacturer.country})`}</option>
            ))}
          </select>
        </div>
        <button type="submit" onClick={e => onSubmit(e)}>
          Add Drug to Catalog
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
  addNewDrug: addNewDrug
};

export default connect(mapStateToProps, mapDispatchToProps)(NewDrugCard);
