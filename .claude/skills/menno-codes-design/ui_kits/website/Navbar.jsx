/* Site navbar — fixed, fades in a navy background once scrolled. */

const { useEffect: useEffectNav, useState: useStateNav } = React;

function Navbar({ route, onNavigate, theme, onToggleTheme }) {
  const [scrolled, setScrolled] = useStateNav(false);

  useEffectNav(() => {
    const onScroll = () => setScrolled(window.scrollY > 8);
    onScroll();
    window.addEventListener('scroll', onScroll, { passive: true });
    return () => window.removeEventListener('scroll', onScroll);
  }, []);

  const links = [
    { key: 'home',       label: 'Home' },
    { key: 'career',     label: 'Career' },
    { key: 'experience', label: 'Experience' },
    { key: 'projects',   label: 'Projects' },
  ];

  return (
    <nav className={`navbar ${scrolled ? 'is-scrolled' : ''}`} role="navigation">
      <div className="navbar-inner">
        <a className="navbar-logo" onClick={() => onNavigate('home')}>MENNO.CODES</a>

        <ul className="navbar-links">
          {links.map(l => (
            <li key={l.key}>
              <button
                className={`navbar-link ${route === l.key ? 'is-active' : ''}`}
                onClick={() => onNavigate(l.key)}
              >{l.label}</button>
            </li>
          ))}
        </ul>

        <div className="navbar-ctas">
          <a className={`navbar-cta navbar-cta-secondary ${route === 'contact' ? 'is-active' : ''}`} onClick={() => onNavigate('contact')}>
            GET IN TOUCH
          </a>
          <span className="navbar-cta-divider">or</span>
          <a className="navbar-cta" onClick={() => onNavigate('cv')}>
            GET MY CV <i className="fa-solid fa-arrow-right"></i>
          </a>
          <span className="navbar-cta-divider">|</span>
          <button className="theme-toggle" onClick={onToggleTheme} aria-label="Toggle theme">
            <i className={`fa-solid ${theme === 'dark' ? 'fa-sun' : 'fa-moon'}`}></i>
          </button>
          <span className="navbar-cta-divider">|</span>
          <button className="locale-trigger" aria-label="Language">
            EN <i className="fa-solid fa-chevron-down" style={{ fontSize: '0.6rem', marginLeft: 4 }}></i>
          </button>
        </div>
      </div>
    </nav>
  );
}

window.Navbar = Navbar;
