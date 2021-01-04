import axios from "axios";

export const deleteAccount = account => {
  return async dispatch => {
    const onSuccess = success => {
      console.log(success);
      dispatch({type: "DELETEACCOUNT", user: success.data});
      return success;
    };
    const onError = error => {
      dispatch({type: "DELETEACCOUNTERROR"});
      return error;
    };
    try {
      console.log(account);
      const success = await axios.post("/deleteaccount", account);
      console.log(success);
      return onSuccess(success);
    } catch (error) {
      return onError(error);
    }
  };
};
