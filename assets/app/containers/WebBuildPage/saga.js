import { take, call, put, select, takeLatest } from 'redux-saga/effects';
import request from 'utils/request';

import { FETCH_WEB_BUILD } from './constants';
import {
  fetchWebBuildRequest,
  fetchWebBuildSuccess,
  fetchWebBuildFailure,
} from './actions';

function* fetchWebBuild() {
  const url = '/api/web_build';
  try {
    yield put(fetchWebBuildRequest());
    const data = yield call(request, url);
    yield put(fetchWebBuildSuccess(data));
  } catch (thrown) {
    yield put(fetchWebBuildFailure(thrown));
  }
}

// Individual exports for testing
export default function* defaultSaga() {
  // See example in containers/HomePage/saga.js
  yield takeLatest(FETCH_WEB_BUILD, fetchWebBuild);
}
