/*
 *
 * DashboardPage reducer
 *
 */

import { fromJS } from 'immutable';
import {
  DEFAULT_ACTION,
  FETCH_DASHBOARD_REQUEST,
  FETCH_DASHBOARD_SUCCESS,
  FETCH_DASHBOARD_FAILURE,
} from './constants';

const initialState = fromJS({
  loading: false,
  processes: [],
  loadAvg: [],
});

function dashboardPageReducer(state = initialState, action) {
  const { type, payload } = action;
  switch (type) {
    case DEFAULT_ACTION:
      return state;
    case FETCH_DASHBOARD_REQUEST:
      return state.set('loading', true);
    case FETCH_DASHBOARD_SUCCESS:
      return state.set('loading', false)
        .set('loadAvg', payload.loadAvg)
        .set('bootTime', payload.bootTime)
        .set('time', payload.time)
        .set('processes', fromJS(payload.processes));
    case FETCH_DASHBOARD_FAILURE:
      return state.set('loading', false);

    default:
      return state;
  }
}

export default dashboardPageReducer;
