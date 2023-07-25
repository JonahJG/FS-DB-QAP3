const express = require('express');
const router = express.Router();
const { Pool } = require('pg');
const pool = require('../services/rsge_db');


router.patch('/:purchase_id', async (req, res) => {
  try {
    const purchaseId = req.params.purchase_id;
    const { buy_price, amt_bought, total_cost } = req.body;

    // Validate the input data
    if (isNaN(buy_price) || isNaN(amt_bought) || isNaN(total_cost)) {
      return res.status(400).send('Invalid input data. Please provide valid values for the purchase.');
    }

    // Fetch the existing purchase record from the database
    const fetchPurchaseQuery = 'SELECT * FROM purchases WHERE purchase_id = $1';
    const fetchPurchaseResult = await pool.query(fetchPurchaseQuery, [purchaseId]);
    const purchase = fetchPurchaseResult.rows[0];

    // Check if the purchase record exists
    if (!purchase) {
      return res.status(404).json({ error: 'Purchase not found.' });
    }

    // Fetch the corresponding item record for the purchase
    const itemQuery = 'SELECT * FROM items WHERE item_id = $1';
    const itemResult = await pool.query(itemQuery, [purchase.item_id]);
    const item = itemResult.rows[0];

    // Update the purchase data in the database
    const updateQuery = 'UPDATE purchases SET buy_price = $1, amt_bought = $2, total_cost = $3 WHERE purchase_id = $4';
    await pool.query(updateQuery, [buy_price, amt_bought, total_cost, purchaseId]);

    // Prepare the data to send back to the frontend
    const responseData = {
      purchase: {
        ...purchase,
        buy_price: buy_price,
        amt_bought: amt_bought,
        total_cost: total_cost,
      },
      item: item,
      purchase: purchase,
    };

    res.status(200).json(responseData);
  } catch (error) {
    console.error('Error updating purchase:', error); // Log the caught error for debugging

    // Send a 500 Internal Server Error response with details about the error
    res.status(500).json({ error: 'Error updating purchase. Please try again later.', details: error.message });
  }
});

module.exports = router;