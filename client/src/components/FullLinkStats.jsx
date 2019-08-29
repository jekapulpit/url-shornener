import React from 'react';
import { hot } from 'react-hot-loader/root';
import {API_ROOT} from "../constants";

class FullLinkStats extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            link: {
                location_stats: []
            }
        }
    }

    componentDidMount() {
        fetch(`${API_ROOT}/links/statistics/full/${this.props.match.params.id}`)
            .then(response => response.json())
            .then(data => {
                this.setState({
                    link: data
                })
            })
    }

    countPercent = (visits_number) => {
        return parseInt(visits_number*100/this.state.link.visits_number)
    };

    render() {
        let countries = this.state.link.location_stats.map((country_stats) => {
               return <p>
                   {country_stats.country ? country_stats.country : 'unknown'} : {country_stats.times_redirected} redirects ({this.countPercent(country_stats.times_redirected)}%)
               </p>
        });
        return (
            <div className='link-stats'>
                <div className="info">
                    <p>original url: <a href={this.state.link.original_link}>{this.state.link.original_link}</a></p>
                    <p>short url: <a href={`${API_ROOT}/${this.state.link.link_hash}`}>{API_ROOT}/{this.state.link.link_hash}</a></p>
                    <div className="stats">
                        <div className="visit-stats">
                            <p>total redirects: {this.state.link.visits_number}</p>
                            <p>unique redirects: {this.state.link.unique_visits_number}</p>
                            <p>top countries:</p>
                            {countries}
                        </div>
                    </div>
                </div>
            </div>
        )
    }
}

export default hot(FullLinkStats);