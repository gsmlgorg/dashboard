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
import makeSelectWebBuildPage from './selectors';
import reducer from './reducer';
import saga from './saga';

export class WebBuildPage extends React.PureComponent { // eslint-disable-line react/prefer-stateless-function
  render() {
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
              cardSubtitle={`All Builds List (total: ${0})`}
              content={
                <HashTable
                  tableHeaderColor="warning"
                  tableHead={[]}
                  tableData={[]}
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
  webBuildPage: makeSelectWebBuildPage(),
});

const mapDispatchToProps = (dispatch) => bindActionCreators({
}, dispatch);

const withConnect = connect(mapStateToProps, mapDispatchToProps);

const withReducer = injectReducer({ key: 'webBuildPage', reducer });
const withSaga = injectSaga({ key: 'webBuildPage', saga });

export default compose(
  withReducer,
  withSaga,
  withConnect,
)(WebBuildPage);
