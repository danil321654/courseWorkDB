import axios from "axios";

export const changeOldDeliveryPharmacy = deliveryPharmacy => {
  return async dispatch => {
    const onSuccess = success => {
      console.log(success);
      dispatch({type: "CHANGEOLDDELIVERYPHARMACY", user: success.data, payload: "added"});
      return success;
    };
    const onError = error => {
      dispatch({type: "CHANGEOLDDELIVERYPHARMACYERROR", payload: error.response.data});
      return error;
    };
    try {
      console.log(deliveryPharmacy);
      const success = await axios.post("/changeOldDeliveryPharmacy", deliveryPharmacy);
      console.log(success);
      return onSuccess(success);
    } catch (error) {
      return onError(error);
    }
  };
};
