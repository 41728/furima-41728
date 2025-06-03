const pay = () => {
  // 要素がなければ即終了（購入ページ以外）
  const form = document.getElementById('charge-form');
  const numberForm = document.getElementById('number-form');
  const expiryForm = document.getElementById('expiry-form');
  const cvcForm = document.getElementById('cvc-form');

  if (!form || !numberForm || !expiryForm || !cvcForm) return;

  // 2回目以降の実行防止
  if (window.payjpInitialized) return;
  window.payjpInitialized = true;

  const publicKey = gon.public_key
  const payjp = Payjp(publicKey) // PAY.JPテスト公開鍵
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  form.addEventListener("submit", (e) => {
    e.preventDefault();
    payjp.createToken(numberElement).then((response) => {
      if (!response.error) {
        const token = response.id;
        const tokenObj = `<input value="${token}" name='order_address[token]' type="hidden">`;
        form.insertAdjacentHTML("beforeend", tokenObj);
      }
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
      form.submit();
    });
  });
};

window.addEventListener("turbo:load", pay);
