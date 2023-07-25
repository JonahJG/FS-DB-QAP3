
const express = require('express');
const router = express.Router();
const { getAllSales, getItemsByIds } = require('../services/dataService');

router.get('/', async (req, res) => {
  try {

    // Fetch recent sales using the dataService function
    const sales = await getAllSales();

    const itemIds = sales.map((sale) => sale.item_id);
  

    // Fetch items using the dataService function
    const items = await getItemsByIds(itemIds);

    if(DEBUG)console.log('Items:', items);
    if(DEBUG)console.log('Sales:', sales);

    // Mapping sales with their corresponding items
    const salesWithItems = sales.map((sale) => {
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

    if(DEBUG)console.log('Sales With Items:', salesWithItems); 

    res.render('sales-all', { sales: salesWithItems });
  } catch (error) {
    console.error('Error fetching sales data:', error);
    res.status(500).send('Error fetching sales data. Please try again later.');
  }
});

module.exports = router;
