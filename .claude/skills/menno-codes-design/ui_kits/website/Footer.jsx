/* Footer — built-with row + brand. */

function Footer() {
  return (
    <footer className="site-footer">
      <div className="footer-inner">
        <div className="footer-built-with">
          <span className="footer-built-label">Built with:</span>
          <div className="footer-tech-icons">
            <i className="devicon-ruby-plain colored" title="Ruby"></i>
            <i className="devicon-rails-plain colored" title="Rails"></i>
            <i className="devicon-github-original" title="GitHub"></i>
            <i className="devicon-docker-plain colored" title="Docker"></i>
            <i className="fa-solid fa-robot footer-claude-icon" title="Claude"></i>
          </div>
        </div>
        <div className="footer-brand">
          <span className="footer-logo">MENNO.CODES</span>
          <span className="footer-copy">&copy; {new Date().getFullYear()} Menno Godeke</span>
        </div>
      </div>
    </footer>
  );
}
window.Footer = Footer;
