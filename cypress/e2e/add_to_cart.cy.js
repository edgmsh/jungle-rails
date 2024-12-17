describe('Add to Cart', () => {
  beforeEach(() => {
    // Visit the home page before each test
    cy.visit('http://localhost:3000');
  });

  it('increments the cart count when a product is added to the cart', () => {
    // Check that the cart count starts at 0
    cy.get('a[href="/cart"]').should('contain', 'My Cart (0)');

    // Find the first product and click its "Add to Cart" button
    cy.get('.products article').first().within(() => {
      cy.get('.btn').click({ force: true });

    });

    // Verify the cart count has increased by 1
    cy.get('a[href="/cart"]').should('contain', 'My Cart (1)');
  });
});