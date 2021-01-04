//import {data} from './../../download.js';
let initialState = {
  basketItems: [],
  ordError: "",
  managerLog: "",
  selectedCategory: "All"
};

export const shopReducer = (state = initialState, action) => {
  switch (action.type) {
    case "ADDTOBASKET":
      if (
        state.basketItems.filter(basketItem => basketItem.id == action.item.id)
          .length == 0
      )
        return {
          ...state,
          basketItems: [...state.basketItems, {...action.item, quantity: 1}],
          ordError: ""
        };
      else
        return {
          ...state,
          basketItems: state.basketItems.map(basketItem =>
            basketItem.id == action.item.id
              ? {...basketItem, quantity: basketItem.quantity + 1}
              : basketItem
          ),
          ordError: ""
        };
    case "CHANGEQUANTITY":
      if (action.item.quantity > 0)
        return {
          ...state,
          basketItems: state.basketItems.map(basketItem =>
            basketItem.id == action.item.id
              ? {
                  ...basketItem,
                  quantity:
                    action.item.in_stock - action.item.quantity > 0
                      ? action.item.quantity
                      : basketItem.quantity
                }
              : basketItem
          ),
          ordError: ""
        };
    case "REMOVEFROMBASKET":
      return {
        ...state,
        basketItems: [
          ...state.basketItems.filter(
            basketItem => basketItem.id != action.item.id
          )
        ],
        ordError: ""
      };
    case "SELECTCATEGORY":
      return {...state, selectedCategory: action.selectedCategory};
    case "ORDER":
      return {...state, ordError: action.payload, basketItems: []};
    case "CHANGEORDER":
      return {...state};
    case "COMPLETEORDER":
      return {...state};
    case "REMOVEORDER":
      return {...state, ordError: action.payload};
    case "DELETEACCOUNT":
      return {...state, basketItems: []};
    case "ADDNEWDRUG": {
      return {...state, basketItems: []};
    }
    case "CHANGEOLDDRUG": {
      return {...state, managerLog: action.payload, basketItems: []};
    }
    case "ADDNEWCATEGORY": {
      return {...state, managerLog: action.payload, basketItems: []};
    }
    case "CHANGEOLDCATEGORY": {
      return {...state, managerLog: action.payload, basketItems: []};
    }

    case "ADDNEWMANUFACTURER": {
      return {...state, managerLog: action.payload, basketItems: []};
    }
    case "CHANGEOLDMANUFACTURER": {
      return {...state, managerLog: action.payload, basketItems: []};
    }

    case "ADDNEWDELIVERYPHARMACY": {
      return {...state, managerLog: action.payload, basketItems: []};
    }
    case "CHANGEOLDDELIVERYPHARMACY": {
      return {...state, managerLog: action.payload, basketItems: []};
    }
    case "ADDNEWDRUGERROR": {
      return {...state, managerLog: action.payload};
    }
    case "MNGRDELETE": {
      return {...state, basketItems: []};
    }
    case "CHANGEACCOUNTROLE":
      return {...state, basketItems: []};
    case "ROLLBACK": {
      return {...state, basketItems: [], managerLog: ""};
    }
    default:
      return state;
  }
};
