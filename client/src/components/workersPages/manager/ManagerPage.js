import React, {useState, useEffect} from "react";
import {BrowserRouter, Route, Redirect} from "react-router-dom";
import Login from "./../../auth/Login";
import Logout from "./../../auth/Logout";
import ManagerProfilePage from "./ManagerProfilePage";
import NewDrugCard from "./NewDrugCard";
import NewCategoryCard from "./NewCategoryCard";
import NewManufacturerCard from "./NewManufacturerCard";
import NewDeliveryPharmacyCard from "./NewDeliveryPharmacyCard";
import ChangeDrugCard from "./ChangeDrugCard";
import ChangeCategoryCard from "./ChangeCategoryCard";
import ChangeManufacturerCard from "./ChangeManufacturerCard";
import ChangeDeliveryPharmacyCard from "./ChangeDeliveryPharmacyCard";
import "./../../../App.css";
import axios from "axios";
import {connect} from "react-redux";
import {createUseStyles} from "react-jss";

import {FontAwesomeIcon} from "@fortawesome/react-fontawesome";
import fontawesome from "@fortawesome/fontawesome";
import {fas} from "@fortawesome/free-solid-svg-icons";
fontawesome.library.add(fas);

const useStyles = createUseStyles({
  Categories: {
    display: "flex",
    flexDirection: "row",
    justifyContent: "flex-start",
    textAlign: "left"
  },
  row: {
    display: "flex",
    flexDirection: "row",
    justifyContent: "space-around",
    flexWrap: "wrap"
  },
  button: {
    position: "fixed",
    top: "50px",
    left: 0
  }
});

function ManagerPage({shop, isAuthenticated}) {
  const classes = useStyles();
  const [goToProfile, goToProfilePage] = useState(false);
  const [curTab, changeCurTab] = useState("DRUG");

  const [categories, setCategories] = useState([]);
  const [manufacturers, setManufacturers] = useState([]);
  const [deliveryPharmacies, setDeliveryPharmacies] = useState([]);
  const [drugs, setDrugs] = useState([]);
  const [pictures, setPictures] = useState([]);

  useEffect(() => {
    axios.get("/categories").then(resp => setCategories(resp.data));
    axios
      .get("/deliverypharmacies")
      .then(resp => setDeliveryPharmacies(resp.data));
    axios.get("/home").then(resp => {
      console.log(resp.data);
      setDrugs(resp.data.items);
      setPictures(resp.data.pictures);
      setManufacturers(resp.data.manufacturers);
    });
  }, [shop, curTab]);

  return (
    <div>
      {!isAuthenticated && <Redirect to="/login" component={Login} />}
      {goToProfile && (
        <Redirect to="/managerProfilePage" component={ManagerProfilePage} />
      )}
      <button className={classes.button} onClick={e => goToProfilePage(true)}>
        <FontAwesomeIcon icon={fas.faUserAlt} />
      </button>
      <div>MANAGERS PAGE</div>
      <div className={classes.row}>
        <div onClick={e => changeCurTab("DRUG")}>Add/change drug</div>{" "}
        <div onClick={e => changeCurTab("CATEGORY")}>Add/change category</div>{" "}
        <div onClick={e => changeCurTab("MANUFACTURER")}>
          Add/change manufacturer
        </div>{" "}
        <div onClick={e => changeCurTab("DELIVERYPHARMACY")}>
          Add/change delivery pharmacy
        </div>{" "}
      </div>
      {curTab == "DRUG" && (
        <div className={classes.row}>
          <NewDrugCard
            categories={categories}
            manufacturers={manufacturers}
            drugs={drugs}
          />
          <ChangeDrugCard
            categories={categories}
            manufacturers={manufacturers}
            drugs={drugs}
            allPictures={pictures}
          />
        </div>
      )}

      {curTab == "CATEGORY" && (
        <div className={classes.row}>
          {" "}
          <NewCategoryCard categories={categories} />
          <ChangeCategoryCard categories={categories} />
        </div>
      )}
      {curTab == "MANUFACTURER" && (
        <div className={classes.row}>
          <NewManufacturerCard />
          <ChangeManufacturerCard manufacturers={manufacturers} />
        </div>
      )}

      {curTab == "DELIVERYPHARMACY" && (
        <div className={classes.row}>
          <NewDeliveryPharmacyCard />
          <ChangeDeliveryPharmacyCard deliveryPharmacies={deliveryPharmacies} />
        </div>
      )}

      <Logout />
    </div>
  );
}

const mapStateToProps = state => {
  return {
    isAuthenticated: state.auth.isAuthenticated,
    shop: state.shop
  };
};

export default connect(mapStateToProps, null)(ManagerPage);
