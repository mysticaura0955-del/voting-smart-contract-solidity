// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Candidate {
   struct Candidatesdata {
      string name;
      uint256 id ;
      uint256 totalVotes ;
      bool exists ;
   }

   address public owner;
   mapping(uint=>Candidatesdata) Data ;
   mapping(address=>bool) hasvoted;
   uint totalcandidates ;
   constructor() {
      owner = msg.sender;
     }

    modifier onlyowner() {
      require(msg.sender == owner , "not an owner");
      _;
    }
   
   function addCandidate(string memory name ,uint id) public onlyowner {
      require(Data[id].exists == false, "candidate exists");
       Data[id] = Candidatesdata({
         name: name,
         id: id, 
         totalVotes: 0 ,
         exists: true });
         totalcandidates++;}
     
     function vote(uint id) public {
      require(hasvoted[msg.sender] == false, "vote already casted");
      require(Data[id].exists, "candidate does not exists");
       Data[id].totalVotes++ ;
       hasvoted[msg.sender] = true;
       }

       function getwinner() public view returns (Candidatesdata memory) {
         uint highestvote ;
         uint winnerid ;
         require(totalcandidates > 0, "no candidates found");
         for (uint i = 1; i <= totalcandidates ; i++ ) 
         {
            if (Data[i].totalVotes > highestvote ) {
               highestvote = Data[i].totalVotes ;
               winnerid = i; 
            }
           }
             return Data[winnerid] ;
             }
}