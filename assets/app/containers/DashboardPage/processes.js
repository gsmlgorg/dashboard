import React, { Component } from 'react';
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

class ProcessCard extends Component { // eslint-disable-line

  render() {
    const { processes } = this.props;
    const head = ['user', 'pid', 'cpu', 'mem', 'rss', 'started', 'stat', 'time', 'tt', 'vsz', 'command'];
    return (
      <RegularCard
        headerColor="orange"
        cardTitle="Processes Stats"
        cardSubtitle={`All Processes List (total: ${processes ? processes.size : 0})`}
        content={
          <HashTable
            tableHeaderColor="warning"
            tableHead={head}
            tableData={processes}
          />
        }
      />
    );
  }
}

export default ProcessCard;
