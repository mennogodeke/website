require "test_helper"

class LocaleTest < ActionDispatch::IntegrationTest
  # ── Locale detection from URL ────────────────────────────────────────────────

  test "no locale prefix uses English" do
    get jobs_url
    assert_response :success
    assert_select "h1", text: "Career"
  end

  test "nl prefix sets Dutch locale" do
    get "/nl/jobs"
    assert_response :success
    assert_select "h1", text: "Carrière"
  end

  test "de prefix sets German locale" do
    get "/de/jobs"
    assert_response :success
    assert_select "h1", text: "Karriere"
  end

  # ── Invalid / unsupported locales ────────────────────────────────────────────

  test "unsupported locale prefix returns 404" do
    get "/fr/jobs"
    assert_response :not_found
  end

  test "invalid locale param is ignored and falls back to English" do
    get "/jobs", params: { locale: "xx" }
    assert_response :success
    assert_select "h1", text: "Career"
  end

  # ── URL structure ────────────────────────────────────────────────────────────

  test "Dutch locale URLs are prefixed with /nl/" do
    get "/nl"
    assert_response :success
    assert_includes response.body, "/nl/"
  end

  test "German locale URLs are prefixed with /de/" do
    get "/de"
    assert_response :success
    assert_includes response.body, "/de/"
  end

  test "English locale URLs have no locale prefix" do
    get root_url
    assert_response :success
    assert_not_includes response.body, "/en/"
  end

  # ── Translated page content ──────────────────────────────────────────────────

  test "home page renders Dutch intro text" do
    get "/nl"
    assert_response :success
    assert_includes response.body, "MENNO.CODES"
  end

  test "home page renders German intro text" do
    get "/de"
    assert_response :success
    assert_includes response.body, "MENNO.CODES"
  end

  test "contact page renders Dutch form labels" do
    get "/nl/contact"
    assert_response :success
    assert_select "label", text: "Naam"
  end

  test "contact page renders German form labels" do
    get "/de/contact"
    assert_response :success
    assert_select "label", text: "Name"
  end
end
