const express = require('express');
const router = express.Router();
const { Pool } = require('pg');
const pool = require('../public/services/rsge_db_pg');

router.put('/:sale_id', async (req, res) => {
  try {
    const saleId = req.params.sale_id;
    const { sell_price, sell_time, amt_sold, total_price } = req.body; // Updated property names

    // Validate the input data
    if (isNaN(sell_price) || isNaN(amt_sold) || isNaN(total_price)) {
      return res.status(400).send('Invalid input data. Please provide valid values for the sale.');
    }

    // Log the received values
    console.log('Received PUT request with sale_id:', saleId);
    console.log('Received PUT request body:', req.body);

    // Update the sale data in the database
    const updateQuery =
      'UPDATE sales SET sell_price = $1, sell_time = $2, amt_sold = $3, total_price = $4 WHERE sale_id = $5';
    console.log('Executing updateQuery:', updateQuery);

    await pool.query(updateQuery, [sell_price, sell_time, amt_sold, total_price, saleId]);

    // Fetch the updated sale data from the database
    const selectUpdatedSaleQuery = 'SELECT * FROM sales WHERE sale_id = $1';
    const { rows } = await pool.query(selectUpdatedSaleQuery, [saleId]);
    const updatedSale = rows[0];
    console.log('Updated Sale:', updatedSale);

    // Send the updatedSale data back to the client
    res.status(200).json({ message: 'Sale record updated successfully.', updatedSale });
  } catch (error) {
    console.error('Error updating sale:', error); // Log the caught error for debugging

    // Send a 500 Internal Server Error response with details about the error
    res.status(500).json({ error: 'Error updating sale. Please try again later.', details: error.message });
  }
});

module.exports = router;