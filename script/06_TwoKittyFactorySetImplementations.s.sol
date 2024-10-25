// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {ITwoKittyFactory} from "../src/interfaces/ITwoKittyFactory.sol";
import {Consts} from "./Consts.sol";

/*
    forge script ./script/06_TwoKittyFactorySetImplementations.s.sol:TwoKittyFactorySetImplementationsScript --rpc-url <your-rpc-url> -vvv --broadcast

    --broadcast to send the tx to the network
    -vvv to see the logs
*/
contract TwoKittyFactorySetImplementationsScript is Script, Consts {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint(PARAM_PK_ACCOUNT);
        ITwoKittyFactory _factory = ITwoKittyFactory(address(0x0));
        uint256 _poolImplId = 0;
        address _poolImpl = address(0x0);
        address _mathImpl = address(0x0);
        address _viewImpl = address(0x0);
        address _gaugeImpl = address(0x0);

        console.log("Factory:       ", address(_factory));
        console.log("Fee receiver:  ", _factory.fee_receiver());

        console.log("Starting script: broadcasting");
        vm.startBroadcast(deployerPrivateKey);

        _factory.set_pool_implementation(_poolImpl, _poolImplId);
        _factory.set_math_implementation(_mathImpl);
        _factory.set_views_implementation(_viewImpl);
        _factory.set_gauge_implementation(_gaugeImpl);

        require(_factory.pool_implementations(_poolImplId) == _poolImpl, "Pool implementation not set");
        require(_factory.math_implementation() == _mathImpl, "Math implementation not set");
        require(_factory.views_implementation() == _viewImpl, "Views implementation not set");
        require(_factory.gauge_implementation() == _gaugeImpl, "Gauge implementation not set");
        require(_factory.fee_receiver() != address(0), "Fee receiver not set");

        vm.stopBroadcast();
        console.log("TwoKittyFactory instance implementations set properly...");
    }
}
