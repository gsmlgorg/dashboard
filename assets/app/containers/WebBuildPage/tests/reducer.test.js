
import { fromJS } from 'immutable';
import webBuildPageReducer from '../reducer';

describe('webBuildPageReducer', () => {
  it('returns the initial state', () => {
    expect(webBuildPageReducer(undefined, {})).toEqual(fromJS({}));
  });
});
