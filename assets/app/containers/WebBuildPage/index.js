/**
 *
 * WebBuildPage
 *
 */

import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { Helmet } from 'react-helmet';
import { createStructuredSelector } from 'reselect';
import { bindActionCreators, compose } from 'redux';
import moment from 'moment';

import {
  ContentCopy,
  Store,
  InfoOutline,
  Warning,
  DateRange,
  LocalOffer,
  Update,
  ArrowUpward,
  AccessTime,
  Accessibility,
} from '@material-ui/icons';
import { withStyles, Grid } from 'material-ui';

import {
  StatsCard,
  ChartCard,
  TasksCard,
  RegularCard,
  HashTable,
  ItemGrid,
} from 'components';

import {
  dailySalesChart,
  emailsSubscriptionChart,
  completedTasksChart,
} from 'variables/charts';

import dashboardStyle from 'jss/dashboard/dashboardStyle';

import injectSaga from 'utils/injectSaga';
import injectReducer from 'utils/injectReducer';
import reducer from './reducer';
import saga from './saga';
import { makeSelectWebBuild } from './selectors';
import { fetchWebBuild } from './actions';

export class WebBuildPage extends React.PureComponent { // eslint-disable-line react/prefer-stateless-function
  componentWillMount() {
    this.props.fetchBuild();
  }

  render() {
    const { builds } = this.props;
    const head = ['hash', 'user', 'branch', 'commit', 'created_at'];
    const data = builds && builds.sortBy((b) => b.get('created_at')).map((b) => (
      b.set('created_at', moment.unix(b.get('created_at')).toISOString())
        .set('commit', b.get('commit').slice(0, 7))
    )).reverse();
    return (
      <div>
        <Helmet>
          <title>WebBuildPage</title>
          <meta name="description" content="Description of WebBuildPage" />
        </Helmet>
        <Grid container>
          <ItemGrid xs={12} sm={12} md={12}>
            <RegularCard
              headerColor="orange"
              cardTitle="Web Builds Stats"
              cardSubtitle={`All Builds List (total: ${data ? data.size : 0})`}
              content={
                <HashTable
                  tableHeaderColor="warning"
                  tableHead={head}
                  tableData={data}
                />
              }
            />
          </ItemGrid>
        </Grid>
      </div>
    );
  }
}

const mapStateToProps = createStructuredSelector({
  builds: makeSelectWebBuild(),
});

const mapDispatchToProps = (dispatch) => bindActionCreators({
  fetchBuild: fetchWebBuild,
}, dispatch);

const withConnect = connect(mapStateToProps, mapDispatchToProps);

const withReducer = injectReducer({ key: 'webBuildPage', reducer });
const withSaga = injectSaga({ key: 'webBuildPage', saga });

export default compose(
  withConnect,
  withSaga,
  withReducer,
)(WebBuildPage);
