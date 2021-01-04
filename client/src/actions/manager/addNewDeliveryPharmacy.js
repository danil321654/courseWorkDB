import axios from "axios";

export const addNewDeliveryPharmacy = deliveryPharmacy => {
  return async dispatch => {
    const onSuccess = success => {
      console.log(success);
      dispatch({
        type: "ADDNEWDELIVERYPHARMACY",
        user: success.data,
        payload: "added"
      });
      return success;
    };
    const onError = error => {
      dispatch({
        type: "ADDNEWDELIVERYPHARMACYERROR",
        payload: error.response.data
      });
      return error;
    };
    try {
      console.log(deliveryPharmacy);
      const success = await axios.post(
        "/addNewDeliveryPharmacy",
        deliveryPharmacy
      );
      console.log(success);
      return onSuccess(success);
    } catch (error) {
      return onError(error);
    }
  };
};
