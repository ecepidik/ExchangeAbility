/**
 * Created by ece.pidik on 2018-10-12.
 */

const express = require('express')
const app = express();
const { Pool, Client } = require('pg')

const tasksRouter = require('./tasks.js');
app.use('/tasks', tasksRouter)

const usersRouter = require('./users.js');
app.use('/users', usersRouter)

const pool = new Pool({
    user: 'exchangeability',
    host: 'exchangeabilitydata.chwjpkpq8pgl.us-east-2.rds.amazonaws.com',
    database: 'exchangeability',
    password: 'exchangeability',
    port: 5432,
})

const client = new Client({
    user: 'exchangeability',
    host: 'exchangeabilitydata.chwjpkpq8pgl.us-east-2.rds.amazonaws.com',
    database: 'exchangeability',
    password: 'exchangeability',
    port: 5432,
})
client.connect()


// app.listen(8000, () => {
//     console.log('here');
// });k,

app.get('tasks/:id', (req, res, next) => {

});

app.get('/', (req, res) => {
    client.query('SELECT id, email, firstname, lastname, phone FROM public.users;', (err, obj) =>
        {
            res.send(obj.rows)})})



app.listen(8000, () => console.log(`Example app listening on port 8000!`))

// client.query('SELECT id, email, firstname, lastname, phone FROM public.users;', (err, res) => {
//     app.listen(8000, () => {
//     console.log('here');
//     console.log(err, res)
//     });
// })

const bodyParser = require("body-parser");
app.use(bodyParser.urlencoded({
    extended: true
}));

app.use(bodyParser.json());
app.post('/add/task', function(req, res) {

    var dateTime = req.body.date.split(" ");
    var date = dateTime[0];
    var time =dateTime[1];

    var queryTask = '\'' + req.body.requesterid + '\', \'' + req.body.title + '\', \''
        + date + '\', \'' + time + '\', \''
        + req.body.fee + '\', \''
        + req.body.address + '\', \''
        + req.body.description + '\', \'open\''

    console.log(queryTask);
    client.query(
        'INSERT INTO tasks (requesterid, title, date, time, fee, address, description, state)' +
        'VALUES (' + queryTask + ');', (err, obj) =>
        {res.send()})
})