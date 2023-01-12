# levTokens

This contract uses the ChainlinkClient contract to interact with a Chainlink Oracle to fetch the latest prices of GMX, DYDX, and PERP tokens. Once the prices are received, the contract calculates the average price and sets the price of LEV token to that. The user can call the updatePrices() function to fetch the latest prices, and the onOracleData() function will be called to process the data and update the token's price.
