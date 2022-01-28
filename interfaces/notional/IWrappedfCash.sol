// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.0;

import {TokenType} from "../../contracts/lib/Types.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin-upgradeable/contracts/token/ERC777/IERC777Upgradeable.sol";

interface IWrappedfCash {

    function mintFromUnderlying(uint256 fCashAmount, address receiver) external;
    function mintFromAsset(uint256 fCashAmount, address receiver) external;
    function redeem(uint256 amount, bytes memory data) external;
    function operatorRedeem(address account, uint256 amount, bytes memory data, bytes memory operatorData) external;

    /// @notice Returns the underlying fCash ID of the token
    function getfCashId() external view returns (uint256);

    /// @notice Returns the underlying fCash maturity of the token
    function getMaturity() external view returns (uint40 maturity);

    /// @notice True if the fCash has matured, assets mature exactly on the block time
    function hasMatured() external view returns (bool);

    /// @notice Returns the underlying fCash currency
    function getCurrencyId() external view returns (uint16 currencyId);

    /// @notice Returns the components of the fCash idd
    function getDecodedID() external view returns (uint16 currencyId, uint40 maturity);

    /// @notice Returns the current market index for this fCash asset. If this returns
    /// zero that means it is idiosyncratic and cannot be traded.
    function getMarketIndex() external view returns (uint8);

    /// @notice Returns the token and precision of the token that this token settles
    /// to. For example, fUSDC will return the USDC token address and 1e6. The zero
    /// address will represent ETH.
    function getUnderlyingToken() external view returns (IERC20 underlyingToken, int256 underlyingPrecision);

    /// @notice Returns the asset token which the fCash settles to. This will be an interest
    /// bearing token like a cToken or aToken.
    function getAssetToken() external view returns (IERC20 underlyingToken, int256 underlyingPrecision, TokenType tokenType);
}


interface IWrappedfCashComplete is IWrappedfCash, IERC777Upgradeable {} 