import axios from "axios";

export const mngrDelete = item => {
  return async dispatch => {
    const onSuccess = success => {
      console.log(success);
      dispatch({type: "MNGRDELETE", user: success.data});
      return success;
    };
    const onError = error => {
      dispatch({type: "MNGRDELETEERROR"});
      return error;
    };
    try {
      console.log(item);
      const success = await axios.post("/mngrdelete", item);
      console.log(success);
      return onSuccess(success);
    } catch (error) {
      return onError(error);
    }
  };
};
