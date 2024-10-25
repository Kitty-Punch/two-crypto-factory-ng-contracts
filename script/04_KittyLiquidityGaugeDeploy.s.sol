// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {Consts} from "./Consts.sol";

/*
    forge script ./script/04_KittyLiquidityGaugeDeploy.s.sol:KittyLiquidityGaugeDeployScript --rpc-url <your-rpc-url> -vvv --broadcast

    --broadcast to send the tx to the network
    -vvv to see the logs
*/
contract KittyLiquidityGaugeDeployScript is Script, Consts {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint(PARAM_PK_ACCOUNT);
        string memory contractName = KITTY_LIQUIDITY_GAUGE;

        bytes memory deployBytecode = _getBytecodeBlueprint(
            contractName,
            OPTIMIZE_GAS,
            NO_PRINT_BYTECODE
        );
        console.log("Starting script: broadcasting");
        vm.startBroadcast(deployerPrivateKey);

        address instance;
        assembly {
            instance := create(
                0,
                add(deployBytecode, 0x20),
                mload(deployBytecode)
            )
        }

        require(instance != address(0), "Could not deploy contract");

        vm.stopBroadcast();
        console.log(string.concat(contractName, ":  "), instance);
    }
}
