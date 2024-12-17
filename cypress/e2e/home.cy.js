describe('Jungle App Home Page', () => {
  it('should load the home page successfully', () => {
    // Visit the home page
    cy.visit('http://localhost:3000');

    // Assert that the page contains the expected header text
    cy.contains('Welcome to');

    // Check the page title
    cy.title().should('include', 'Jungle');

    // Check if the navigation bar exists
    cy.get('nav').should('exist');
  });
  it("There are displayed products on the page", () => {
    cy.visit("/");
    cy.get('.products').should('have.length.greaterThan', 0);
  });
  it("There is 1 product on the page", () => {
    cy.visit("/");
    cy.get(".products").should("have.length", 1);
  });
});
