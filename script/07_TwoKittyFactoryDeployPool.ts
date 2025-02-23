import Web3 from "web3";
import ITwoKittyFactory from "../out/ITwoKittyFactory.sol/ITwoKittyFactory.json";

type ContractInfo = {
  abi: any;
  address: string;
};

export const createTwoKittyPool = async () => {
  const contractInfo: ContractInfo = {
    abi: ITwoKittyFactory.abi,
    address: "0x0",
  };
  const uptober = "0xa540b4Ba1bDe8ADC18728ea367e69D7867c69682";
  const moonvember = "0xaB7d17A87442da38D900F7280947Ad68Fe361d66";
  const bullcember = "0x44008c1c6d68EF882FEB807c08a300831B48d635";
  const privateKey = "";
  const name = "2kUP/MOON";
  const symbol = "2kUPMON";
  const initialPrice = "26810000000000000000";

  const web3Provider = new Web3.providers.HttpProvider(
    "https://testnet.evm.nodes.onflow.org/"
  );
  const web3 = new Web3(web3Provider);
  const signer = web3.eth.accounts.privateKeyToAccount(privateKey);
  web3.eth.accounts.wallet.add(signer);

  const factory = new web3.eth.Contract(contractInfo.abi, contractInfo.address);

  const feeReceiver = await factory.methods.fee_receiver().call();
  console.log(`feeReceiver: ${feeReceiver}`);

  console.log(
    factory.methods[
      "deploy_pool(string,string,address[],uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256)"
    ]
  );
  const deployPoolMethod = factory.methods[
    "deploy_pool(string,string,address[2],uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256,uint256)"
  ](
    name, // _name
    symbol, // _symbol
    [uptober, moonvember], // _coins
    "0", // implementation_id
    "400000", // A
    "145000000000000", // gamma
    "26000000", // mid_fee
    "45000000", // out_fee
    "230000000000000", // fee_gamma
    "2000000000000", // allowed_extra_profit
    "146000000000000", // adjustment_step
    "866", // ma_exp_time
    initialPrice // initial_price
  );
  const tx = await deployPoolMethod.send({
    from: signer.address,
    gas: "6500000",
  });
  console.log(tx);

  /*
    Flowscan: 0xc955fa0400000000000000000000000000000000000000000000000000000000000001c00000000000000000000000000000000000000000000000000000000000000200000000000000000000000000a540b4ba1bde8adc18728ea367e69d7867c69682000000000000000000000000ab7d17a87442da38d900f7280947ad68fe361d6600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000061a80000000000000000000000000000000000000000000000000000083e0717e100000000000000000000000000000000000000000000000000000000000018cba800000000000000000000000000000000000000000000000000000000002aea5400000000000000000000000000000000000000000000000000000d12f0c4c6000000000000000000000000000000000000000000000000000000001d1a94a2000000000000000000000000000000000000000000000000000000084c9462320000000000000000000000000000000000000000000000000000000000000000362000000000000000000000000000000000000000000000001741040f45c3900000000000000000000000000000000000000000000000000000000000000000009326b55502f4d4f4f4e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007326b55504d4f4e00000000000000000000000000000000000000000000000000
    Local Tx: 0xba91f54c00000000000000000000000000000000000000000000000000000000000001a000000000000000000000000000000000000000000000000000000000000001e0000000000000000000000000000000000000000000000000000000000000022000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000061a80000000000000000000000000000000000000000000000000000083e0717e100000000000000000000000000000000000000000000000000000000000018cba800000000000000000000000000000000000000000000000000000000002aea5400000000000000000000000000000000000000000000000000000d12f0c4c6000000000000000000000000000000000000000000000000000000001d1a94a2000000000000000000000000000000000000000000000000000000084c9462320000000000000000000000000000000000000000000000000000000000000000362000000000000000000000000000000000000000000000001741040f45c3900000000000000000000000000000000000000000000000000000000000000000009326b55502f4d4f4f4e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007326b55504d4f4e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000000000000000000000000a540b4ba1bde8adc18728ea367e69d7867c69682000000000000000000000000ab7d17a87442da38d900f7280947ad68fe361d66

    const tx = await factory.methods.deploy_pool(
        "2kUP/MOON",
        "2kUPMON",
        [
            "0xa540b4Ba1bDe8ADC18728ea367e69D7867c69682",
            "0xaB7d17A87442da38D900F7280947Ad68Fe361d66"
        ],
        0,
        '400000',
        '145000000000000',
        '26000000',
        '45000000',
        '230000000000000',
        '2000000000000',
        '146000000000000',
        '866',
        '26810000000000000000'
    )
        .send({
            from: signer.address,
            gas: '5443558',
        });
    
    */

  /*

    const i = 0;
    const j = 1;
    const amount = new BigNumber(10000);
    const totalCoins = 2;

    for (let i = 0; i < totalCoins; i++) {
        const coin = await kp.methods.balances(i).call();
        console.log(`Balances[${i}]: ${coin}`);
    }

    const nCoins = await kp.methods.N_COINS().call();
    console.log(`nCoins: ${nCoins}`);



    const virtualPrice = await kp.methods.get_virtual_price().call({
        from: web3.eth.defaultAccount,
    });
    console.log(`Virtual price: ${virtualPrice}`);

    const A = await kp.methods.A().call({
        from: web3.eth.defaultAccount,
    });
    console.log(`A: ${A}`);

    const getDx = await kp.methods
        .get_dx(i, j, ethers.utils.parseUnits('1', 15).toString())
        .call({
            from: web3.eth.defaultAccount,
        });

    console.log(`getDx: ${getDx}`);

    const getDy = await kp.methods
        .get_dy(i, j, ethers.utils.parseUnits('1', 18).toString())
        .call({
            from: web3.eth.defaultAccount,
        });

    console.log(`getDy: ${getDy}`);
    */
};

createTwoKittyPool()
  .then(() => {
    console.log("done");
  })
  .catch((error) => {
    console.log(error);
  });
