import axios from "axios";

export const removeFromBasket = item => {
  return {type: "REMOVEFROMBASKET", item: item};
};
