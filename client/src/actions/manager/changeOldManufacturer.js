import axios from "axios";

export const changeOldManufacturer = manufacturer => {
  return async dispatch => {
    const onSuccess = success => {
      console.log(success);
      dispatch({type: "CHANGEOLDMANUFACTURER", user: success.data, payload: "added"});
      return success;
    };
    const onError = error => {
      dispatch({type: "CHANGEOLDMANUFACTURERERROR", payload: error.response.data});
      return error;
    };
    try {
      console.log(manufacturer);
      const success = await axios.post("/changeOldManufacturer", manufacturer);
      console.log(success);
      return onSuccess(success);
    } catch (error) {
      return onError(error);
    }
  };
};
