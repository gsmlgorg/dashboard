/**
 *
 * DashboardPage
 *
 */

import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { Helmet } from 'react-helmet';
import { createStructuredSelector } from 'reselect';
import { bindActionCreators, compose } from 'redux';
import moment from 'moment';

// react plugin for creating charts
import ChartistGraph from 'react-chartist';
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
  Table,
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
import ProcessCard from './processes';
import {
  makeSelectTime,
  makeSelectBootTime,
  makeSelectProcesses,
  makeSelectLoadAvg,
} from './selectors';
import { fetchDashboard } from './actions';


export class DashboardPage extends React.PureComponent { // eslint-disable-line react/prefer-stateless-function
  componentWillMount() {
    const { doFetch } = this.props;
    doFetch();
    this.timer = setInterval(() => doFetch(), 10000);
  }

  componentWillUnmount() {
    clearInterval(this.timer);
  }

  render() {
    const {
      time,
      bootTime,
      processes,
      loadAvg,
    } = this.props;
    return (
      <div>
        <Helmet>
          <title>DashboardPage</title>
          <meta name="description" content="Description of DashboardPage" />
        </Helmet>
        <Grid container>
          <ItemGrid xs={12} sm={6} md={3}>
            <StatsCard
              icon={Accessibility}
              iconColor="blue"
              title="Server Boot"
              description={moment.unix(bootTime).fromNow()}
              statIcon={Update}
              statText={`Now: ${moment.unix(time).toISOString()}`}
            />
          </ItemGrid>
          <ItemGrid xs={12} sm={6} md={3}>
            <StatsCard
              icon={Accessibility}
              iconColor="blue"
              title="LoadAvg"
              description={loadAvg}
              statIcon={Update}
              statText=""
            />
          </ItemGrid>
        </Grid>
        <Grid container>
          <ItemGrid xs={12} sm={12} md={12}>
            <ProcessCard processes={processes} />
          </ItemGrid>
        </Grid>
      </div>
    );
  }
}

const mapStateToProps = createStructuredSelector({
  time: makeSelectTime(),
  bootTime: makeSelectBootTime(),
  processes: makeSelectProcesses(),
  loadAvg: makeSelectLoadAvg(),
});

const mapDispatchToProps = (dispatch) => bindActionCreators({
  doFetch: fetchDashboard,
}, dispatch);

const withConnect = connect(mapStateToProps, mapDispatchToProps);

const withReducer = injectReducer({ key: 'dashboardPage', reducer });
const withSaga = injectSaga({ key: 'dashboardPage', saga });

export default compose(
  withStyles(dashboardStyle),
  withConnect,
  withSaga,
  withReducer,
)(DashboardPage);
