const SimpleStorage = artifacts.require("SimpleStorage");

contract("SimpleStorage", accounts => {
  it("should store the correct initial value", async () => {
    const instance = await SimpleStorage.deployed();
    const value = await instance.get();
    assert.equal(value.toNumber(), 100, "Initial value should be 100");
  });

  it("should update the stored value", async () => {
    const instance = await SimpleStorage.deployed();
    await instance.set(123);
    const newValue = await instance.get();
    assert.equal(newValue.toNumber(), 123, "Value should be updated to 123");
  });
});
