import axios from "axios";

export const changeOrderStatus = order => {
  return async dispatch => {
    const onSuccess = success => {
      console.log(success);
      dispatch({type: "CHANGEORDER", user: success.data, payload: "approved"});
      return success;
    };
    const onError = error => {
      dispatch({type: "CHANGEORDERERROR", payload: error.response.data});
      return error;
    };
    try {
      console.log(order);
      const success = await axios.post("/manageOrder", order);
      console.log(success);
      return onSuccess(success);
    } catch (error) {
      return onError(error);
    }
  };
};
