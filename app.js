const express = require('express');
const app = express();
const port = 3000;

// Sample route
app.get('/', (req, res) => {
    res.send('Hello, World!');
});

// Start the server
app.listen(port, () => {
    console.log(`App running on http://localhost:${port}`);
});
