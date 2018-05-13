import { take, call, put, select, takeLatest } from 'redux-saga/effects';
import request from 'utils/request';

import { FETCH_DASHBOARD } from './constants';
import {
  fetchDashboardRequest,
  fetchDashboardSuccess,
  fetchDashboardFailure,
} from './actions';

function* fetchDashboard() {
  const url = '/api/dashboard';
  try {
    yield put(fetchDashboardRequest());
    const data = yield call(request, url);
    yield put(fetchDashboardSuccess(data));
  } catch (thrown) {
    yield put(fetchDashboardFailure(thrown));
  }
}

// Individual exports for testing
export default function* defaultSaga() {
  // See example in containers/HomePage/saga.js
  yield takeLatest(FETCH_DASHBOARD, fetchDashboard);
}
