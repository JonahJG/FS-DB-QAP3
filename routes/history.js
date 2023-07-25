const express = require('express');
const { Pool } = require('pg');
const router = express.Router();
const pool = require('../services/rsge_db');


router.get('/', async (req, res) => {
    try {
      const client = await pool.connect();
  
      // Fetch first 10 entries from purchases table, ordered by date in descending order
      const purchasesQuery = 'SELECT * FROM purchases ORDER BY buy_time DESC LIMIT 10';
      const purchasesResult = await client.query(purchasesQuery);
      const purchases = purchasesResult.rows;
  
      // Fetch first 10 entries from sales table, ordered by date in descending order
      const salesQuery = 'SELECT * FROM sales ORDER BY sell_time DESC LIMIT 10';
      const salesResult = await client.query(salesQuery);
      const sales = salesResult.rows;
  
      // Fetch data from items table
      const itemsQuery = 'SELECT * FROM items';
      const itemsResult = await client.query(itemsQuery);
      const items = itemsResult.rows;
 
      client.release();
  
      res.render('history', { purchases, sales, items });
    } catch (error) {
      console.error('Error fetching data:', error);
      res.status(500).send('Error fetching data. Please try again later.');
    }
  });
  
  router.get('/sales-all', async (req, res) => {
    try {
      const client = await pool.connect();
      const salesQuery = 'SELECT * FROM sales ORDER BY sell_time DESC';
      const salesResult = await client.query(salesQuery);
      const sales = salesResult.rows;
      client.release();
      res.render('sales-all', { sales });
    } catch (error) {
      console.error('Error fetching sales data:', error);
      res.status(500).send('Error fetching sales data. Please try again later.');
    }
  });
  
  router.get('/purchases-all', async (req, res) => {
    try {
      const client = await pool.connect();
      const purchasesQuery = 'SELECT * FROM purchases ORDER BY buy_time DESC';
      const purchasesResult = await client.query(purchasesQuery);
      const purchases = purchasesResult.rows;
      client.release();
      res.render('purchases-all', { purchases });
    } catch (error) {
      console.error('Error fetching purchase data:', error);
      res.status(500).send('Error fetching purchase data. Please try again later.');
    }
  });
  

module.exports = router;
