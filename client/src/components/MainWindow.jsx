import React from 'react';
import { hot } from 'react-hot-loader/root';
import Form from "./Form";
import '../stylesheets/components/main_window.scss'
import ShortLink from "./ShortLink";
import {API_ROOT} from "../constants";

class MainWindow extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            generatedLinks: []
        }
    }

    handleShortLink = link => {
        fetch(`${API_ROOT}/links`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                original_link: link
            })
        })
            .then((response) => { return response.json() })
            .then((data) => {
                this.setState({
                    generatedLinks: this.state.generatedLinks.concat(data.link)
                })
            })
    };

    render() {
        let links = this.state.generatedLinks.map((link) => {
            return <ShortLink key={link} link={link}/>
        });
        return (
            <div className='main-window'>
                <Form handleShortLink={this.handleShortLink}/>
                {links}
            </div>
        )
    }
}

export default hot(MainWindow);