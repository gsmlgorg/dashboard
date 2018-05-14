/*
 *
 * WebBuildPage reducer
 *
 */

import { fromJS } from 'immutable';
import {
  DEFAULT_ACTION,
  FETCH_WEB_BUILD_REQUEST,
  FETCH_WEB_BUILD_SUCCESS,
  FETCH_WEB_BUILD_FAILURE,
} from './constants';

const initialState = fromJS({
  loading: false,
  builds: [],
});

function webBuildPageReducer(state = initialState, action) {
  const { type, payload } = action;
  switch (type) {
    case DEFAULT_ACTION:
      return state;
    case FETCH_WEB_BUILD_REQUEST:
      return state.set('loading', true);
    case FETCH_WEB_BUILD_SUCCESS:
      return state.set('loading', false)
        .set('builds', fromJS(payload.builds));
    case FETCH_WEB_BUILD_FAILURE:
      return state.set('loading', false);
    default:
      return state;
  }
}

export default webBuildPageReducer;
