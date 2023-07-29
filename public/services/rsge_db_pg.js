const Pool = require('pg').Pool;
const pool = new Pool({
    user: 'postgres',
    password: 'Jayjase93',
    host: 'localhost',
    port: 5432,
    database: 'RunescapeGE',
});

module.exports = pool;