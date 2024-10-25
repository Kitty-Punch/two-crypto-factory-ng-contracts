// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {console2 as console} from "forge-std/console2.sol";
import {VyperDeployer} from "../test/utils/VyperDeployer.sol";

abstract contract Consts {
    string public constant PARAM_PK_ACCOUNT = "PK_ACCOUNT";
    string public constant PARAM_OWNER = "OWNER";
    string public constant TWO_KITTY_FACTORY = "TwoKittyFactory";
    string public constant TWO_KITTY_OPTIMIZED = "TwoKittyOptimized";
    string public constant KITTY_MATH_OPTIMIZED_2 = "KittyMathOptimized2";
    string public constant KITTY_VIEWS_OPTIMIZED_2 = "KittyViewOptimized2";
    string public constant KITTY_LIQUIDITY_GAUGE = "KittyLiquidityGauge";
    string public constant DEFAULT_EVM_VERSION = "paris";
    string public constant OPTIMIZE_GAS = "gas";
    string public constant OPTIMIZE_CODESIZE = "codesize";
    bool public constant NO_PRINT_BYTECODE = false;
    bool public constant PRINT_BYTECODE = true;


    function _getBytecodeBlueprint(
        string memory _contractName,
        string memory _optimizeStrategy,
        bool _printBytecode
    ) internal returns (bytes memory) {
        VyperDeployer deployer = new VyperDeployer();
        console.log("Getting bytecode blueprint for: ", _contractName);
        bytes memory bytecodeBlueprint = deployer.getDeployBytecodeBlueprint(
            _contractName,
            DEFAULT_EVM_VERSION,
            _optimizeStrategy
        );
        if (_printBytecode) {
            console.log(
                "<<<<<<<<<<<<<<<<<<<<< START bytecode blueprint >>>>>>>>>>>>>>>>>>>>>"
            );
            console.logBytes(bytecodeBlueprint);
            console.log(
                "<<<<<<<<<<<<<<<<<<<<< END bytecode blueprint >>>>>>>>>>>>>>>>>>>>>"
            );
        }
        console.log("Contract codesize: ", bytecodeBlueprint.length);
        return bytecodeBlueprint;
    }
}
