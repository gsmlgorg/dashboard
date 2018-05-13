/*
 *
 * DashboardPage actions
 *
 */

import {
  DEFAULT_ACTION,
  FETCH_DASHBOARD,
  FETCH_DASHBOARD_REQUEST,
  FETCH_DASHBOARD_SUCCESS,
  FETCH_DASHBOARD_FAILURE,
} from './constants';

export function defaultAction() {
  return {
    type: DEFAULT_ACTION,
    payload: {},
  };
}

export function fetchDashboard() {
  return {
    type: FETCH_DASHBOARD,
    payload: {},
  };
}

export function fetchDashboardRequest() {
  return {
    type: FETCH_DASHBOARD_REQUEST,
    payload: {},
  };
}

export function fetchDashboardSuccess(data) {
  return {
    type: FETCH_DASHBOARD_SUCCESS,
    payload: {
      processes: data.processes,
      loadAvg: data.load_avg,
      bootTime: data.boot_time,
      time: data.time,
    },
  };
}

export function fetchDashboardFailure() {
  return {
    type: FETCH_DASHBOARD_FAILURE,
    payload: {},
  };
}
