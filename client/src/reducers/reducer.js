import {combineReducers} from 'redux';
import {authReducer} from './authReducer';
import {shopReducer} from './shopReducer';

export const reducer = combineReducers({auth: authReducer, shop: shopReducer});
