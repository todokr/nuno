import './App.scss';
import Metrics from './metrics/Metrics';
import {
    Center,
    Heading,
} from '@chakra-ui/react';

const App = () => (
    <div className="app">
        <Heading size="3xl" backgroundColor="gray.700" color="white" p="14" mb="2">
<Center>Development Performance Indicators</Center>
        </Heading>
        <div className='wrapper'>
            <Metrics />
        </div>
    </div>
);


export default App;
