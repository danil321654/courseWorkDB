import axios from "axios";

export const rollBack = num => {
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
      console.log(num);
      const success = await axios.post("/rollBack", {num});
      console.log(success);
      return onSuccess(success);
    } catch (error) {
      return onError(error);
    }
  };
};
