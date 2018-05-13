import { createSelector } from 'reselect';

/**
 * Direct selector to the dashboardPage state domain
 */
export const selectDashboardPageDomain = (state) => state.get('dashboardPage');

/**
 * Other specific selectors
 */
export const makeSelectProcesses = () => createSelector(
  selectDashboardPageDomain,
  (substate) => substate && substate.get('processes')
);

export const makeSelectLoadAvg = () => createSelector(
  selectDashboardPageDomain,
  (substate) => substate && substate.get('loadAvg')
);

export const makeSelectBootTime = () => createSelector(
  selectDashboardPageDomain,
  (substate) => substate && substate.get('bootTime')
);

export const makeSelectTime = () => createSelector(
  selectDashboardPageDomain,
  (substate) => substate && substate.get('time')
);

/**
 * Default selector used by DashboardPage
 */

export const makeSelectDashboardPage = () => createSelector(
  selectDashboardPageDomain,
  (substate) => substate.toJS()
);
