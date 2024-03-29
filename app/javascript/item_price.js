
  
  window.addEventListener('turbo:load', () => {
  const priceInput = document.getElementById("item-price");  
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = Math.floor(inputValue * 0.1); // 10%の手数料を表示する例
    const profitDom = document.getElementById("profit"); 
    profitDom.innerHTML = Math.floor(inputValue - addTaxDom.innerHTML);
  });
  })

