const express = require('express');
const router = express.Router();
const pool = require('../public/services/rsge_db_pg');

router.get('/', (req, res) => {
  res.render('addSales'); 
});

router.post('/', async (req, res) => {
  try {
    const {
      'sale-item-id': item_id,
      'sale-price-per-item': sell_price,
      'sale-amount-sold': amt_sold,
      'sale-total-amount': total_price,
    } = req.body;

    // Get the current date as a string in ISO format
    const sell_time = new Date().toISOString();

    // Validate the input data
    if (isNaN(item_id) || isNaN(sell_price) || isNaN(amt_sold) || isNaN(total_price)) {
      return res.status(400).json({ error: 'Invalid input data. Please provide valid values for the sale.' });
    }

    // Insert the sale data into the sales table
    const insertQuery = 'INSERT INTO sales (sale_id, item_id, sell_price, sell_time, amt_sold, total_price) VALUES (nextval(\'sales_sale_id_seq\'), $1, $2, $3, $4, $5)';
    await pool.query(insertQuery, [item_id, sell_price, sell_time, amt_sold, total_price]);

    res.sendStatus(204); // Success response (No Content)
  } catch (error) {
    console.error('Error adding sale:', error);
    // Send a more informative error response
    res.status(500).json({ error: 'Error adding sale. Please try again later.', details: error.message });
  }
});

module.exports = router;
