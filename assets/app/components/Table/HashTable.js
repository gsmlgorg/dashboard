import React from 'react';
import {
  withStyles,
  Table,
  TableHead,
  TableRow,
  TableBody,
  TableCell,
} from 'material-ui';

import PropTypes from 'prop-types';

import tableStyle from 'jss/dashboard/tableStyle';

function HashTable({ ...props }) {
  const {
    classes, tableHead, tableData, tableHeaderColor,
  } = props;
  return (
    <div className={classes.tableResponsive}>
      <Table className={classes.table}>
        {tableHead !== undefined ? (
          <TableHead className={classes[`${tableHeaderColor}TableHeader`]}>
            <TableRow>
              {tableHead.map((prop, key) => (
                <TableCell
                  className={`${classes.tableCell} ${classes.tableHeadCell}`}
                  key={prop}
                >
                  {prop}
                </TableCell>
              ))}
            </TableRow>
          </TableHead>
        ) : null}
        <TableBody>
          {tableData && tableData.map((prop, key) => (
            <TableRow key={key}>
              {tableHead.map((titleKey) => (
                <TableCell className={classes.tableCell} key={titleKey}>
                  {prop.get(titleKey)}
                </TableCell>
              ))}
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </div>
  );
}

HashTable.defaultProps = {
  tableHeaderColor: 'gray',
};

HashTable.propTypes = {
  classes: PropTypes.object.isRequired,
  tableHeaderColor: PropTypes.oneOf([
    'warning',
    'primary',
    'danger',
    'success',
    'info',
    'rose',
    'gray',
  ]),
};

export default withStyles(tableStyle)(HashTable);
