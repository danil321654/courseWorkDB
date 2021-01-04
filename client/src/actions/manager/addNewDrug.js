import axios from "axios";

export const addNewDrug = drug => {
  return async dispatch => {
    const onSuccess = success => {
      console.log(success);
      dispatch({type: "ADDNEWDRUG", user: success.data, payload: "added"});
      return success;
    };
    const onError = error => {
      dispatch({type: "ADDNEWDRUGERROR", payload: error.response.data});
      return error;
    };
    try {
      console.log(drug);
      const success = await axios.post("/addNewDrug", drug);
      console.log(success);
      return onSuccess(success);
    } catch (error) {
      return onError(error);
    }
  };
};
