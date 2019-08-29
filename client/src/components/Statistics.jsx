import React from 'react';
import { hot } from 'react-hot-loader/root';
import '../stylesheets/components/stats_window.scss'
import {API_ROOT} from "../constants";
import LinkStats from "./LinkStats";
import { InfiniteLoader, List, AutoSizer, CellMeasurer, CellMeasurerCache } from "react-virtualized";

class Statistics extends React.Component {
    constructor(props) {
        super(props);

        this.isRowLoaded = this.isRowLoaded.bind(this);
        this.renderRow = this.renderRow.bind(this);
        this.loadMoreRows = this.loadMoreRows.bind(this);

        this.cache = new CellMeasurerCache({
            fixedWidth: true,
            defaultHeight: 100
        });
        this.state = {
            links: []
        }
    }

    bindListRef = ref => {
        this.list = ref;
    };

    componentDidUpdate(prevProps, prevState, snapshot) {
        if (this.list) {
            this.cache.clearAll();
            this.list.forceUpdateGrid();
        }
    }

    componentDidMount() {
        this.loadMoreRows({startIndex: 0, stopIndex: 10});
    }

    renderRow = ({ index, key, style, parent }) => {
        return (
            <CellMeasurer
                key={key}
                cache={this.cache}
                parent={parent}
                columnIndex={0}
                rowIndex={index}>
                <LinkStats
                    link={this.state.links[index]}
                    style={style}
                />
            </CellMeasurer>
        );
    };

    isRowLoaded = ({ index }) => {
        return !!this.state.links[index];
    };

    loadMoreRows = ({ startIndex, stopIndex }) => {
        return fetch(`${API_ROOT}/links/statistics/?startIndex=${startIndex}&stopIndex=${stopIndex}`)
            .then(response => response.json())
            .then(data => {
                this.setState({
                    links: this.state.links.concat(data)
                })
            })
    };

    render() {

        return (
            <div className='stats-window'>
                <a style={{textAlign: 'center', margin: '10px'}}  href="/">back to shortener</a>
                <InfiniteLoader
                    isRowLoaded={this.isRowLoaded}
                    loadMoreRows={this.loadMoreRows}
                    rowCount={10000}
                >
                    {({ onRowsRendered, registerChild }) => (
                        <AutoSizer>
                            {
                                ({ width, height }) => {
                                    return <List
                                        ref={registerChild}
                                        width={width}
                                        height={height}
                                        onRowsRendered={onRowsRendered}
                                        deferredMeasurementCache={this.cache}
                                        rowHeight={this.cache.rowHeight}
                                        rowRenderer={this.renderRow}
                                        rowCount={this.state.links.length}
                                        overscanRowCount={3} />
                                }
                            }
                        </AutoSizer>
                    )}
                </InfiniteLoader>,
            </div>
        )
    }
}

export default hot(Statistics);