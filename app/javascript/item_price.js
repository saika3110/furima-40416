
  const priceInput = document.getElementById("item-price");  
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = Math.floor(inputValue * 0.1); // 10%の手数料を表示する例
    console.log(inputValue);
    const profitDom = document.getElementById("profit"); 
    profitDom.innerHTML = inputValue - addTaxDom.innerHTML;
  });


