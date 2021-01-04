import axios from "axios";

export const order = order => {
  return async dispatch => {
    const onSuccess = success => {
      console.log(success);
      dispatch({type: "ORDER", user: success.data, payload: "ordered"});
      return success;
    };
    const onError = error => {
      dispatch({type: "ORDERERROR", payload: error.response.data});
      return error;
    };
    try {
      console.log(order);
      const success = await axios.post("/order", order);
      console.log(success);
      return onSuccess(success);
    } catch (error) {
      return onError(error);
    }
  };
};
