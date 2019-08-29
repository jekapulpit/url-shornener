import React from 'react';
import { hot } from 'react-hot-loader/root';
import {API_ROOT} from "../constants";
import Button from '@material-ui/core/Button';

const LinkStats = props => {
        return (
            <div style={props.style} className='link-stats'>
                <div className="info">
                    <p>original url: <a href={props.link.original_link}>{props.link.original_link}</a></p>
                    <p>short url: <a href={`${API_ROOT}/${props.link.link_hash}`}>{API_ROOT}/{props.link.link_hash}</a></p>
                    <div className="stats">
                        <div className="visit-stats">
                            <p>total redirects: {props.link.visits_number}</p>
                            <p>unique redirects: {props.link.unique_visits_number}</p>
                        </div>
                        <a href={`/stats/${props.link.link_hash}`}>
                            <Button variant="contained" color="primary">
                                Get More Info
                            </Button>
                        </a>
                    </div>
                </div>
            </div>
        )
}

export default hot(LinkStats);