import React from 'react';
import { hot } from 'react-hot-loader/root';
import '../stylesheets/components/main_window.scss'
import {API_ROOT} from "../constants";

class Statistics extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            links: []
        }
    }

    componentDidMount() {

    }

    render() {
        return (
            <div className='main-window'>
                stats
            </div>
        )
    }
}

export default hot(Statistics);