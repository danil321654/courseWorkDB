import React, {Component, useState, useEffect, useReducer} from "react";
import "./../../../App.css";
import axios from "axios";
import {connect} from "react-redux";
import {createUseStyles} from "react-jss";
import {addNewCategory} from "./../../../actions/manager/addNewCategory";
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
function NewCategoryCard({shop, categories, addNewCategory}) {
  const classes = useStyles();

  //new drug info
  const [name, setName] = useState("");
  const [category, setCategory] = useState(0);

  const [, forceUpdate] = useReducer(x => x + 1, 0);

  useEffect(() => forceUpdate(), [shop, categories]);

  const onSubmit = e => {
    if (category != 0)
      addNewCategory({
        name,
        category
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
        <label htmlFor="category">Parent category</label>
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
      <button type="submit" onClick={e => onSubmit(e)}>
        Add Category
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
  addNewCategory: addNewCategory
};

export default connect(mapStateToProps, mapDispatchToProps)(NewCategoryCard);
