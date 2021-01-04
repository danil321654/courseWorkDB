import React, {Component, useState, useEffect} from "react";
import axios from "axios";
import {connect} from "react-redux";
import {createUseStyles} from "react-jss";
import {deleteAccount} from "./../../../actions/manager/deleteAccount";
import {changeAccountRole} from "./../../../actions/manager/changeAccountRole";

const useStyles = createUseStyles({
  card: {
    margin: 5,
    display: "grid",
    gridTemplateColumns: "1fr 1fr 1fr min-content",
    justifyContent: "space-between",
    backgroundColor: "green",
    padding: 3,
    color: "white",
    border: "black 2px",
    borderRadius: "5px",
    cursor: "pointer",
    minWidth: "600px",
    textAlign: "center"
  },
  buttonsGrid: {
    margin: 5,
    display: "grid",
    gridTemplateColumns: "max-content max-content",
    gridTemplateRows: "min-content min-content",
    gridGap: "10px",
    justifyContent: "space-around",
    alignItems: "space-around",
    cursor: "pointer"
  },
  column: {
    display: "flex",
    flexDirection: "column"
  }
});
function AdminAccountRow({
  shop,
  account,
  curUser,
  deleteAccount,
  changeAccountRole
}) {
  const [deliveryPharmacies, setDeliveryPharmacies] = useState([]);
  const [deliveryPharmacy, setDeliveryPharmacy] = useState(0);
  const [deliveryWarn, toggleDeliveryWarn] = useState(true);
  const [city1, setCity1] = useState(0);
  const classes = useStyles();
  console.log(curUser);
  useEffect(() => {
    axios
      .get("/deliverypharmacies")
      .then(resp => setDeliveryPharmacies(resp.data))
      .catch(err => console.log(err));
  }, [shop]);
  return (
    <div className={classes.card}>
      <div>{`${account.surname ? account.surname : ""} ${account.name} ${
        account.patronymic ? account.patronymic : ""
      }  ${
        account.delivery_pharmacy_id && deliveryPharmacies.length > 0
          ? `${
              deliveryPharmacies.filter(
                x => x.id == account.delivery_pharmacy_id
              )[0].city
            }(${
              deliveryPharmacies.filter(
                x => x.id == account.delivery_pharmacy_id
              )[0].address
            })`
          : ""
      }`}</div>

      <div>{account.login}</div>

      <div>{account.email}</div>

      {account.role ? (
        <div className={classes.buttonsGrid}>
          {account.role != "CLIENT" && (
            <button
              onClick={e => changeAccountRole({...account, role: "Client"})}
              disabled={account.id == curUser.id}
            >
              make client
            </button>
          )}
          {account.role != "MANAGER" && (
            <button
              onClick={e => changeAccountRole({...account, role: "Manager"})}
              disabled={account.id == curUser.id}
            >
              make manager
            </button>
          )}
          {account.role != "STOCKMAN" && (
            <div className={classes.column}>
              <button
                onClick={e =>
                  changeAccountRole({
                    ...account,
                    role: "Stockman",
                    delivery_pharmacy_id: deliveryPharmacy.id
                  })
                }
                disabled={account.id == curUser.id || deliveryWarn}
              >
                make stockman
              </button>
              <select
                name="city1"
                onChange={e => {
                  setCity1(e.target.value);
                  setDeliveryPharmacy(0);
                  document.getElementById(
                    "select delivery pharmacy"
                  ).selectedIndex = 0;
                }}
                
                value={city1}
              >
                <option value={0} disabled>
                  choose city{" "}
                </option>
                {Array.from(new Set(deliveryPharmacies)).map(
                  deliveryPharmacy => (
                    <option value={deliveryPharmacy.city}>
                      {deliveryPharmacy.city}
                    </option>
                  )
                )}
              </select>
              <select
                disabled={account.id == curUser.id}
                name="delivery pharmacy"
                id="select delivery pharmacy"
                onChange={e => {
                  toggleDeliveryWarn(false);
                  console.log(JSON.parse(e.target.value));
                  setDeliveryPharmacy(JSON.parse(e.target.value));
                }}
                defaultValue={deliveryPharmacy}
              >
                <option value={0} disabled selected>
                  point
                </option>
                {deliveryPharmacies
                  .filter(deliveryPharmacy => deliveryPharmacy.city == city1)
                  .map(delPharm => (
                    <option value={JSON.stringify(delPharm)}>
                      {delPharm.address}({delPharm.name})
                    </option>
                  ))}
              </select>
            </div>
          )}
          {account.role != "ADMIN" && (
            <button
              onClick={e => changeAccountRole({...account, role: "Admin"})}
              disabled={account.id == curUser.id}
            >
              make admin
            </button>
          )}
          <button
            onClick={e => deleteAccount(account)}
            disabled={account.id == curUser.id}
          >
            remove account
          </button>
        </div>
      ) : (
        <div className={classes.buttonsGrid}>
          <button
            style={{opacity: 0, height: 0}}
            disabled={true}
            onClick={e => {}}
          >
            remove account
          </button>
          <button
            style={{opacity: 0, height: 0}}
            disabled={true}
            onClick={e => {}}
          >
            remove account
          </button>
          <button
            style={{opacity: 0, height: 0}}
            disabled={true}
            onClick={e => {}}
          >
            remove account
          </button>
          <button
            style={{opacity: 0, height: 0}}
            disabled={true}
            onClick={e => {}}
          >
            remove account
          </button>
        </div>
      )}
    </div>
  );
}

const mapStateToProps = state => {
  return {
    shop: state.shop,
    curUser: state.auth.user
  };
};

const mapDispatchToProps = {
  changeAccountRole: changeAccountRole,
  deleteAccount: deleteAccount
};

export default connect(mapStateToProps, mapDispatchToProps)(AdminAccountRow);
