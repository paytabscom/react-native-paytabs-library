/**
 * PaymentSDKCardDiscount: Represents a discount that can be applied to a card payment.
 */
export default class PaymentSDKCardDiscount {
  /**
   * @param {string[]} discountCards - An array of strings representing the cards that the discount can be applied to.
   * @param {number} discountValue - The value of the discount. This could be a flat amount or a percentage depending on the value of 'isPercentage'.
   * @param {string} discountTitle - The title or name of the discount.
   * @param {boolean} isPercentage - A boolean indicating whether the discount value is a percentage (true) or a flat amount (false).
   */
  constructor(discountCards, discountValue, discountTitle, isPercentage) {
    this.discountCards = discountCards;
    this.discountValue = discountValue;
    this.discountTitle = discountTitle;
    this.isPercentage = isPercentage;
  }
}
