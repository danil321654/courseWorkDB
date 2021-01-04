import React, {Component, useState} from "react";
import "./../../App.css";
import axios from "axios";
import {connect} from "react-redux";
import {createUseStyles} from "react-jss";
import {removeFromBasket} from "./../../actions/shop/removeFromBasket";
import {changeQuantity} from "./../../actions/shop/changeQuantity";
import {FontAwesomeIcon} from "@fortawesome/react-fontawesome";
import fontawesome from "@fortawesome/fontawesome";
import {fas} from "@fortawesome/free-solid-svg-icons";

fontawesome.library.add(fas);

const useStyles = createUseStyles({
  card: {
    margin: 5,
    display: "flex",
    justifyContent: "space-between",
    alignItems: "center",
    backgroundColor: "green",
    padding: 3,
    color: "white",
    border: "black 2px",
    borderRadius: "5px",
    cursor: "pointer",
    minWidth: "600px"
  },
  quantity: {
    display: "flex",
    flexDirection: "column",
    justifyContent: "center",
    alignItems: "center"
  },
  quantDiv: {
    width: "100%",
    textAlign: "center",
    height: "40px"
  }
});
function BasketCard({item, removeFromBasket, changeQuantity}) {
  const classes = useStyles();
  console.log(item);
  return (
    <div className={classes.card}>
      <div>{item.name}</div>
      <div className={classes.quantity}>
        <div
          className={classes.quantDiv}
          onClick={e => changeQuantity({...item, quantity: item.quantity + 1})}
        >
          <FontAwesomeIcon icon={fas.faSortUp} />
        </div>
        <div>{item.quantity}pcs</div>
        <div
          className={classes.quantDiv}
          onClick={e => changeQuantity({...item, quantity: item.quantity - 1})}
        >
          <FontAwesomeIcon icon={fas.faSortDown} />
        </div>
      </div>

      <div>{item.fullPrice}$$</div>

      <button onClick={e => removeFromBasket(item)}>
        <FontAwesomeIcon icon={fas.faTrash} />
      </button>
    </div>
  );
}

const mapDispatchToProps = {
  removeFromBasket: removeFromBasket,
  changeQuantity: changeQuantity
};

export default connect(null, mapDispatchToProps)(BasketCard);
