/**
 *
 * Asynchronously loads the component for WebBuildPage
 *
 */

import Loadable from 'react-loadable';

export default Loadable({
  loader: () => import(/* webpackChunkName: "WebBuildPage" */'./index'),
  loading: () => null,
});
