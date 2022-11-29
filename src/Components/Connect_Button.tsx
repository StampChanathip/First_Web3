import React, { useEffect, useState } from "react";
import styled from "styled-components";
import { ethers } from "ethers";

const Button = styled.button`
   {
    background-color: #3c4049;
    color: aquamarine;
    border-color: #ffffff;
    border-width: 5px;
    border-radius: 15px;
    font-size: 18px;
    width: 250px;
    height: 60px;
    margin-right: 100px;
    cursor: pointer;
  }
`;

export function ConnectWallet() {
  const ethereum = window.ethereum;
  const provider = new ethers.providers.Web3Provider(ethereum);
  const signer = provider.getSigner();

  return (
    <Button
      onClick={() => {
        provider.send("eth_requestAccounts", []);
      }}
    >
      Connect Wallet
    </Button>
  );
}
