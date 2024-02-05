describe InlineLevel3Component do
  context "reproduce #1910: issues with #within Matcher" do
    it "raises an error if the given locator is not found" do
      render_inline(described_class.new)

      # Confidence check.
      expect(page).to have_css ".level3-component .level2-component .level1-component", text: "Level 1 component"

      expect {
        within ".does-not-exist-selector" do
          expect(page).not_to have_css ".level3-component"
        end
      }.to raise_error(Capybara::ExpectationNotMet)
    end

    it "evaluates the given block when the locator is found" do
      render_inline(described_class.new)

      # Confidence check.
      expect(page).to have_css ".level3-component .level2-component .level1-component", text: "Level 1 component"

      expect {
        within ".level3-component" do
          raise "hello"
        end
      }.to raise_error("hello")
    end
  end
end

