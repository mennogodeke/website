require "test_helper"

class ExperienceHelperTest < ActionView::TestCase
  test "returns is-backend for back-end names" do
    assert_equal "is-backend", expertise_card_class("Back-end")
    assert_equal "is-backend", expertise_card_class("Backend")
  end

  test "returns is-cloud for cloud and devops names" do
    assert_equal "is-cloud", expertise_card_class("Cloud")
    assert_equal "is-cloud", expertise_card_class("DevOps")
  end

  test "returns is-ios for ios and macos names" do
    assert_equal "is-ios", expertise_card_class("iOS")
    assert_equal "is-ios", expertise_card_class("macOS")
  end

  test "returns is-frontend for front-end names" do
    assert_equal "is-frontend", expertise_card_class("Front-end")
    assert_equal "is-frontend", expertise_card_class("Frontend")
  end

  test "returns empty string for unrecognised names" do
    assert_equal "", expertise_card_class("Other")
    assert_equal "", expertise_card_class("")
  end
end
