
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;


contract DocumentVerificationSystem {

    // Struct data 
  struct Document {
    string documentName;
    bytes32 documentHash;
}
    // ----- ---- 
    mapping(address => bool) public hasDocuments;
    mapping(address => Document[]) public  documentOwner;
    mapping(bytes32 => bool) public hashRegistered;

    //  Function ---- ---- 
    function registerDocument(string memory _documentName, bytes32 _documentHash) public {
       require(!hashRegistered[_documentHash] , "Document already registered");
    // Store the document hash
        documentOwner[msg.sender].push(Document(_documentName, _documentHash));
        hasDocuments[msg.sender] = true;
        hashRegistered[_documentHash] = true;
    }  
    // 
    function getMyDocuments() public view returns(Document[] memory) {
        return documentOwner[msg.sender];
    }

    function getDocuments(address _owner) public  view returns(Document [] memory) {
        return documentOwner[_owner];
    }
}