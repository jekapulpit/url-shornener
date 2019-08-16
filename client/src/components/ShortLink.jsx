import React from 'react';
import { hot } from 'react-hot-loader/root';
import TextField from '@material-ui/core/TextField';
import '../stylesheets/components/form.scss'

const ShortLink = props => {
    return (
        <TextField
            className="link-form"
            defaultValue={props.link}
            disabled
            type="text"
            margin="normal"
            variant="outlined"
            style={{width: '100%', margin: '10px'}}
        />
    )
};

export default hot(ShortLink);