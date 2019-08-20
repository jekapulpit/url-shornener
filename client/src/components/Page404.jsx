import React from 'react';
import { hot } from 'react-hot-loader/root';
import '../stylesheets/components/main_window.scss'

const Page404 = props => {
        return (
            <div className='main-window'>
                <h1 style={{textAlign: 'center'}}>Your short link does not exists</h1>
                <a style={{textAlign: 'center'}} href="/">create a new one</a>
            </div>
        )
};

export default hot(Page404);