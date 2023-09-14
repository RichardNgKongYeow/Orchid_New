const OrchidMaster = artifacts.require("OrchidMaster");
const OrchidResolver = artifacts.require("OrchidResolver");
const OrchidAddrResolver = artifacts.require("OrchidAddrResolver");
const OrchidTextResolver = artifacts.require("OrchidTextResolver");
const CustomENSRegistry = artifacts.require("CustomENSRegistry");

contract("Orchid Contracts Test", (accounts) => {
  let orchidMaster;
  let customENSRegistry;
  let orchidResolver;
  let orchidAddrResolver;
  let orchidTextResolver;
  let owner = accounts[0];
  let resolverName = web3.utils.utf8ToHex("TestResolver");

  beforeEach(async () => {
    orchidMaster = await OrchidMaster.new(owner, { from: owner });
    customENSRegistry = await CustomENSRegistry.new(owner, { from: owner });

    const tx = await orchidMaster.createResolver(owner, resolverName, customENSRegistry.address, {
      from: owner,
    });

    orchidResolver = await OrchidResolver.at(tx.logs[0].args.resolverAddress);
    orchidAddrResolver = await OrchidAddrResolver.at(orchidResolver.address);
    orchidTextResolver = await OrchidTextResolver.at(orchidResolver.address);
  });

  it("should create a new OrchidResolver", async () => {
    const resolverInfo = await orchidMaster.getResolverInfoByName(resolverName, { from: owner });

    assert.equal(resolverInfo.resolverAddress, orchidResolver.address, "Resolver address not set correctly");
    assert.equal(resolverInfo.resolverName, resolverName, "Resolver name not set correctly");
    assert.equal(resolverInfo.owner, owner, "Owner not set correctly");
  });

  it("should set and get registry records in OrchidAddrResolver", async () => {
    const node = web3.utils.utf8ToHex("Node1");
    await orchidAddrResolver.setRegistryRecord(node, { from: owner });
    const isRecordSet = await orchidAddrResolver.records(node);

    assert.isTrue(isRecordSet, "Record not set correctly");
  });

  it("should delete registry records in OrchidAddrResolver", async () => {
    const node = web3.utils.utf8ToHex("Node2");
    await orchidAddrResolver.setRegistryRecord(node, { from: owner });
    await orchidAddrResolver.delRegistryRecord(node, { from: owner });
    const isRecordSet = await orchidAddrResolver.records(node);

    assert.isFalse(isRecordSet, "Record not deleted correctly");
  });

  it("should set and get text data in OrchidTextResolver", async () => {
    const node = web3.utils.utf8ToHex("Node3");
    const key = "Key1";
    const value = "Value1";
    await orchidTextResolver.setKey(node, key, { from: owner });
    await orchidTextResolver.setText(node, key, value, { from: owner });
    const retrievedValue = await orchidTextResolver.text(node, key);

    assert.equal(retrievedValue, value, "Text data not set or retrieved correctly");
  });

  it("should delete text data in OrchidTextResolver", async () => {
    const node = web3.utils.utf8ToHex("Node4");
    const key = "Key2";
    const value = "Value2";
    await orchidTextResolver.setKey(node, key, { from: owner });
    await orchidTextResolver.setText(node, key, value, { from: owner });
    await orchidTextResolver.delText(node, key, { from: owner });
    const retrievedValue = await orchidTextResolver.text(node, key);

    assert.equal(retrievedValue, "", "Text data not deleted correctly");
  });
});
