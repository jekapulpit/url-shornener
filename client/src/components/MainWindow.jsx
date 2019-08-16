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
            generatedLink: null
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
                    generatedLink: data.errors.original_link ? 'invalid link' : data.link
                })
            })
    };

    render() {
        let generatedLink = this.state.generatedLink ? <ShortLink key={this.state.generatedLink} link={this.state.generatedLink}/> : null;
        return (
            <div className='main-window'>
                <Form handleShortLink={this.handleShortLink}/>
                {generatedLink}
            </div>
        )
    }
}

export default hot(MainWindow);