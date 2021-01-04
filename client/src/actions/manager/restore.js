import axios from "axios";

export const restore = () => {
  return async dispatch => {
    const onSuccess = success => {
      console.log(success);
      dispatch({type: "ROLLBACK", user: success.data});
      return success;
    };
    const onError = error => {
      dispatch({type: "ROLLBACKERROR"});
      return error;
    };
    try {
      const success = await axios.post("/restore");
      console.log(success);
      return onSuccess(success);
    } catch (error) {
      return onError(error);
    }
  };
};
