import axios from "axios";

export const changeOldCategory = category => {
  return async dispatch => {
    const onSuccess = success => {
      console.log(success);
      dispatch({
        type: "CHANGEOLDCATEGORY",
        user: success.data,
        payload: "added"
      });
      return success;
    };
    const onError = error => {
      dispatch({type: "CHANGEOLDCATEGORYERROR", payload: error.response.data});
      return error;
    };
    try {
      console.log(category);
      const success = await axios.post("/changeOldCategory", category);
      console.log(success);
      return onSuccess(success);
    } catch (error) {
      return onError(error);
    }
  };
};
