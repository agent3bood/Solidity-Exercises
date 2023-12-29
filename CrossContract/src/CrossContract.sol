// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract CrossContract {
    /**
     * The function below is to call the price function of PriceOracle1 and PriceOracle2 contracts below and return the lower of the two prices
     */

    function getLowerPrice(
        address _priceOracle1,
        address _priceOracle2
    ) external returns (uint256) {
        (bool ok1, bytes memory res1) = _priceOracle1.call(abi.encodeWithSignature("price()"));
        (bool ok2, bytes memory res2) = _priceOracle2.call(abi.encodeWithSignature("price()"));
        require(ok1);
        require(ok2);
        uint price1 = abi.decode(res1, (uint));
        uint price2 = abi.decode(res2, (uint));
        if (price1 < price2) {
            return price1;
        }
        return price2;
    }
}

contract PriceOracle1 {
    uint256 private _price;

    function setPrice(uint256 newPrice) public {
        _price = newPrice;
    }

    function price() external view returns (uint256) {
        return _price;
    }
}

contract PriceOracle2 {
    uint256 private _price;

    function setPrice(uint256 newPrice) public {
        _price = newPrice;
    }

    function price() external view returns (uint256) {
        return _price;
    }
}
