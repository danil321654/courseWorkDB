import axios from "axios";

export const addNewCategory = category => {
  return async dispatch => {
    const onSuccess = success => {
      console.log(success);
      dispatch({type: "ADDNEWCATEGORY", user: success.data, payload: "added"});
      return success;
    };
    const onError = error => {
      dispatch({type: "ADDNEWCATEGORYERROR", payload: error.response.data});
      return error;
    };
    try {
      console.log(category);
      const success = await axios.post("/addNewCategory", category);
      console.log(success);
      return onSuccess(success);
    } catch (error) {
      return onError(error);
    }
  };
};
