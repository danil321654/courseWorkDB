import React, {Component, useState, useEffect} from "react";
import "./../../../App.css";
import axios from "axios";
import {connect} from "react-redux";
import {createUseStyles} from "react-jss";
import {changeOldCategory} from "./../../../actions/manager/changeOldCategory";
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
    height: "min-content",
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
function ChangeCategoryCard({shop, categories, changeOldCategory, mngrDelete}) {
  const classes = useStyles();

  //new drug info
  const [name, setName] = useState("");
  const [category, setCategory] = useState(0);

  const [oldCategory, setOldCategory] = useState(0);

  useEffect(() => {
    setName(oldCategory.name);
    setCategory(categories.filter(man => man.id == oldCategory.parent)[0]);
  }, [oldCategory, categories]);

  const onSubmit = e => {
    e.preventDefault();
    if (category != 0)
      changeOldCategory({
        name,
        category,
        id: oldCategory.id
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
        {categories.map(category => (
          <option value={JSON.stringify(category)}>{category.name}</option>
        ))}
      </select>

      {oldCategory != 0 && (
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
                <option value={JSON.stringify(category)}>
                  {category.name}
                </option>
              ))}
            </select>
          </div>
          <button type="submit" onClick={e => onSubmit(e)}>
            Change Category
          </button>

          <button
            onClick={e => mngrDelete({table: "Category", id: oldCategory.id})}
          >
            Delete Category
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
  changeOldCategory: changeOldCategory,
  mngrDelete: mngrDelete
};

export default connect(mapStateToProps, mapDispatchToProps)(ChangeCategoryCard);
