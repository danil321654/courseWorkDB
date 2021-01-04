import axios from "axios";

export const login = user => {
  return async dispatch => {
    const onSuccess = success => {
      console.log(success);
      dispatch({type: "LOGIN", user: success.data, payload: "logged"});
      return success;
    };
    const onError = error => {
      dispatch({type: "LOGERROR", payload: error.response.data});
      return error;
    };
    try {
      const success = await axios.post("/login", user);
      console.log(success);
      return onSuccess(success);
    } catch (error) {
      return onError(error);
    }
  };
};
