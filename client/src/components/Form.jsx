import React from 'react';
import { hot } from 'react-hot-loader/root';
import Button from '@material-ui/core/Button';
import '../stylesheets/components/form.scss'

const Form = props => {
    let formData = {};
    return (
        <form className="link-form">
            <input
                ref={input => formData.originalLink = input}
                type="text"
                name="original_link"
                style={{width: '100%', margin: '10px', height: '50px', fontSize: '20px', paddingLeft: '20px'}}
            />
            <Button onClick={() => {props.handleShortLink(formData.originalLink.value)}} variant="contained" color="primary">
                Short
            </Button>
        </form>
    )
};

export default hot(Form);