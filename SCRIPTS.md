# List of Scripts

## RPCs

Testnet: https://testnet.evm.nodes.onflow.org
Mainnet: https://mainnet.evm.nodes.onflow.org

## Scripts

### Deploy KittyMathOptimized2

forge script ./script/01_KittyMathOptimized2Deploy.s.sol:KittyMathOptimized2DeployScript --rpc-url <rpc-url> -vvv --broadcast

### Deploy KittyViewOptimized2

forge script ./script/02_KittyViewOptimized2Deploy.s.sol:KittyViewOptimized2DeployScript --rpc-url <rpc-url> -vvv --broadcast

### Deploy TwoKittyOptimized

forge script ./script/03_TwoKittyOptimizedDeploy.s.sol:TwoKittyOptimizedDeployScript --rpc-url <rpc-url> -vvv --broadcast

### Deploy KittyLiquidityGauge (Optional)

forge script ./script/04_KittyLiquidityGaugeDeploy.s.sol:KittyLiquidityGaugeDeployScript --rpc-url <rpc-url> -vvv --broadcast

### Deploy TwoKittyFactory

forge script ./script/05_TwoKittyFactoryDeploy.s.sol:TwoKittyFactoryDeployScript --rpc-url <rpc-url> -vvv --broadcast

### Set TwoKittyFactory Implementations

forge script ./script/06_TwoKittyFactorySetImplementations.s.sol:TwoKittyFactorySetImplementationsScript --rpc-url <rpc-url> -vvv --slow --legacy --broadcast

### Deploy Pool

npx ts-node ./script/07_TwoKittyFactoryDeployPool.ts

### Add Liquidity

forge script ./script/08_TwoKittyFactoryAddLiquidity.s.sol:TwoKittyFactoryAddLiquidityScript --rpc-url <rpc-url> -vvv --slow --legacy --broadcast
