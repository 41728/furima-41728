window.addEventListener('turbo:load', () => {
  const priceInput = document.querySelector('input[name="item[price]"]');
  const feeDisplay = document.getElementById("add-tax-price");
  const profitDisplay = document.getElementById("profit");

  if (!priceInput) return;

  priceInput.addEventListener("input", () => {
    const price = parseInt(priceInput.value, 10);
    if (price >= 300 && price <= 9999999) {
      const fee = Math.floor(price * 0.1);
      const profit = price - fee;
      feeDisplay.textContent = fee;
      profitDisplay.textContent = profit;
    } else {
      feeDisplay.textContent = 0;
      profitDisplay.textContent = 0;
    }
  });
});
