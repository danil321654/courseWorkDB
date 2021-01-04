import React, {Component, useState, useEffect} from "react";
import {BrowserRouter, Route, Redirect} from "react-router-dom";
import Cards from "./Cards";
import Basket from "./Basket";
import Logout from "./../auth/Logout";
import "./../../App.css";
import axios from "axios";
import {connect} from "react-redux";
import {createUseStyles} from "react-jss";
import {selectCategory} from "./../../actions/shop/selectCategory";

const useStyles = createUseStyles({
  Category: {
    textAlign: "left",
    position: "sticky"
  }
});

function Category({categoryInfo, selectCategory}) {
  const classes = useStyles();
  const [children, setChildren] = useState([]);
  const [expanded, toggleExpanded] = useState(!categoryInfo.parent);
  useEffect(() => {
    setChildren(
      categoryInfo.categories.length > 0
        ? categoryInfo.categories.filter(
            childCategory => childCategory.parent == categoryInfo.id
          )
        : []
    );
  }, []);
  console.log(categoryInfo);

  return (
    <div className={classes.Category}>
      <div
        onClick={e => {
          toggleExpanded(!expanded);
          selectCategory(categoryInfo.name);
        }}
        style={{
          marginLeft: `${20 * categoryInfo.paragraph}px`,
          border: "1px solid white"
        }}
      >
        {`${" ".repeat(categoryInfo.paragraph)}`}
        {" " + (categoryInfo.parent ? "- " : "") + categoryInfo.name}
      </div>
      {expanded &&
        children.length > 0 &&
        children.map(childCategory => (
          <Category
            categoryInfo={{
              ...childCategory,
              categories: categoryInfo.categories.filter(
                ctgr => ctgr.id != categoryInfo.id
              ),
              paragraph: categoryInfo.paragraph + 1
            }}
            selectCategory={selectCategory}
          />
        ))}
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
  selectCategory: selectCategory
};

export default connect(mapStateToProps, mapDispatchToProps)(Category);
