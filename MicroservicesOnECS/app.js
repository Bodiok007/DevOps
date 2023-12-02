const express = require('express');
const app = express();
const port = 8082;

app.get('/', (req, res) => {
  res.send('Успішний запуск!');
});

app.get('/health', (req, res) => {
  res.send('HealthCheck path');
});

app.get('/test', (req, res) => {
  res.send('Test page');
});

app.listen(port, () => {
  console.log(`Сервер працює на порті ${port}`);
});