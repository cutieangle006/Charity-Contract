module.exports = {
  solidity: {
    version: "^0.5.16",
    defaultNetworks: 'ganache',
    networks: {
      development: {
        account: ['0x' + process.env.PRIVATE_KEY],
        host: '127.0.0.1L: 7545',
        port: 7545,
        network_id: "5777"
      },
    },
    setting: {
      optimizer:{
        enabled: true,
        runs: 200,
      },
    },
  }
};