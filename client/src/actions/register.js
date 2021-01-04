import axios from "axios";

export const register = user => {
  return async dispatch => {
    const onSuccess = (success) => {
      console.log(success);
      dispatch({type: 'REGISTER', payload: success.data});
      return success;
    }
    const onError = (error) => {
      dispatch({type: 'REGERROR', payload: error.response.data.detail});
      return error;
    }
    try {
      const success = await axios.post("/register", user);
      console.log(success);
      return onSuccess(success);
    } catch (error) {
      return onError(error);
    }
  };
};
