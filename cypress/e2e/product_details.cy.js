describe("Product Details", () => {
  beforeEach(() => {
    // Visit the homepage before each test
    cy.visit('http://localhost:3000');
  });

  it("Navigates to product details page when a product is clicked", () => {
    // Ensure products are visible on the homepage
    cy.get(".products").invoke("css", "height").then((height) => {
      cy.log(`Height: ${height}`);
    });
    cy.get(".products").invoke("css", "display").then((display) => {
      cy.log(`Display: ${display}`);
    });
    
    cy.get(".products article").should("be.visible");

    // Click on the first product
    cy.get(".products article").first().click();

    // Verify URL has navigated to the product details page
    cy.url().should("include", "/products/");

    // Verify product details are visible
    cy.get(".product-detail").should("be.visible");
    cy.get(".product-detail h1").should("exist"); // Product name
    cy.get(".product-detail .price").should("exist"); // Product price
  });
});
