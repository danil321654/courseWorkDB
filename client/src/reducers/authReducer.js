//import {data} from './../../download.js';

let initialState = {
  user: {},
  isAuthenticated: false,
  regError: "",
  logError: ""
};

export const authReducer = (state = initialState, action) => {
  console.log(state.isAuthenticated);
  switch (action.type) {
    case "LOGIN":
      return {
        ...state,
        user: action.user,
        isAuthenticated: true,
        logError: action.payload
      };
    case "LOGERROR":
      return {...state, logError: action.payload};
    case "AUTH":
      return {
        ...state,
        isAuthenticated: true,
        logError: "logged",
        user: action.user
      };

    case "REGISTER":
      return {...state, regError: action.payload};
    case "REGERROR":
      return {...state, regError: action.payload};
    case "LOGOUT":
      return {...state, user: {}, isAuthenticated: false, logError: ""};
    default:
      return state;
  }
};
