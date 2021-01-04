import React, {Component, useState, useEffect} from "react";
import {BrowserRouter, Route, Redirect} from "react-router-dom";
import "./../../App.css";
import axios from "axios";
import {connect} from "react-redux";
import Card from "./Card";
import {createUseStyles} from "react-jss";

const useStyles = createUseStyles({
  Cards: {
    display: "flex",
    flexDirection: "row",
    justifyContent: "space-around",
    flexWrap: "wrap"
  }
});

function Cards({categoryId, isAuthenticated, shop}) {
  const classes = useStyles();
  const [items, setItems] = useState([]);
  const [pictures, setPictures] = useState([]);
  const [manufacturers, setManufacturers] = useState([]);
  useEffect(() => {
    axios
      .get("/home")
      .then(resp => {
        console.log(resp.data);
        setItems(resp.data.items);
        setPictures(resp.data.pictures);
        setManufacturers(resp.data.manufacturers);
      })
      .catch(err => console.log(err));
  }, [shop]);

  return (
    <div className={classes.Cards}>
      {items
        .filter(item => item.category_id == categoryId)
        .map(item => (
          <Card
            item={{
              ...item,
              manufacturer:
                manufacturers.length > 0
                  ? manufacturers.filter(
                      manufacturer => manufacturer.id == item.manufacturer_id
                    )[0]
                  : []
            }}
            pictures={pictures.filter(picture => picture.drug_id == item.id)}
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

export default connect(mapStateToProps, null)(Cards);
