import React, {useState, useEffect} from "react";
import {BrowserRouter, Route, Redirect} from "react-router-dom";
import Cards from "./Cards";
import Login from "./../auth/Login";
import Logout from "./../auth/Logout";
import Basket from "./Basket";
import Category from "./Category";
import ProfilePage from "./../profilePage/ProfilePage";
import "./../../App.css";
import axios from "axios";
import {connect} from "react-redux";
import {createUseStyles} from "react-jss";
import {selectCategory} from "./../../actions/shop/selectCategory";

import {FontAwesomeIcon} from "@fortawesome/react-fontawesome";
import fontawesome from "@fortawesome/fontawesome";
import {fas} from "@fortawesome/free-solid-svg-icons";
fontawesome.library.add(fas);

const useStyles = createUseStyles({
  Categories: {
    display: "flex",
    flexDirection: "row",
    justifyContent: "flex-start",
    textAlign: "left",
    position: "fixed",
    top: "30px"
  },
  CatDrugs: {
    display: "grid",
    gridTemplateColumns: "2fr 3fr"
  },
  Category: {
    position: "fixed",
    top: 0
  },
  button: {
    position: "fixed",
    top: "50px",
    left: 0
  }
});

function StorePage({shop, isAuthenticated, selectCategory}) {
  const classes = useStyles();
  const [categories, setCategories] = useState([]);
  const [goToProfile, goToProfilePage] = useState(false);

  useEffect(() => {
    axios
      .get("/categories")
      .then(resp => {
        console.log(resp.data);
        setCategories(resp.data);
      })
      .catch(err => console.log(err));
  }, []);

  return (
    <div>
      <Logout />
      <Basket />
      {!isAuthenticated && <Redirect to="/login" component={Login} />}
      {goToProfile && <Redirect to="/profile" component={ProfilePage} />}
      <button
        className={classes.button}
        onClick={e => {
          goToProfilePage(true);
          selectCategory("all");
        }}
      >
        <FontAwesomeIcon icon={fas.faUserAlt}/>
      </button>
      <div className={classes.CatDrugs}>
        <div className={classes.Categories}>
          {categories.length > 0 && (
            <Category
              categoryInfo={{
                ...categories.filter(category => !category.parent)[0],
                categories: categories.filter(category => category.parent),
                paragraph: 0
              }}
            />
          )}
        </div>
        <div></div>
        {categories.filter(category => category.name == shop.selectedCategory)
          .length > 0 && (
          <Cards
            categoryId={
              categories.filter(
                category => category.name == shop.selectedCategory
              )[0].id
            }
          />
        )}
      </div>
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

export default connect(mapStateToProps, mapDispatchToProps)(StorePage);
