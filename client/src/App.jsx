import React from 'react';
import { hot } from 'react-hot-loader/root';
import MainWindow from "./components/MainWindow";
import { BrowserRouter as Router, Route, Link } from "react-router-dom";
import Statistics from "./components/Statistics";
import Page404 from "./components/Page404";

function App() {
  return (
      <Router>
          <Route exact path="/" component={MainWindow} />
          <Route exact path="/stats" component={Statistics} />
          <Route exact path="/404" component={Page404} />
      </Router>
  );
}

export default hot(App);