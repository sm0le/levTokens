pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.6/ChainlinkClient.sol";


contract LEV {
    ChainlinkClient public chainlinkClient;
    mapping(address => uint256) public balanceOf;
    uint256 public totalSupply;
    address public oracle;
    uint256 public gmxPrice;
    uint256 public dydxPrice;
    uint256 public perpPrice;

    event Transfer(address indexed from, address indexed to, uint256 value);

    constructor() public {
        totalSupply = 21000000;
        balanceOf[msg.sender] = totalSupply;
        emit Transfer(address(0), msg.sender, totalSupply);
        chainlinkClient = new ChainlinkClient(msg.sender, oracle);
    }

    function setOracle(address _oracle) public {
        require(msg.sender == address(chainlinkClient));
        oracle = _oracle;
    }

    function updatePrices() public {
        chainlinkClient.requestData(oracle, abi.encodeWithSignature("latestAnswer()"));
    }

    function onOracleData(bytes memory data) public {
        (gmxPrice, dydxPrice, perpPrice) = abi.decode(data, (uint256, uint256, uint256));
        // Calculate average price
        uint256 avgPrice = (gmxPrice + dydxPrice + perpPrice) / 3;
        // Set the token price
        setPrice(avgPrice);
    }

    function setPrice(uint256 _price) public {
        require(msg.sender == address(chainlinkClient));
        // Store the new price
    }

    function transfer(address to, uint256 value) public {
        require(balanceOf[msg.sender] >= value);
        require(to != address(0));

        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        emit Transfer(msg.sender, to, value);
    }
}
