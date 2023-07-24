// app.js
const express = require('express');
const app = express();
const PORT = 3000;
const { getRecentSales, getRecentPurchases, getItemsByIds } = require('./services/dataService');
// Require the history router
const historyRouter = require('./routes/history');
const salesAllRouter = require('./routes/sales-allRouter'); 

app.set('view engine', 'ejs');
app.set('views', 'views'); // Set the views directory

// Serve static files from the "public" folder
app.use(express.static('public'));

app.get('/', async (req, res) => {
  try {
    const limit = 5;

    // Fetch recent sales and purchases using the dataService functions
    const sales = await getRecentSales(limit);
    const purchases = await getRecentPurchases(limit);

    const itemIds = [...new Set([...sales.map((sale) => sale.item_id), ...purchases.map((purchase) => purchase.item_id)])];

    // Fetch items using the dataService function
    const items = await getItemsByIds(itemIds);

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

    const recentlyPurchasedItems = purchases.map((purchase) => {
      const { item_id, buy_price, buy_time } = purchase;
      const item = items.find((item) => item.item_id === item_id);
      return {
        item_id,
        buy_price,
        buy_time,
        item_name: item ? item.item_name : '',
        item_description: item ? item.item_description : '',
        item_price: item ? item.item_price : '',
        amt_bought: purchase.amt_bought,
        total_price: purchase.total_cost
      };
    });

    res.render('./index', {
      soldItems: recentlySoldItems,
      purchasedItems: recentlyPurchasedItems,
      sales: sales,
      purchases: purchases,
      items: items
    });
  } catch (error) {
    console.error('Error fetching data:', error);
  }
});

// Use the history router for the /history route
app.use('/history', historyRouter);

app.use('/sales-all', salesAllRouter);

app.listen(PORT, () => {
  console.log(`Runescape Flipping Tracker is running on port ${PORT}.`);
});
