const express = require('express');
const router = express.Router();
const { Pool } = require('pg');
const pool = require('../services/rsge_db');

router.patch('/:sale_id', async (req, res) => {
  try {
    const saleId = req.params.sale_id;
    const { sell_price, amt_sold, total_price } = req.body;

    // Validate the input data
    if (isNaN(sell_price) || isNaN(amt_sold) || isNaN(total_price)) {
      return res.status(400).send('Invalid input data. Please provide valid values for the sale.');
    }

    // Fetch the existing sale record from the database
    const fetchSaleQuery = 'SELECT * FROM sales WHERE sale_id = $1';
    const fetchSaleResult = await pool.query(fetchSaleQuery, [saleId]);
    const sale = fetchSaleResult.rows[0];

    // Check if the sale record exists
    if (!sale) {
      return res.status(404).json({ error: 'Sale not found.' });
    }

    // Fetch the corresponding item record for the sale
    const itemQuery = 'SELECT * FROM items WHERE item_id = $1';
    const itemResult = await pool.query(itemQuery, [sale.item_id]);
    const item = itemResult.rows[0];

    // Fetch the latest purchase record for the item (based on buy_time) from the purchases table
    const fetchLatestPurchaseQuery = 'SELECT * FROM purchases WHERE item_id = $1 ORDER BY buy_time DESC LIMIT 1';
    const fetchLatestPurchaseResult = await pool.query(fetchLatestPurchaseQuery, [sale.item_id]);
    const purchase = fetchLatestPurchaseResult.rows[0];

    // Perform the profit calculation
    const profit = item && purchase ? (sell_price - purchase.buy_price) : 'N/A';

    // Update the sale data in the database
    const updateQuery = 'UPDATE sales SET sell_price = $1, amt_sold = $2, total_price = $3 WHERE sale_id = $4';
    await pool.query(updateQuery, [sell_price, amt_sold, total_price, saleId]);

    // Prepare the data to send back to the frontend
    const responseData = {
      sale: {
        ...sale,
        sell_price: sell_price,
        amt_sold: amt_sold,
        total_price: total_price,
      },
      item: item,
      purchase: purchase,
      profit: profit,
    };

    res.status(200).json(responseData);
  } catch (error) {
    console.error('Error updating sale:', error); // Log the caught error for debugging

    // Send a 500 Internal Server Error response with details about the error
    res.status(500).json({ error: 'Error updating sale. Please try again later.', details: error.message });
  }
});


module.exports = router;
