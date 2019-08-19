import React from 'react';
import { hot } from 'react-hot-loader/root';
import '../stylesheets/components/stats_window.scss'
import {API_ROOT} from "../constants";
import LinkStats from "./LinkStats";

class Statistics extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            links: []
        }
    }

    componentDidMount() {
        fetch(`${API_ROOT}/links/statistics`, {
            headers: {
                'Content-Type': 'application/json',
            },
        })
            .then((response) => { return response.json() })
            .then((data) => {
                this.setState({
                    links: data.links
                })
            })
    }

    render() {
        let links = this.state.links.map((link) => {
           return <LinkStats link={link} key={link.link_hash} />
        });

        return (
            <div className='stats-window'>
                <a style={{textAlign: 'center', margin: '10px'}}  href="/">back to shortener</a>
                {links}
            </div>
        )
    }
}

export default hot(Statistics);