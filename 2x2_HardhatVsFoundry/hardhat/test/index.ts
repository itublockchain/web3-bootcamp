import { expect } from "chai";
import { ethers } from "hardhat";
import { Purchase, Purchase__factory } from "../typechain";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";

describe("SafePurchase", () => {
  let seller: SignerWithAddress, 
    buyer: SignerWithAddress, 
    user: SignerWithAddress;

  let safePurchaseFactory: Purchase__factory;
  let safePurchase: Purchase;

  const START_AMOUNT = ethers.utils.parseEther('0.2')

  it("Should only deploy with even value", async () => {
    [ seller, buyer, user ] = await ethers.getSigners();
    safePurchaseFactory = await ethers.getContractFactory("Purchase");

    // Tek sayı olan bir değerle deploy etmeye çalışmak revert edecek
    await expect(safePurchaseFactory.deploy({
      value: START_AMOUNT.add(1)
    })).to.reverted;

    // Çift sayı olan bir değerle çalışacak
    safePurchase = await safePurchaseFactory.deploy({ 
      value: START_AMOUNT 
    });

    // Kontrattaki satıcı, ethers.getSigners ile gelen ilk kullanıcıya eşit
    // olacak
    expect(await safePurchase.seller()).to.eq(seller.address);
  });

  it('Seller can abort the selling', async () => {
    // Eğer başka bir kullanıcı abort etmeye çalışırsa hata alır
    await expect(safePurchase.connect(user).abort()).to.be.reverted;

    await safePurchase.connect(seller).abort();

    expect(await safePurchase.state()).to.be.eq(3);
  });

  it('Anyone can confirm purchase by paying the same amount', async () => {
    safePurchase = await safePurchaseFactory.deploy({
      value: START_AMOUNT
    });

    // Parasını vermeyen kullanıcı satın almayı onaylayamaz
    await expect(safePurchase.connect(user).confirmPurchase())
      .to.be.reverted;

    // Parasını veren kullanıcı satın almayı onaylayabilir
    await safePurchase.connect(buyer).confirmPurchase({
      value: START_AMOUNT
    });

    // Başarılı bir onaylamadan sonra satın alan kişi kontratta yerini alır
    expect(await safePurchase.buyer()).to.be.equal(buyer.address);
  });

  it('After confirming receive, both can claim their parts', async () => {
    await expect(safePurchase.connect(user).confirmReceived())
      .to.be.reverted;

    const beforeSellerBal = await seller.getBalance();
    const beforeBuyerBal = await buyer.getBalance();
   
    // Satın alan paketin ulaştığını onaylar, satan kişi içerideki parasını
    // geri alır
    await safePurchase.connect(buyer).confirmReceived();
    await safePurchase.connect(seller).refundSeller();

    const sellerBalDelta = await seller.getBalance()
      .then(bal => bal.sub(beforeSellerBal));
    const buyerBalDelta = await buyer.getBalance()
      .then(bal => bal.sub(beforeBuyerBal));

    const expectedSellerDelta = START_AMOUNT.mul(3).div(2);
    const expectedBuyerDelta = START_AMOUNT.div(2);

    expect(expectedSellerDelta.sub(sellerBalDelta))
      .to.be.lt(ethers.utils.parseEther("0.001"));

    expect(expectedBuyerDelta.sub(buyerBalDelta))
      .to.be.lt(ethers.utils.parseEther("0.001"));
  });

	it('This test will fail', async() => {
		expect(await safePurchase.state()).to.be.eq(0);
	});
});
