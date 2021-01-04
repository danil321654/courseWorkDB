import React, {Component, useState, useEffect} from "react";
import {BrowserRouter, Route, Redirect} from "react-router-dom";
import "./../../App.css";
import axios from "axios";
import {connect} from "react-redux";
import {createUseStyles} from "react-jss";

const useStyles = createUseStyles({
  imagesContainer: {
    width: "100%",
    height: "300px",
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
    justifyContent: "center"
  },
  imageCard: {
    color: "black",
    borderRadius: "10px",
    width: "300px",
    display: "flex",
    flexDirection: "row",
    justifyContent: "center",
    alignItems: "center"
  },
  image: {
    borderRadius: "10px",
    width: "300px"
  },
  arrow: {
    color: "black",
    fontSize: "2em",
    minWidth: "20%",
    height: "",
    zIndex: 1,
    display: "flex",
    flexDirection: "row",
    justifyContent: "center",
    alignItems: "center",
    backgroundColor: "white",
    borderRadius: "10px",
    color: "white",
    marginLeft: "auto",
    marginRight: "auto",
    paddingTop: "50%",
    paddingBottom: "50%"
  },
  wrapper: {
    width: "100px",
    margin: "0 auto"
  },
  row: {
    display: "flex",
    flexDirection: "row",
    width: "100%",
    alignItems: "center",
    justifyContent: "space-around"
  }
});

function Pictures({pictures}) {
  const classes = useStyles();
  const [pictureNum, setPictureNum] = useState(0);
  useEffect(() => {}, [pictureNum]);

  return (
    <div className={classes.imagesContainer}>
      {pictures.length > 0 &&
        pictures.map(picture => (
          <div className={classes.row}>
            <div className={classes.wrapper}>
              <div
                onClick={e =>
                  pictureNum > 0
                    ? setPictureNum(pictureNum - 1)
                    : setPictureNum(pictureNum)
                }
                className={classes.arrow}
              >
                <div>{"<-"}</div>
              </div>
            </div>

            <div className={classes.imageCard}>
              <img className={classes.image} src={`${picture.path}`} />
            </div>
            <div className={classes.wrapper}>
              <div
                onClick={e =>
                  pictureNum < pictures.length - 1
                    ? setPictureNum(pictureNum + 1)
                    : setPictureNum(pictureNum)
                }
                className={classes.arrow}
              >
                <div>{"->"}</div>
              </div>
            </div>
          </div>
        ))[pictureNum]}
    </div>
  );
}

export default Pictures;
