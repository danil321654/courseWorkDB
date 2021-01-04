import React, {Component, useState, useEffect} from "react";
import "./../../../App.css";
import axios from "axios";
import {connect} from "react-redux";
import {createUseStyles} from "react-jss";
import {changeOldDrug} from "./../../../actions/manager/changeOldDrug";
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
function ChangeDrugCard({
  shop,
  categories,
  drugs,
  allPictures,
  manufacturers,
  changeOldDrug,
  mngrDelete
}) {
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

  const [oldCategory, setOldCategory] = useState(0);
  const [drug, setDrug] = useState(0);

  useEffect(() => {
    setName(drug.name);
    setPrice(drug.price);
    setSingleWeight(drug.single_weight);
    setInStock(drug.in_stock);
    setActiveSubstance(drug.active_substance);
    setDescription(drug.description);
    togglePrescription(drug.prescription);
    setReleaseForm(drug.release_form);
    setCategory(oldCategory);
    setManufacturer(
      manufacturers.filter(man => man.id == drug.manufacturer_id)[0]
    );
    setPictures(
      allPictures.filter(pic => pic.drug_id == drug.id).map(pic => pic.path)
    );
  }, [drug]);

  const onSubmit = e => {
    e.preventDefault();
    if (category != 0 || manufacturer != 0)
      changeOldDrug({
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
        pictures,

        id: drug.id
      });
  };

  return (
    <div className={classes.card}>
      <select
        name="oldCategory"
        onChange={e => setOldCategory(JSON.parse(e.target.value))}
        value={JSON.stringify(oldCategory)}
      >
        <option value={0} disabled>
          choose category{" "}
        </option>

        <option value={1}>
          no category{" "}
        </option>
        {categories.map(category => (
          <option value={JSON.stringify(category)}>{category.name}</option>
        ))}
      </select>
      {oldCategory != 0 && (
        <select
          name="drug"
          onChange={e => setDrug(JSON.parse(e.target.value))}
          value={JSON.stringify(drug)}
        >
          <option value={0} disabled>
            choose drug{" "}
          </option>
          {drugs.length > 0 && oldCategory == 1
            ? drugs
                .filter(drug => !drug.category_id)
                .map(drug => (
                  <option value={JSON.stringify(drug)}>{drug.name}</option>
                ))
            : drugs
                .filter(drug => drug.category_id == oldCategory.id)
                .map(drug => (
                  <option value={JSON.stringify(drug)}>{drug.name}</option>
                ))}
        </select>
      )}

      {drug != 0 && (
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
              onChange={e => setDescription(e.target.value)}
              required
            >
              {description}
            </textArea>
          </div>

          <div className={classes.loginGrid}>
            <label htmlFor="pictures">Pictures (через перенос)</label>
            <textArea
              type="text"
              id="pictures"
              name="pictures"
              onChange={e => setPictures(e.target.value.split("\n"))}
              required
            >
              {pictures.join("\n")}
            </textArea>
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
                <option value={JSON.stringify(category)}>
                  {category.name}
                </option>
              ))}
            </select>
          </div>

          <div className={classes.loginGrid}>
            <label htmlFor="manufacturer">Manufacturer</label>
            <select
              name="manufacturer"
              onChange={e => setManufacturer(JSON.parse(e.target.value))}
              defaultValue={
                categories.filter(man => man.id == drug.manufacturer_id)[0]
              }
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
            Change Drug
          </button>

          <button onClick={e => mngrDelete({table: "Drug", id: drug.id})}>
            Delete Drug
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
  changeOldDrug: changeOldDrug,
  mngrDelete: mngrDelete
};

export default connect(mapStateToProps, mapDispatchToProps)(ChangeDrugCard);
