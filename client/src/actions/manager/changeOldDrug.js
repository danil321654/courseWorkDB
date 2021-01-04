import axios from "axios";

export const changeOldDrug = drug => {
  return async dispatch => {
    const onSuccess = success => {
      console.log(success);
      dispatch({type: "CHANGEOLDDRUG", user: success.data, payload: "added"});
      return success;
    };
    const onError = error => {
      dispatch({type: "CHANGEOLDDRUGERROR", payload: error.response.data});
      return error;
    };
    try {
      console.log(drug);
      const success = await axios.post("/changeOldDrug", drug);
      console.log(success);
      return onSuccess(success);
    } catch (error) {
      return onError(error);
    }
  };
};
