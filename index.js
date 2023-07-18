const express = require('express');
const app = express();
const PORT = 3000;
const pool = require('./services/rsge_db')

app.set('view engine', 'ejs');
app.set('views', 'views'); // Set the views directory

// Serve static files from the "public" folder
app.use(express.static('public'));


app.get('/', async (req, res) => {
  try {
    const client = await pool.connect();

    const salesQuery = `
      SELECT DISTINCT ON (item_id) *
      FROM sales
      ORDER BY item_id, sell_time DESC
      LIMIT 5
    `;
    const salesResult = await client.query(salesQuery);
    const sales = salesResult.rows;

    const itemIds = sales.map((sale) => sale.item_id);

    const itemsQuery = `
      SELECT *
      FROM items
      WHERE item_id = ANY($1)
    `;
    const itemsResult = await client.query(itemsQuery, [itemIds]);
    const items = itemsResult.rows;

    const recentlySoldItems = sales.map((sale) => {
      const { item_id, sell_price, sell_time } = sale;
      const item = items.find((item) => item.item_id === item_id);
      return {
        item_id,
        sell_price,
        sell_time,
        item_name: item ? item.item_name : '',
        item_description: item ? item.item_description : '',
        item_price: item ? item.item_price : '',
        amt_sold: sale.amt_sold,
        total_price: sale.total_price
      };
    });

    client.release();

    res.render('./index', { items: recentlySoldItems, sales: sales }); // Pass both items and sales data to the template
  } catch (error) {
    console.error('Error fetching data:', error);
  }
});


app.listen(PORT, () => {
  console.log(`Runescape Flipping Tracker is running on port ${PORT}.`);
});

