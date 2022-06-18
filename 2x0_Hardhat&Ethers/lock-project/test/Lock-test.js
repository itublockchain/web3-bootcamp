const { expect } = require('chai');
const { ethers } = require('hardhat');
const provider = ethers.provider;

function ethToNum(val) {
    return Number(ethers.utils.formatEther(val))
}

describe("Lock Contract", function () {
    let owner, user1, user2;
    let Token, token;
    let Lock, lock;

    let balances;

    before(async function () {
        [owner, user1, user2] = await ethers.getSigners();

        Token = await ethers.getContractFactory("BEEToken");
        token = await Token.connect(owner).deploy();

        Lock = await ethers.getContractFactory("Lock");
        lock = await Lock.connect(owner).deploy(token.address);

        token.connect(owner).transfer(user1.address, ethers.utils.parseUnits("100", 18));
        token.connect(owner).transfer(user2.address, ethers.utils.parseEther("50"));

        token.connect(user1).approve(lock.address, ethers.constants.MaxUint256);
        token.connect(user2).approve(lock.address, ethers.constants.MaxUint256);
    });

    beforeEach(async function() {
        balances = [
            ethToNum(await token.balanceOf(owner.address)),
            ethToNum(await token.balanceOf(user1.address)),
            ethToNum(await token.balanceOf(user2.address)),
            ethToNum(await token.balanceOf(lock.address))
        ]
    });

    it("Deploys the contracts", async function() {
        expect(token.address).to.not.be.undefined;
        expect(lock.address).to.be.properAddress;
    });

    it("Sends tokens", async function() {
        expect(balances[1]).to.be.equal(100);
        expect(balances[2]).to.be.equal(50);
        expect(balances[0]).to.be.greaterThan(balances[1]);
    });

    it("Approves", async function() {
        let allowances = [
            await token.allowance(user1.address, lock.address),
            await token.allowance(user2.address, lock.address),
        ]

        expect(allowances[0]).to.be.equal(ethers.constants.MaxUint256);
        expect(allowances[0]).to.be.equal(allowances[1]);

    });

    it("Reverts exceeding transfer", async function () {
        await expect(token.connect(user1).transfer(user2.address, ethers.utils.parseUnits("300", 18))).to.be.reverted;
    });

    describe("Contract Functions", function () {

        let lockerCount = 0;
        let totalLocked = 0;
        let userLocks = [0, 0];

        it("user1 locks 10 tokens", async function () {
            totalLocked += 10;
            userLocks[0] += 10;
            lockerCount++;
            await lock.connect(user1).lockTokens(ethers.utils.parseEther("10"));

            expect(balances[3] + 10).to.be.equal(ethToNum(await token.balanceOf(lock.address)));
            expect(userLocks[0]).to.be.equal(ethToNum(await lock.lockers(user1.address)));
        });

        it("Locker count and locked amount increase", async function () {
            expect(await lock.lockerCount()).to.be.equal(lockerCount);
            expect(ethToNum(await lock.totalLocked())).to.be.equal(totalLocked);
        });

        it("user2 cannot withdraw tokens", async function () {
            await expect(lock.connect(user2).withdrawTokens()).to.be.reverted;
        });

        it("user1 withdraws token", async function () {
            totalLocked -= userLocks[0];
            userLocks[0] = 0;
            lockerCount--;
            await lock.connect(user1).withdrawTokens();

            expect(balances[3] - 10).to.be.equal(ethToNum(await token.balanceOf(lock.address)));
            expect(userLocks[0]).to.be.equal(ethToNum(await lock.lockers(user1.address)));
        });

        it("Locker count and locked amount decrease", async function () {
            expect(await lock.lockerCount()).to.be.equal(lockerCount);
            expect(ethToNum(await lock.totalLocked())).to.be.equal(totalLocked);
        });
        
        it("user1 position deleted", async function () {
            expect(await lock.lockers(user1.address)).to.be.equal(0);
        });

        it("user1 cannot withdraw more tokens", async function () {
            await expect(lock.connect(user1).withdrawTokens()).to.be.reverted;
        });
    });

    it("Prints timestamp", async function () {
        let block_number = await provider.getBlockNumber();
        let block = await provider.getBlock(block_number);
        console.log("timestamp:", block.timestamp);
    });
});