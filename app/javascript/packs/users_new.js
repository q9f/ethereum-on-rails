// the button to connect to an ethereum wallet
const buttonEthConnect = document.querySelector('button.eth_connect');

// the read-only eth address field, we process that automatically
const formInputEthAddress = document.querySelector('input.eth_address');

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

    // populate, display, and enable form
    formInputEthAddress.value = etherbase;
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
