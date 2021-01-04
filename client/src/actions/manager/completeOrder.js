import axios from "axios";

export const completeOrder = order => {
  return async dispatch => {
    const onSuccess = success => {
      console.log(success);
      dispatch({type: "COMPLETEORDER", user: success.data, payload: "completed"});
      return success;
    };
    const onError = error => {
      dispatch({type: "COMPLETEORDERERROR", payload: error.response.data});
      return error;
    };
    try {
      console.log(order);
      const success = await axios.post("/completeOrder", order);
      console.log(success);
      return onSuccess(success);
    } catch (error) {
      return onError(error);
    }
  };
};
