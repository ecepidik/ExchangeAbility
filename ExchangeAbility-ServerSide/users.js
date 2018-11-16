/**
 * Created by ece.pidik on 2018-11-16.
 */

const express = require('express');
const pool = require('./dbconfig.js')

usersRouter = express.Router();

usersRouter.get('/:id', (req, res, next) => {
    var id = req.params.id.toString();
    var query = 'SELECT * FROM users WHERE id=' + id;
    pool.query(query, (error, result) => {
        if(error){
            throw error;
        }
        res.send(JSON.stringify(result.rows));
    });
});

module.exports = usersRouter;