import axios from "axios";

export const logout = (user) => {
  return async dispatch => {
    const onSuccess = (success) => {
      console.log(success);
      dispatch({type: 'LOGOUT', payload: success.data});
      return success;
    }
    const onError = (error) => {
      dispatch({type: 'LOGERROR', payload: error});
      return error;
    }
    try {
      console.log("eee");
      const success = await axios.delete("/logout");
      console.log(success);
      return onSuccess(success);
    } catch (error) {
      return onError(error);
    }
  };
};
