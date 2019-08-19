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
           return <div>
               <p>original url: <a href={link.original_link}>{link.original_link}</a></p>
               <p>short url: <a href={`http://localhost:3001/${link.link_hash}`}>http://localhost:3001/{link.link_hash}</a></p>
               <p>total clicks: {link.visits_number}</p>
               <p>total creations: {link.creations_number}</p>
           </div>
        });

        return (
            <div className='main-window'>
                {links}
            </div>
        )
    }
}

export default hot(Statistics);