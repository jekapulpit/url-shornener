import React from 'react';
import { hot } from 'react-hot-loader/root';
import Button from '@material-ui/core/Button';
import TextField from '@material-ui/core/TextField';
import '../stylesheets/components/form.scss'

class Form extends React.Component {
    render() {
        return (
            <form className="link-form">
                <TextField
                    label="your link"
                    type="text"
                    name="original_link"
                    margin="normal"
                    variant="outlined"
                    style={{width: '100%', margin: '10px'}}
                />
                <Button variant="contained" color="primary">
                    Short
                </Button>
            </form>
        )
    }
}

export default hot(Form);