import React from 'react';
import PropTypes from 'prop-types';
import { withStyles } from 'material-ui';

import typographyStyle from 'jss/dashboard/typographyStyle';

function Info({ ...props }) {
  const { classes, children } = props;
  return (
    <div className={`${classes.defaultFontStyle} ${classes.infoText}`}>
      {children}
    </div>
  );
}

Info.propTypes = {
  classes: PropTypes.object.isRequired,
};

export default withStyles(typographyStyle)(Info);
