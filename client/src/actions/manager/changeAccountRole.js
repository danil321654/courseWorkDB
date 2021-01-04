import axios from "axios";

export const changeAccountRole = account => {
  return async dispatch => {
    const onSuccess = success => {
      console.log(success);
      dispatch({type: "CHANGEACCOUNTROLE", user: success.data});
      return success;
    };
    const onError = error => {
      dispatch({type: "CHANGEACCOUNTROLEERROR"});
      return error;
    };
    try {
      console.log(account);
      const success = await axios.post("/changeaccountrole", account);
      console.log(success);
      return onSuccess(success);
    } catch (error) {
      return onError(error);
    }
  };
};
