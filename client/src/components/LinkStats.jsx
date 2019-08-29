import React from 'react';
import { hot } from 'react-hot-loader/root';

const LinkStats = props => {
   return (
       <div className='link-stats'>
           <p>original url: <a href={props.link.original_link}>{props.link.original_link}</a></p>
           <p>short url: <a href={`http://localhost:3001/${props.link.link_hash}`}>http://localhost:3001/{props.link.link_hash}</a></p>
           <p>total redirects: {props.link.visits_number}</p>
           <p>unique redirects: {props.link.unique_visits_number}</p>
       </div>
   )
};

export default hot(LinkStats);