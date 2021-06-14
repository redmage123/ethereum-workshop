/*
A script that will sign and broadcast an ethereum transaction to the network, then shows the result in the console.
WARNING!
If executed this script will send ether, be sure the info is correct before you run this!
Alternatively you should use a test net with test ether first before running this on the main net.
For an explanation of this code, navigate to the wiki https://github.com/ThatOtherZach/Web3-by-Example/wiki/Send-Ether-Transaction
*/

// Add the web3 node module
var Web3 = require('web3');

// Show web3 where it needs to look for the Ethereum node.
web3 = new Web3(new Web3.providers.HttpProvider('https://ropsten.infura.io/v3/76343c23c10e4dcaae9bec52cd39bec4'));

// An extra module is required for this, use npm to install before running
var Tx = require('ethereumjs-tx').Transaction;

// Used to sign the transaction. Obviously you SHOULD better secure this than just plain text
var privateKey = new Buffer('defff155f3cdfd9035dfec1ad7d439863c9205aaf02b311e866d7e3501e069bc', 'hex');

 // The receiviing address of the transaction
var receivingAddr = ('0x23E7c23764BAc3a410Dba35FcE9cAd80a5D8a8e0');

// The number of transactions for the senders address. 


// Value to be sent, converted to wei and then into a hex value
var txValue = web3.utils.numberToHex(web3.utils.toWei('1', 'ether'));

// Data to be sent in transaction, converted into a hex value. Normal tx's do not need this and use '0x' as default, but who wants to be normal?
var txData = web3.utils.asciiToHex('Test transaction.'); 

var rawTx = {
  nonce: '0x1', // Nonce is the times the address has transacted, should always be higher than the last nonce 0x0#
  gasPrice: '0x14f46b0400', // Normal is '0x14f46b0400' or 90 GWei
  gasLimit: '0x55f0', // Limit to be used by the transaction, default is '0x55f0' or 22000 GWei
  to: receivingAddr, // The receiving address of this transaction
  value: txValue, // The value we are sending '0x16345785d8a0000' which is 0.1 Ether
  data: txData // The data to be sent with transaction, '0x6f6820686169206d61726b' or 'oh hai mark' 
}

//console.log(rawTx); // This is used for testing to see if the rawTx was formmated created properly, comment out the code below to use.


var tx = new Tx(rawTx, {'chain':'ropsten'});
tx.sign(privateKey); // Here we sign the transaction with the private key

var serializedTx = tx.serialize(); // Clean things up a bit

console.log(serializedTx.toString('hex')); // Log the resulting raw transaction hex for debugging if it fails to send

web3.eth.sendSignedTransaction('0x' + serializedTx.toString('hex')) // Broadcast the transaction to the network
.on('receipt', console.log); // When a receipt is issued, log it to the console
