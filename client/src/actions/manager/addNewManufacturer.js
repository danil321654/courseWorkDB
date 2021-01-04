import axios from "axios";

export const addNewManufacturer = manufacturer => {
  return async dispatch => {
    const onSuccess = success => {
      console.log(success);
      dispatch({type: "ADDNEWMANUFACTURER", user: success.data, payload: "added"});
      return success;
    };
    const onError = error => {
      dispatch({type: "ADDNEWMANUFACTURERERROR", payload: error.response.data});
      return error;
    };
    try {
      console.log(manufacturer);
      const success = await axios.post("/addNewManufacturer", manufacturer);
      console.log(success);
      return onSuccess(success);
    } catch (error) {
      return onError(error);
    }
  };
};
