// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

interface ITwoKittyFactory {

    function deployer() external view returns (address);

    function initialise_ownership(
        address _feeReceiver,
        address _admin
    ) external;

    /**
     * @notice Deploy a new pool
     * @param _name Name of the new plain pool
     * @param _symbol Symbol for the new plain pool - will be concatenated with factory symbol
     * @return Address of the deployed pool
     */
    function deploy_pool(
        string calldata _name,
        string calldata _symbol,
        address[2] memory _coins,
        uint256 implementation_id,
        uint256 A,
        uint256 gamma,
        uint256 mid_fee,
        uint256 out_fee,
        uint256 fee_gamma,
        uint256 allowed_extra_profit,
        uint256 adjustment_step,
        uint256 ma_exp_time,
        uint256 initial_price
    ) external returns (address);

    /**
     * @notice Deploy a liquidity gauge for a factory pool
     * @param _pool Factory pool address to deploy a gauge for
     * @return Address of the deployed gauge
     */
    function deploy_gauge(address _pool) external returns (address);

    /**
     * @notice Set fee receiver
     * @param _fee_receiver Address that fees are sent to
     */
    function set_fee_receiver(address _fee_receiver) external;

    /**
     * @notice Set pool implementation
     * @dev Set to empty(address) to prevent deployment of new pools
     * @param _pool_implementation Address of the new pool implementation
     * @param _implementation_index Index of the pool implementation
     */
    function set_pool_implementation(
        address _pool_implementation,
        uint256 _implementation_index
    ) external;

    /**
     * @notice Set gauge implementation
     * @dev Set to empty(address) to prevent deployment of new gauges
     * @param _gauge_implementation Address of the new token implementation
     */
    function set_gauge_implementation(address _gauge_implementation) external;

    /**
     * @notice Set views contract implementation
     * @param _views_implementation Address of the new views contract
     */
    function set_views_implementation(address _views_implementation) external;

    /**
     * @notice Set math implementation
     * @param _math_implementation Address of the new math contract
     */
    function set_math_implementation(address _math_implementation) external;

    /**
     * @notice Transfer ownership of this contract to `addr`
     * @param _addr Address of the new owner
     */
    function commit_transfer_ownership(address _addr) external;

    /**
     * @notice Accept a pending ownership transfer
     * @dev Only callable by the new owner
     */
    function accept_transfer_ownership() external;

    /**
     * @notice Find an available pool for exchanging two coins
     * @param _from Address of coin to be sent
     * @param _to Address of coin to be received
     * @param i Index value. When multiple pools are available. This value is used to return the n'th address.
     * @return Pool address
     */
    function find_pool_for_coins(
        address _from,
        address _to,
        uint256 i
    ) external view returns (address);

    /**
     * @notice Find an available pool for exchanging two coins
     * @param _from Address of coin to be sent
     * @param _to Address of coin to be received
     * @return Pool address
     */
    function find_pool_for_coins(
        address _from,
        address _to
    ) external view returns (address);

    function pool_count() external view returns (uint256);

    /**
     * @notice Get the coins within a pool
     * @param _pool Pool address
     * @return List of coin addresses
     */
    function get_coins(address _pool) external view returns (address[] memory);

    function get_decimals(
        address _pool
    ) external view returns (uint256[] memory);

    function get_balances(
        address _pool
    ) external view returns (uint256[] memory);

    /**
     * @notice Convert coin addresses to indices for use with pool methods
     * @param _pool Pool address
     * @param _from Coin address to be used as `i` within a pool
     * @param _to Coin address to be used as `j` within a pool
     * @return uint256 `i`, uint256 `j`
     */
    function get_coin_indices(
        address _pool,
        address _from,
        address _to
    ) external view returns (uint256, uint256);

    /**
     * @notice Get the address of the liquidity gauge contract for a factory pool
     * @dev Returns `empty(address)` if a gauge has not been deployed
     * @param _pool Pool address
     * @return Implementation contract address
     */
    function get_gauge(address _pool) external view returns (address);

    function get_market_counts(
        address coin_a,
        address coin_b
    ) external view returns (uint256);

    function fee_receiver() external view returns (address);

    function pool_implementations(uint256 index) external view returns (address);

    function math_implementation() external view returns (address);

    function views_implementation() external view returns (address);

    function gauge_implementation() external view returns (address);
}
