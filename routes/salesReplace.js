document.addEventListener('DOMContentLoaded', () => {
    const replaceSaleButtons = document.querySelectorAll('.replace-sale-btn');
  
    replaceSaleButtons.forEach(button => {
      button.addEventListener('click', async () => {
        const index = button.dataset.index;
        const saleId = button.dataset.saleId; // Get the sale ID from the button's data attribute
        const salePriceInput = document.getElementById(`sale-price-replace-${index}`);
        const amtSoldInput = document.getElementById(`amt-sold-replace-${index}`);
        const totalPriceInput = document.getElementById(`total-price-replace-${index}`);
  
        // Validate the input data
        if (isNaN(salePriceInput.value) || isNaN(amtSoldInput.value) || isNaN(totalPriceInput.value)) {
          alert('Invalid input data. Please provide valid values for the sale.');
          return;
        }
  
        // Create a JavaScript object representing the payload
        const payload = {
          sell_price: parseFloat(salePriceInput.value),
          amt_sold: parseInt(amtSoldInput.value),
          total_price: parseFloat(totalPriceInput.value),
        };
  
        try {
          const response = await fetch(`/api/sales/${saleId}`, {
            method: 'PUT', // Use PUT method for replacing a sale
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify(payload), // Convert the payload to a JSON string
          });
  
          if (response.ok) {
            location.reload(); // Sale replaced successfully, refresh the page
          } else {
            // Handle error if the server returns an error
            console.error('Error replacing sale:', response.status, response.statusText);
          }
        } catch (error) {
          // Handle network or other errors
          console.error('Error replacing sale:', error.message);
        }
      });
    });
  });
  