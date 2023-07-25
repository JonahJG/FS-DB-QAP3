
const express = require('express');
const router = express.Router();
const { getItemsByIds, getAllPurchases } = require('../services/dataService');

router.get('/', async (req, res) => {
  try {

    // Fetch recent sales using the dataService function
    const purchases = await getAllPurchases();

    const itemIds = purchases.map((purchase) => purchase.item_id);
  

    // Fetch items using the dataService function
    const items = await getItemsByIds(itemIds);

    // Mapping sales with their corresponding items
    const purchasesWithItems = purchases.map((purchase) => {
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
        total_cost: purchase.total_cost
      };
    });

    if(DEBUG)console.log('Purchases With Items:', purchasesWithItems); 

    res.render('purchases-all', { purchases: purchasesWithItems });
  } catch (error) {
    console.error('Error fetching purchases data:', error);
    res.status(500).send('Error fetching purchases data. Please try again later.');
  }
});

module.exports = router;
