// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";

import "openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import "openzeppelin-contracts/contracts/proxy/beacon/UpgradeableBeacon.sol";

import "../src/ShibuyaImplV1.sol";
import "../src/MuseumImplV1.sol";
import "../src/CollectionImplV1.sol";


contract DeployScriptV1 is Script {
    function run() public {
        address collectionImpl = address(new CollectionImplV1());
        address collectionBeacon = address(new UpgradeableBeacon(collectionImpl));

        address museumImpl = address(new MuseumImplV1());
        address museumBeacon = address(new UpgradeableBeacon(museumImpl));

        address shibuyaImpl = address(new ShibuyaImplV1());
        address shibuyaProxy = address(new ERC1967Proxy(shibuyaImpl, abi.encodeWithSignature(
            "initialize(address,address)",
            museumBeacon,
            collectionBeacon
        )));

        vm.broadcast();
    }
}