import axios from "axios";

export const auth = () => {
  return async dispatch => {
    const onSuccess = success => {
      console.log(success);
      dispatch({type: "AUTH", user: success.data});
      return success;
    };
    const onError = error => {
      dispatch({type: "AUTHERR", payload: error});
      return error;
    };
    try {
      let success = await axios.get("/login");
      return onSuccess(success) ;
    } catch (error) {
      return onError(error);
    }
  };
};
