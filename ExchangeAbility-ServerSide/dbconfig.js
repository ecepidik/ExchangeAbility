/**
 * Created by courtneywright on 10/14/18.
 */

const { Pool, Client } = require('pg')

var config = {
    user: 'exchangeability',
    host: 'exchangeabilitydata.chwjpkpq8pgl.us-east-2.rds.amazonaws.com',
    database: 'exchangeability',
    password: 'exchangeability',
    port: 5432
};

const pool = Pool(config);

module.exports = pool;