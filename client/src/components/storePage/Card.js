import React, {Component, useState} from "react";
import "./../../App.css";
import axios from "axios";
import {connect} from "react-redux";
import {createUseStyles} from "react-jss";
import {addToBasket} from "./../../actions/shop/addToBasket";
import {FontAwesomeIcon} from "@fortawesome/react-fontawesome";
import fontawesome from "@fortawesome/fontawesome";
import {fas} from "@fortawesome/free-solid-svg-icons";

import Pictures from "./Pictures";
fontawesome.library.add(fas);
const useStyles = createUseStyles({
  card: {
    margin: 10,
    backgroundColor: "white",
    color: "white",
    border: "black 2px",
    borderRadius: "2px",
    cursor: "pointer",
    width: "500px",
    height: "min-content",
    display: "flex",
    flexDirection: "column",
    justifyContent: "space-between",
    alignItems: "center",
    boxSizing: "border-box"
  },
  imagesContainer: {
    width: "100%",
    height: "300px",
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
    justifyContent: "center"
  },
  imageCard: {
    borderRadius: "10px",
    width: "300px",
    display: "flex",
    flexDirection: "row",
    justifyContent: "center"
  },
  image: {
    borderRadius: "10px",
    width: "300px"
  },
  rowCard: {
    backgroundColor: "rgb(228, 199, 123)",
    display: "flex",
    flexDirection: "row",
    justifyContent: "space-between",
    padding: 5,
    color: "white",
    border: "black 2px",
    borderRadius: "2px",
    cursor: "pointer",
    width: "100%",
    boxSizing: "border-box"
  },
  row: {
    width: "100%",
    backgroundColor: "rgb(228, 199, 123)",
    paddingLeft: "20px",
    paddingRight: "10px",
    paddingBottom: "20px",
    fontSize: "0.8em",
    borderRadius: "2px"
  },

  textRow: {
    borderRadius: "8px",
    width: "100%",
    backgroundColor: "rgb(228, 199, 123)",
    textAlign: "left",
    fontSize: "1.2em"
  }
});
function Card({item, pictures, addToBasket}) {
  const [descriptionExpanded, toggleDescriptionExpanded] = useState(false);
  const classes = useStyles();
  console.log(item);
  return (
    <div className={classes.card}>
      <Pictures pictures={pictures} />
      <div className={classes.row}>
        <div className={classes.rowCard}>
          <div>Name</div>
          <div>{item.name}</div>
        </div>
        <div className={classes.rowCard}>
          <div>Price</div>
          <div>{item.price}$$</div>
        </div>

        <div className={classes.rowCard}>
          <div>Active substance</div>
          <div>{item.active_substance}</div>
        </div>

        <div className={classes.rowCard}>
          <div>Release form</div>
          <div>{`${item.release_form}*${item.single_weight}mg`}</div>
        </div>
        {item.prescription && (
          <div className={classes.rowCard}>
            <div>Prescription</div>
            <div>needed</div>
          </div>
        )}

        <div className={classes.rowCard}>
          <div>In stock</div>
          <div>{item.in_stock}pcs</div>
        </div>

        <div className={classes.rowCard}>
          <div>Manufacturer</div>
          <div>{`${item.manufacturer.name}(${item.manufacturer.country})`}</div>
        </div>

        <div
          className={classes.rowCard}
          onClick={e => toggleDescriptionExpanded(!descriptionExpanded)}
        >
          <div>Description</div>
          <div>click to show</div>
        </div>
        <div className={classes.rowCard}>
          {descriptionExpanded && item.description}
        </div>
        <button disabled={item.in_stock < 1} onClick={e => addToBasket(item)}>
          <FontAwesomeIcon icon={fas.faShoppingBasket} />
        </button>
      </div>
    </div>
  );
}

const mapDispatchToProps = {
  addToBasket: addToBasket
};

export default connect(null, mapDispatchToProps)(Card);
