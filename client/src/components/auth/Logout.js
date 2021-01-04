import React, {useState, useEffect} from "react";

import {connect} from "react-redux";
import {logout} from "../../actions/logout";
import {createUseStyles} from "react-jss";
import StorePage from "./../storePage/StorePage";
import {FontAwesomeIcon} from "@fortawesome/react-fontawesome";
import fontawesome from "@fortawesome/fontawesome";
import {fas} from "@fortawesome/free-solid-svg-icons";
fontawesome.library.add(fas);

const useStyles = createUseStyles({
  Logout: {
    position: "fixed",
    top: 0,
    left: 0
  }
});
const Logout = ({logout}) => {
  const classes = useStyles();
  return (
    <React.Fragment>
      <button
        onClick={e => {
          console.log("bebebe");
          logout();
        }}
        className={classes.Logout}
      >
        <FontAwesomeIcon icon={fas.faSignOutAlt} />
      </button>
    </React.Fragment>
  );
};

export default connect(null, {logout})(Logout);
