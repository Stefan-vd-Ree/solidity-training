const ethers = require('ethers');

// Replace with your actual private key
const privateKey = '0x83485dec5e7172920d22e6945311aba8a78c33b7428ec06a064fa9d0a69661ce';

// Create a wallet instance using the private key
const wallet = new ethers.Wallet(privateKey);

async function signMessage(signer, keyArray, valueArray, playerPubKey) {
    try {
        if (keyArray.length !== valueArray.length) {
			throw new Error("Arrays must have the same length");
		}
		
		const concatenatedArray = keyArray.map((item, index) => `${item}${valueArray[index]}`).join("");
		const concatenatedArrayWithPubKey = concatenatedArray + playerPubKey;
		const concatenatedHash = ethers.utils.solidityKeccak256(["string"], [concatenatedArrayWithPubKey]);
		const signature = await signer.signMessage(ethers.utils.arrayify(concatenatedHash));

		
		console.log('concatenatedArray:', concatenatedArray);
		console.log('concatenatedArrayWithPubKey:', concatenatedArrayWithPubKey);
		console.log('concatenatedHash:', concatenatedHash);
		console.log('Signature:', signature);
		
    } catch (error) {
        console.error('Error signing message:', error);
        throw error; // Rethrow the error to propagate it
    }
}
const keyArray64Data = process.argv[2];
const keyArrayDecodedData = Buffer.from(keyArray64Data, 'base64');
const keyArray = JSON.parse(keyArrayDecodedData);

const valueArray64Data = process.argv[3];
const valueArrayDecodedData = Buffer.from(valueArray64Data, 'base64');
const valueArray = JSON.parse(valueArrayDecodedData);

const playerPubKey = process.argv[4];

console.log('provided keyArray:', keyArray);
console.log('provided valueArray:', valueArray);
console.log('provided playerPubKey:', playerPubKey);

signMessage(wallet, keyArray, valueArray, playerPubKey)