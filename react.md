## Setup basic axios client with default timeout

```
import axios from 'axios'

const baseUrl = 'http://localhost:5000'
const httpClient = axios.create()
httpClient.defaults.timeout = 3000
```
