/* Home page — hero with floating chip field, CTAs, footer CTA. */

function Home({ onNavigate }) {
  const chipSkills = window.skills.slice(0, 16);

  return (
    <>
      <div className="home-hero container section" data-screen-label="Home · Hero">
        <div className="chip-field" aria-hidden="true">
          {chipSkills.map((s, i) => {
            const [cx, cy] = window.chipPositions[i % window.chipPositions.length];
            return (
              <span key={s.key} className="floating-chip"
                    style={{ '--cx': cx, '--cy': cy, '--chip-c': s.accent }}>
                <i className={s.icon}></i>
              </span>
            );
          })}
        </div>

        <div className="home-hero-grid">
          <div>
            <p className="text-xs text-primary mb-3">Hi, I'm Menno</p>
            <p className="text-muted mb-1">Welcome to</p>
            <h1 className="page-h1 hero home-site-title mb-5">MENNO.CODES</h1>
            <p className="home-hero-sub">My little corner of the internet — a personal portfolio and interactive CV where you can explore my work, browse my experience, and grab my CV if you like what you see.</p>
          </div>

          <div className="home-hero-right">
            <ImgStub round style={{ width: 160, height: 160 }} label="headshot" />
            <div>
              <h4 className="mb-2">Fullstack Software Engineer</h4>
              <StatusBadge />
            </div>
            <p className="home-hero-bio">10 years building back-end systems, full-stack web apps, and developer tooling. Ruby on Rails at the core. Everything else as needed.</p>
            <div className="home-hero-actions">
              <Button variant="primary" onClick={() => onNavigate('cv')}>Get My CV →</Button>
              <Button variant="secondary" onClick={() => onNavigate('contact')}>Get in Touch</Button>
            </div>
          </div>
        </div>
      </div>

      <div className="home-footer-cta container">
        <h2>Open to work.<br/><span className="text-primary">Let's talk.</span></h2>
        <div className="home-hero-actions">
          <Button variant="primary" onClick={() => onNavigate('cv')}>Get My CV →</Button>
          <Button variant="secondary" onClick={() => onNavigate('contact')}>Get in Touch</Button>
        </div>
      </div>
    </>
  );
}
window.Home = Home;
