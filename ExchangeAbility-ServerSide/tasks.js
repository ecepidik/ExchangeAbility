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
    var id = req.params.id.toString();
    var query = 'SELECT * FROM tasks WHERE id=' + id;
   pool.query(query, (error, result) => {
       if(error){
           throw error;
       }
       res.send(JSON.stringify(result.rows));
   });
});

tasksRouter.get('/postedtasks/:id', (req, res, next) => {
    var id = req.params.id.toString();
    var query = 'SELECT * FROM tasks WHERE requesterid=' + id;
    pool.query(query, (error, result) => {
        if(error){
            throw error;
        }
        res.send(JSON.stringify(result.rows));
    });
});

tasksRouter.get('/mytasks/:id', (req, res, next) => {
    var id = req.params.id.toString();
    console.log(id);
    var query = 'SELECT * FROM tasks WHERE providerid=' + id;
    pool.query(query, (error, result) => {
        if(error){
            throw error;
        }
        res.send(JSON.stringify(result.rows));
    });
});


module.exports = tasksRouter;