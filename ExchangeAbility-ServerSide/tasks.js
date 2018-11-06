/**
 * Created by courtneywright on 10/14/18.
 */
const express = require('express');
const pool = require('./dbconfig.js')

tasksRouter = express.Router();

tasksRouter.get('/', (req,res,next) => {
    pool.query('SELECT * FROM tasks', (error, result) => {
        if(error){
            throw error;
        }
        res.send(JSON.stringify(result.rows));
    });
});

tasksRouter.get('/:id', (req, res, next) => {
   pool.query('SELECT * FROM tasks WHERE id=${req.params.id}', (error, result) => {
       if(error){
           throw error;
       }
       res.send(JSON.stringify(result.rows));
   });
});


module.exports = tasksRouter;