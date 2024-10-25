// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {MockToken} from "./mocks/MockToken.sol";
import {ITwoKittyFactory} from "../src/interfaces/ITwoKittyFactory.sol";
import {VyperDeployer} from "./utils/VyperDeployer.sol";
import {Consts} from "../script/Consts.sol";

abstract contract TwoKittyFactoryUtils is Test, Consts {
    VyperDeployer internal deployer;

    function setUp() public virtual {
        deployer = new VyperDeployer();
    }

    function _deployFactory(
        address _feeReceiver,
        address _owner
    ) internal returns (ITwoKittyFactory) {
        address _kittyMathOptimized2 = _deployKittyMathOptimized2(_owner);
        address _kittyViewsOptimized2 = _deployKittyViewsOptimized2(_owner);
        address _twoKittyOptimized = _deployTwoKittyOptimized(_owner);
        address _kittyLiquidityGauge = _deployKittyLiquidityGauge(_owner);
        ITwoKittyFactory _twoKittyFactory = ITwoKittyFactory(
            _deployTwoKittyFactory(_feeReceiver, _owner)
        );

        vm.startPrank(_owner);
        _twoKittyFactory.set_pool_implementation(_twoKittyOptimized, 0);
        _twoKittyFactory.set_math_implementation(_kittyMathOptimized2);
        _twoKittyFactory.set_views_implementation(_kittyViewsOptimized2);
        _twoKittyFactory.set_gauge_implementation(_kittyLiquidityGauge);
        vm.stopPrank();
        return _twoKittyFactory;
    }

    function _deployKittyMathOptimized2(
        address _owner
    ) internal returns (address) {
        vm.startPrank(_owner);
        address instance = deployCode(KITTY_MATH_OPTIMIZED_2);
        vm.stopPrank();
        return instance;
    }

    function _deployKittyViewsOptimized2(
        address _owner
    ) internal returns (address) {
        vm.startPrank(_owner);
        address instance = deployCode(KITTY_VIEWS_OPTIMIZED_2);
        vm.stopPrank();
        return instance;
    }

    function _deployKittyLiquidityGauge(
        address _owner
    ) internal returns (address) {
        vm.startPrank(_owner);
        bytes memory bytecodeBlueprint = deployer.getDeployBytecodeBlueprint(
            KITTY_LIQUIDITY_GAUGE,
            DEFAULT_EVM_VERSION,
            OPTIMIZE_GAS
        );
        address instance = _deployCode(bytecodeBlueprint, "");
        vm.stopPrank();
        return instance;
    }

    function _deployTwoKittyOptimized(
        address _owner
    ) internal returns (address) {
        vm.startPrank(_owner);
        bytes memory bytecodeBlueprint = deployer.getDeployBytecodeBlueprint(
            TWO_KITTY_OPTIMIZED,
            DEFAULT_EVM_VERSION,
            OPTIMIZE_GAS
        );
        address instance = _deployCode(bytecodeBlueprint, "");
        vm.stopPrank();
        return instance;
    }

    function _deployCode(
        bytes memory bytecode,
        bytes memory args
    ) internal virtual returns (address addr) {
        uint256 val = 0;
        bytes memory bytecodeWithArgs;
        if (args.length == 0) {
            bytecodeWithArgs = bytecode;
        } else {
            bytecodeWithArgs = abi.encodePacked(bytecode, args);
        }
        /// @solidity memory-safe-assembly
        assembly {
            addr := create(
                val,
                add(bytecodeWithArgs, 0x20),
                mload(bytecodeWithArgs)
            )
        }

        require(
            addr != address(0),
            "CustomUtils deployCode(bytes,bytes): Deployment failed."
        );
    }

    function _deployTwoKittyFactory(
        address _feeReceiver,
        address _owner
    ) internal returns (address) {
        vm.startPrank(_owner);
        address instance = deployCode(TWO_KITTY_FACTORY, "");
        ITwoKittyFactory _factory = ITwoKittyFactory(instance);
        console.log("Deployer:       ", _factory.deployer());
        _factory.initialise_ownership(_feeReceiver, _owner);
        vm.stopPrank();
        return instance;
    }
}
