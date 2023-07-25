// dataService.js
const pool = require('../services/rsge_db');

async function getRecentSales(limit) {
  const client = await pool.connect();
  const salesQuery = `
    SELECT DISTINCT ON (item_id) *
    FROM sales
    ORDER BY item_id, sell_time DESC
    LIMIT $1
  `;
  const salesResult = await client.query(salesQuery, [limit]);
  client.release();
  return salesResult.rows;
}

async function getRecentPurchases(limit) {
  const client = await pool.connect();
  const purchasesQuery = `
    SELECT DISTINCT ON (item_id) *
    FROM purchases
    ORDER BY item_id, buy_time DESC
    LIMIT $1
  `;
  const purchasesResult = await client.query(purchasesQuery, [limit]);
  client.release();
  return purchasesResult.rows;
}

async function getAllSales() {
  const client = await pool.connect();
  const salesQuery = `
    SELECT *
    FROM sales
    ORDER BY sell_time DESC
  `;
  const salesResult = await client.query(salesQuery);
  client.release();
  return salesResult.rows;
}

async function getAllPurchases() {
  const client = await pool.connect();
  const purchasesQuery = `
    SELECT *
    FROM purchases
    ORDER BY buy_time DESC
  `;
  const purchasesResult = await client.query(purchasesQuery);
  client.release();
  return purchasesResult.rows;
}

async function getItemsByIds(itemIds) {
  const client = await pool.connect();
  const itemsQuery = `
    SELECT *
    FROM items
    WHERE item_id = ANY($1)
  `;
  const itemsResult = await client.query(itemsQuery, [itemIds]);
  client.release();
  return itemsResult.rows;
 
}

module.exports = {
  getRecentSales,
  getRecentPurchases,
  getItemsByIds,
  getAllSales,
  getAllPurchases
};
