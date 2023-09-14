pragma solidity ^0.8.0;

contract PaginationExample {
    mapping(uint256 => bytes) private dataMapping;
    uint256[] private keys;

    function setData(uint256 key, bytes memory data) external {
        dataMapping[key] = data;
        keys.push(key);
    }

    function getData(uint256 pageIndex, uint256 pageSize) external view returns (bytes[] memory) {
        uint256 startIdx = pageIndex * pageSize;
        uint256 endIdx = startIdx + pageSize;
        
        if (endIdx > keys.length) {
            endIdx = keys.length;
        }

        bytes[] memory result = new bytes[](endIdx - startIdx);

        for (uint256 i = startIdx; i < endIdx; i++) {
            result[i - startIdx] = dataMapping[keys[i]];
        }

        return result;
        }
}