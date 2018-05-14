import DashboardPage from 'containers/DashboardPage/Loadable';
import WebBuildPage from 'containers/WebBuildPage/Loadable';
import NotificationsPage from 'views/Notifications/Notifications';

import {
  Dashboard,
  Person,
  ContentPaste,
  LibraryBooks,
  BubbleChart,
  LocationOn,
  Notifications,
} from '@material-ui/icons';

const dashboardRoutes = [
  {
    path: '/dashboard',
    sidebarName: 'Dashboard',
    navbarName: 'Dashboard',
    icon: Dashboard,
    component: DashboardPage,
  },
  {
    path: '/web_build',
    sidebarName: 'Web Build',
    navbarName: 'Web Build',
    icon: LibraryBooks,
    component: WebBuildPage,
  },
  {
    path: '/notifications',
    sidebarName: 'Notifications',
    navbarName: 'Notifications',
    icon: Notifications,
    component: NotificationsPage,
  },
  {
    redirect: true, path: '/', to: '/dashboard', navbarName: 'Redirect',
  },
];

export default dashboardRoutes;
