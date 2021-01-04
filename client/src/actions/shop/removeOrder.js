import axios from "axios";

export const removeOrder = order => {
  return async dispatch => {
    const onSuccess = success => {
      console.log(success);
      dispatch({type: "REMOVEORDER", user: success.data, payload: "ordered"});
      return success;
    };
    const onError = error => {
      dispatch({type: "REMOVEORDERERROR", payload: error.response.data});
      return error;
    };
    try {
      console.log(order);
      const success = await axios.post("/removeOrder", order);
      console.log(success);
      return onSuccess(success);
    } catch (error) {
      return onError(error);
    }
  };
};
