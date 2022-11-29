import React, { useEffect } from "react";
import "./App.css";
import abi from "./Utils/Lottery.json";
import { ethers } from "ethers";

function App() {
  const ethereum = window.ethereum;
  const provider = new ethers.providers.Web3Provider(ethereum);
  const signer = provider.getSigner();
  provider.send("eth_requestAccounts", []); // Make sure user always connect wallet

  const contractAddress = "0xD4B49f4C3B9A3133e21e5b9E4630C97C142C5073";
  const contractABI = abi.abi;
  const Lottery = new ethers.Contract(contractAddress, contractABI, signer);

  return (
    <div className="App">
      <div className="Box">
        <button
          onClick={() => {
            Lottery.attendLottery({ value: 2 });
            console.log("lottery attended");
          }}
          className="mainButton"
        >
          Attend Lottery
        </button>
        <button
          className="sideButton"
          onClick={() => {
            Lottery.randomWinner();
            console.log("start random");
          }}
        >
          Start Random
        </button>
        <div className="text">Total prize pool: 1 ETH</div>
      </div>
    </div>
  );
}

export default App;
