// the button to connect to an ethereum wallet
const buttonEthConnect = document.querySelector('button.eth_connect');

// the read-only eth fields, we process them automatically
const formInputEthNonce = document.querySelector('input.eth_nonce');
const formInputEthAddress = document.querySelector('input.eth_address');
const formInputEthSignature = document.querySelector('input.eth_signature');

// disable the submit button until we have everything
const formInputEthSubmit = document.querySelector('input.eth_submit');
formInputEthSubmit.disabled = true;

// only proceed with ethereum context available
if (typeof window.ethereum !== 'undefined') {
  buttonEthConnect.addEventListener('click', async () => {
    buttonEthConnect.disabled = true;

    // request accounts from ethereum provider
    const accounts = await requestAccounts();
    const etherbase = accounts[0];
    formInputEthAddress.value = etherbase;

    // sign a random uuid nonce
    const nonce = generate_uuid_v4();
    formInputEthNonce.value = nonce;
    const signature = await personal_sign(etherbase, nonce);

    // populate, display, and enable form
    formInputEthSignature.value = signature;
    formInputEthSubmit.disabled = false;
});
} else {
  // disable form submission in case there is no ethereum wallet available
  buttonEthConnect.innerHTML = "No Ethereum Context Available";
  buttonEthConnect.disabled = true;
}

// request ethereum wallet access and approved accounts[]
async function requestAccounts() {
  const accounts = await ethereum.request({ method: 'eth_requestAccounts' });
  return accounts;
}

// request ethereum signature for message from account
async function personal_sign(account, message) {
  const signature = await ethereum.request({ method: 'personal_sign', params: [ message, account ] });
  return signature;
}

// generate a random uuid that the user can sign
function generate_uuid_v4() {
  return ([1e7]+-1e3+-4e3+-8e3+-1e11).replace(/[018]/g, c =>
    (c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> c / 4).toString(16)
  );
}
