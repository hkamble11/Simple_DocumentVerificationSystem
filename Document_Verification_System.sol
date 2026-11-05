// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;


contract DocumentVerificationSystem {

    // Struct data 
  struct Document {
    string documentName;
    bytes32 documentHash;
    bool isValid;
}
    // ----- ----- ----- -----
    mapping(address => bool) public hasDocuments;
    mapping(address => Document[]) public  documentOwner;
    mapping(bytes32 => bool) public hashRegistered;
    mapping(bytes32 => bool) public documentValidity;
    //  Function ---- ---- 
    function registerDocument(string memory _documentName, bytes32 _documentHash) public {
       require(!hashRegistered[_documentHash] , "Document already registered");
    // Store the document hash
        documentOwner[msg.sender].push(Document(_documentName, _documentHash, true));
        hasDocuments[msg.sender] = true;
        hashRegistered[_documentHash] = true;
        documentValidity[_documentHash] = true;
    }  
    // 
    function getMyDocuments() public view returns(Document[] memory) {
        return documentOwner[msg.sender];
    }

    function getDocuments(address _owner) public  view returns(Document [] memory) {
        return documentOwner[_owner];
    }
    //
    function verifyDocument(bytes32 _documentHash) public view returns (bool) {
        return documentValidity[_documentHash];
    }
    //
    function revokeDocument(uint256 _index) public {
        require(documentOwner[msg.sender][_index].isValid,"Document already revoked");
        require(_index < documentOwner[msg.sender].length, "Revoked the data");
        documentOwner[msg.sender][_index].isValid = false;
        documentValidity[documentOwner[msg.sender][_index].documentHash] = false;
    }
}