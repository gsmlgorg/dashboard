import { createSelector } from 'reselect';

/**
 * Direct selector to the webBuildPage state domain
 */
const selectWebBuildPageDomain = (state) => state.get('webBuildPage');

/**
 * Other specific selectors
 */


/**
 * Default selector used by WebBuildPage
 */

const makeSelectWebBuildPage = () => createSelector(
  selectWebBuildPageDomain,
  (substate) => substate && substate.toJS()
);

export default makeSelectWebBuildPage;
export {
  selectWebBuildPageDomain,
};
