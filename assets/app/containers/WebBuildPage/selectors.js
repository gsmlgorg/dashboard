import { createSelector } from 'reselect';

/**
 * Direct selector to the webBuildPage state domain
 */
const selectWebBuildPageDomain = (state) => state.get('webBuildPage');

/**
 * Other specific selectors
 */
export const makeSelectWebBuild = () => createSelector(
  selectWebBuildPageDomain,
  (substate) => substate && substate.get('builds')
);


/**
 * Default selector used by WebBuildPage
 */

const makeSelectWebBuildPage = () => createSelector(
  selectWebBuildPageDomain,
  (substate) => substate && substate.toJS()
);

export default makeSelectWebBuildPage;
export { selectWebBuildPageDomain };
