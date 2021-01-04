import React, {Component, useState} from "react";
import "./../../../App.css";
import axios from "axios";
import {connect} from "react-redux";
import {createUseStyles} from "react-jss";
import {completeOrder} from "./../../../actions/manager/completeOrder";
import {changeOrderStatus} from "./../../../actions/manager/changeOrderStatus";
import {removeOrder} from "./../../../actions/shop/removeOrder";
const useStyles = createUseStyles({
  card: {
    margin: 10,
    backgroundColor: "rgb(228, 199, 123)",
    display: "flex",
    flexDirection: "column",
    justifyItems: "space-around",
    alignItems: "center",
    padding: 10,
    color: "white",
    border: "black 2px",
    borderRadius: "5px",
    cursor: "pointer",
    width: "80vw"
  },
  rowCard: {
    margin: 5,
    backgroundColor: "red",
    display: "flex",
    flexDirection: "row",
    justifyContent: "space-between",
    padding: 5,
    color: "white",
    border: "black 2px",
    borderRadius: "5px",
    cursor: "pointer",
    width: "100%",
    boxSizing: "border-box"
  },
  row: {
    width: "100%",
    backgroundColor: "red",
    padding: "5px",
    paddingLeft: "20px",
    fontSize: "0.8em",
    borderRadius: "8px",
    margin: "5px"
  },

  textRow: {
    borderRadius: "8px",
    width: "100%",
    backgroundColor: "red",
    textAlign: "left",
    paddingLeft: "-30px",
    fontSize: "1.2em"
  },

  textRow: {
    borderRadius: "8px",
    width: "100%",
    backgroundColor: "red",
    textAlign: "left",
    paddingLeft: "-30px",
    fontSize: "1.2em"
  },
  image: {
    width: "100%"
  },
  button: {
    padding: "0 10px 0 10px",
    marginTop: "-15px"
  },

  button2: {
    padding: "0 10px 0 10px"
  }
});
function StockmanOrderCard({
  order,
  changeOrderStatus,
  removeOrder,
  completeOrder
}) {
  const classes = useStyles();
  const [expanded, toggleExpanded] = useState(false);
  const [paymentType, setPaymentType] = useState("card");
  const [sum, setSum] = useState(order.order_cost);
  console.log(order);
  return (
    <div className={classes.card}>
      <div className={classes.rowCard} onClick={e => toggleExpanded(!expanded)}>
        <div>Order №{order.id}</div>
        {expanded ? (
          <div className={classes.button}>ˬ</div>
        ) : (
          <div className={classes.button2}>›</div>
        )}
      </div>
      {expanded && (
        <div style={{width: "100%"}}>
          <div className={classes.row}>
            <div className={classes.rowCard}>
              <div className={classes.textRow}>Ordered drugs</div>
              <button
                disabled={
                  order.status == "completed" ||
                  order.status == "in delivery point"
                }
                onClick={e =>
                  changeOrderStatus({...order, status: "in delivery point"})
                }
              >
                confirm the arrival
              </button>
              <button
                disabled={order.status == "completed"}
                onClick={e => removeOrder(order)}
              >
                decline
              </button>
            </div>
            {order.items.map(item => (
              <div className={classes.row}>
                <div className={classes.rowCard}>
                  <div>Name</div>
                  <div>{item.name}</div>
                </div>
                <div className={classes.rowCard}>
                  <div>Quantity</div>
                  <div>{item.quantity}pcs</div>
                </div>
                <div className={classes.rowCard}>
                  <div>Cost</div>
                  <div>{item.full_price}$$</div>
                </div>
                {item.prescription && (
                  <div className={classes.rowCard}>
                    <div>Prescription</div>
                    <div>needed</div>
                  </div>
                )}
              </div>
            ))}
          </div>
          <div className={classes.row}>
            {order.delivery_pharmacy.name}
            <div>
              {order.delivery_pharmacy.city},{order.delivery_pharmacy.address}
            </div>
            <div></div>
          </div>
          <div className={classes.rowCard}>
            <div>Status</div>
            <div>{order.status}</div>
          </div>
          <div className={classes.rowCard}>
            <div>Full cost</div>
            <div>{order.order_cost}</div>
          </div>

          <div className={classes.rowCard}>
            <div>{`Credentials: ${order.client.surname} ${order.client.name} ${order.client.patronymic}`}</div>
            <div>{`Email: ${order.client.email} Phone: ${order.client.phone}`}</div>
          </div>

          {order.status == "in delivery point" && (
            <div className={classes.rowCard}>
              <select
                name="paymentType"
                defaultValue={paymentType}
                onChange={e => setPaymentType(e.target.value)}
              >
                <option value="cash">cash</option>
                <option value="card">card</option>
              </select>
              <input
                type="number"
                disabled={paymentType == "card"}
                value={sum}
                onChange={e => setSum(e.target.value)}
              />
              {paymentType == "cash" && (
                <div>
                  Change:{" "}
                  {sum - order.order_cost > 0 ? sum - order.order_cost : 0}$$$
                </div>
              )}
              <button
                disabled={sum < order.order_cost}
                onClick={e => {
                  completeOrder({
                    ...order,
                    paymentType: paymentType,
                    payed: sum,
                    status: "completed"
                  });
                }}
              >
                {" "}
                complete
              </button>
            </div>
          )}
        </div>
      )}
    </div>
  );
}

const mapDispatchToProps = {
  completeOrder: completeOrder,
  changeOrderStatus: changeOrderStatus,
  removeOrder: removeOrder
};

export default connect(null, mapDispatchToProps)(StockmanOrderCard);
