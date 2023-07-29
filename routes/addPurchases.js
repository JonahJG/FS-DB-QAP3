const express = require('express');
const router = express.Router();
const pool = require('../public/services/rsge_db_pg');

router.get('/', (req, res) => {
  res.render('addPurchases'); 
});

router.post('/', async (req, res) => {
  try {
    const {
      'purchase-item-id': item_id,
      'purchase-price-per-item': buy_price,
      'purchase-amount-bought': amt_bought,
      'purchase-total-amount': total_cost,
    } = req.body;

    // Get the current date as a string in ISO format
    const buy_time = new Date().toISOString();

    // Validate the input data
    if (isNaN(item_id) || isNaN(buy_price) || isNaN(amt_bought) || isNaN(total_cost)) {
      return res.status(400).send('Invalid input data. Please provide valid values for the purchase.');
    }

    // Insert the purchase data into the purchases table
    const insertQuery = 'INSERT INTO purchases (purchase_id, item_id, buy_price, amt_bought, total_cost, buy_time, sale_id) VALUES (nextval(\'purchase_id_seq\'), $1, $2, $3, $4, $5, nextval(\'sales_sale_id_seq\'))';
    await pool.query(insertQuery, [item_id, buy_price, amt_bought, total_cost, buy_time]);

    res.sendStatus(204); // Success response (No Content)
  } catch (error) {
    console.error('Error adding purchase:', error);
    // Send a more informative error response
    res.status(500).json({ error: 'Error adding purchase. Please try again later.', details: error.message });
  }
});

module.exports = router;

