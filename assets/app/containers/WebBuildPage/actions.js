/*
 *
 * WebBuildPage actions
 *
 */

import {
  DEFAULT_ACTION,
  FETCH_WEB_BUILD,
  FETCH_WEB_BUILD_REQUEST,
  FETCH_WEB_BUILD_SUCCESS,
  FETCH_WEB_BUILD_FAILURE,
} from './constants';

export function defaultAction() {
  return {
    type: DEFAULT_ACTION,
    payload: {},
  };
}

export function fetchWebBuild() {
  return {
    type: FETCH_WEB_BUILD,
    payload: {},
  };
}

export function fetchWebBuildRequest() {
  return {
    type: FETCH_WEB_BUILD_REQUEST,
    payload: {},
  };
}

export function fetchWebBuildSuccess(data) {
  return {
    type: FETCH_WEB_BUILD_SUCCESS,
    payload: {
      builds: data.builds,
    },
  };
}

export function fetchWebBuildFailure() {
  return {
    type: FETCH_WEB_BUILD_FAILURE,
    payload: {},
  };
}
