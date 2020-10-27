pragma solidity 0.6.2;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "../interfaces/IOracle.sol";

contract PriceInCNY {
    using SafeMath for uint256;
    
    address public oracle;
    address public constant CNY_EXCHANGE_RATE_ADDRESS_AS = 0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC;

    constructor(address _oracle) public {
        oracle = _oracle;
    }

    function exchangeRate() public view returns (uint256 value, bool valid) {
        (value, valid) = IOracle(oracle).get(CNY_EXCHANGE_RATE_ADDRESS_AS);
    }

    //price with exchangerate
    function value(address token) public view returns (uint256, bool) {
        // return IOracle(oracle).get(token);
        (uint256 p, bool v1) = IOracle(oracle).get(token);
        (uint256 e, bool v2) = IOracle(oracle).get(CNY_EXCHANGE_RATE_ADDRESS_AS);
        return (e.mul(p).div(1e18), v1 && v2);
    }
}
