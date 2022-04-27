// SPDX-License-Identifier: MIT

pragma solidity ^0.5.16;
// pragma solidity ^0.4.18;

import "github.com/provable-things/ethereum-api/provableAPI_0.5.sol";

contract ExampleContract is usingProvable {

   string public ETHUSD;
   event LogConstructorInitiated(string nextStep);
   event LogPriceUpdated(string price);
   event LogNewProvableQuery(string description);
   event LogForUnit256(uint256 integer);

   function Constructor() public payable {
       emit LogConstructorInitiated("Constructor was initiated. Call updatePrice() to send the Provable Query.");
   }


    event StringFailure(string stringFailure);
    event BytesFailure(bytes bytesFailure);

    function apiCall() public payable  {
        emit LogForUnit256(provable_getPrice("URL"));
        emit LogForUnit256(address(this).balance);
        emit LogForUnit256(msg.sender.balance);

       if (provable_getPrice("URL") > address(this).balance) {
           emit LogNewProvableQuery("Provable query was NOT sent, please add some ETH to cover for the query fee");
       } else {
           emit LogNewProvableQuery("Provable query was sent, standing by for the answer..");
            provable_query("URL", "json(https://wm25qhyh08.execute-api.ap-northeast-1.amazonaws.com/test/reveal/1).price");
       }
    }

   function __callback(bytes32 myid, string memory result) public {
       emit LogNewProvableQuery("Here is __callback function");
       emit LogPriceUpdated(result);
       //if (msg.sender != provable_cbAddress()) revert();
       ETHUSD = result;
       emit LogPriceUpdated(result);
   }

   function updatePrice() public payable {
        emit LogForUnit256(provable_getPrice("URL"));
        emit LogForUnit256(address(this).balance);
        emit LogForUnit256(msg.sender.balance);

       if (provable_getPrice("URL") > address(this).balance) {
           emit LogNewProvableQuery("Provable query was NOT sent, please add some ETH to cover for the query fee");
       } else {
           emit LogNewProvableQuery("Provable query was sent, standing by for the answer..");
           provable_query("URL", "json(https://api.pro.coinbase.com/products/ETH-USD/ticker).price");
       }
   }
}