// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {Consts} from "./Consts.sol";

/*
    forge script ./script/02_KittyViewOptimized2Deploy.s.sol:KittyViewOptimized2DeployScript --rpc-url <your-rpc-url> -vvv --broadcast

    --broadcast to send the tx to the network
    -vvv to see the logs
*/
contract KittyViewOptimized2DeployScript is Script, Consts {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint(PARAM_PK_ACCOUNT);
        string memory contractName = KITTY_VIEWS_OPTIMIZED_2;

        console.log("Starting script: broadcasting");
        vm.startBroadcast(deployerPrivateKey);

        address instance = deployCode(contractName);

        vm.stopBroadcast();
        console.log(
            string.concat(contractName, ":    "),
            instance
        );
    }
}
