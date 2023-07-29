const express = require('express');
const router = express.Router();
const pool = require('../public/services/rsge_db_pg');

// DELETE route to delete a sale
router.delete('/:sale_id', async (req, res) => {
  try {
    const saleId = req.params.sale_id;

    // Validate the input data (saleId) to ensure it's a valid number
    if (isNaN(saleId)) {
      return res.status(400).json({ error: 'Invalid input data. Sale ID must be a valid number.' });
    }

    // Check if the sale with the specified ID exists in the database
    const findSaleQuery = 'SELECT * FROM sales WHERE sale_id = $1';
    const { rows } = await pool.query(findSaleQuery, [saleId]);
    const sale = rows[0];

    if (!sale) {
      return res.status(404).json({ error: 'Sale not found. Unable to delete.' });
    }

    // If the sale exists, proceed with the deletion
    const deleteQuery = 'DELETE FROM sales WHERE sale_id = $1';
    await pool.query(deleteQuery, [saleId]);

    res.sendStatus(204); // Success response (No Content)
  } catch (error) {
    console.error('Error deleting sale:', error);
    // Send a more informative error response
    res.status(500).json({ error: 'Error deleting sale. Please try again later.', details: error.message });
  }
});

module.exports = router;
