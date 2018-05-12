/**
 *
 * Asynchronously loads the component for DashboardPage
 *
 */

import Loadable from 'react-loadable';

export default Loadable({
  loader: () => import(/* webpackChunkName: "DashboardPage" */'./index'),
  loading: () => null,
});
