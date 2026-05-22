/* Career page — vertical timeline with rarity-tier highlights and accordion entries.

   v2 changes:
   - Status row lifted out of the timeline into a thin always-visible banner above it.
   - Duration chip ("4 YR") sits next to the role title in the closed state.
   - 2–3 primary skills are previewed inline on closed entries; the full list
     reveals on expand (via the existing .tl-body grid-rows transition).
*/

const { useState: useCareerState } = React;

const RARITY_ORDER = ['legendary', 'epic', 'rare', 'uncommon', 'common'];

// Resolves a rarity name to the matching CSS var so it can be passed as an inline
// custom property (drives the rail line + dot color per entry).
const RARITY_VAR = {
  legendary: 'var(--color-legendary)',
  epic:      'var(--color-epic)',
  rare:      'var(--color-rare)',
  uncommon:  'var(--color-uncommon)',
  common:    'var(--color-common)',
};

function jobDuration(job) {
  // end === 2026 in our fake data is treated as "Now". Round to nearest year, min 1.
  const years = Math.max(1, Math.round(job.end - job.start));
  return years;
}

function CareerEntry({ job, index, isOpen, onToggle }) {
  const rarity = RARITY_ORDER[index % RARITY_ORDER.length];

  return (
    <div
      className={`tl-entry ${isOpen ? 'open' : ''}`}
      style={{ '--entry-accent': RARITY_VAR[rarity] }}
    >
      <div className="tl-header" onClick={onToggle}>
        <div className="tl-company-logo" aria-hidden="true">{job.initials}</div>
        <div className="tl-header-main">
          <div className="tl-role-row">
            <div className="tl-role"><Highlight tier={rarity}>{job.title}</Highlight></div>
            <span className="tl-at-company">@ {job.company}</span>
          </div>
        </div>

        <div className="tl-chevron"><i className="fa-solid fa-chevron-down"></i></div>
      </div>

      {/* Right-side timeline rail: start year ‣ accent dot ‣ end year */}
      <div className="tl-rail" aria-hidden="true">
        <span className="yr">{job.start}</span>
        <div className="tl-rail-dot"></div>
        <span className="yr">{job.end === 2026 ? 'NOW' : job.end}</span>
      </div>

      <div className="tl-body">
        <div className="tl-body-inner">
          <div className="tl-body-content">
            <p className="tl-desc">{job.desc}</p>
            <div className="tl-skills">
              {job.skillKeys.map(k => <SkillTag key={k} skill={window.skillByKey[k]} />)}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

function CareerStatusBanner({ onNavigate }) {
  return (
    <div className="career-status">
      <div className="career-status-main">
        <span className="home-badge"><span className="home-badge-dot"></span>Open to work</span>
        <p className="career-status-copy">
          <strong>Permanent senior engineering, back-end focused or full-stack.</strong>{' '}
          Based in Germany, open to remote and hybrid. Good problems and good people are enough.
        </p>
      </div>
      <div className="career-status-actions">
        <Button variant="primary" size="sm" onClick={() => onNavigate('cv')}>Get My CV →</Button>
        <Button size="sm" onClick={() => onNavigate('contact')}>Get In Touch</Button>
      </div>
    </div>
  );
}

function Career({ onNavigate }) {
  const [openKey, setOpenKey] = useCareerState(window.jobs[0].key);

  return (
    <section className="section container" data-screen-label="Career">
      <h1 className="page-h1">Career</h1>
      <h2>Where I've worked</h2>

      <div className="mt-5">
        <CareerStatusBanner onNavigate={onNavigate} />

        <div className="tl-track">
          {window.jobs.map((job, i) => (
            <CareerEntry
              key={job.key}
              job={job}
              index={i}
              isOpen={openKey === job.key}
              onToggle={() => setOpenKey(openKey === job.key ? null : job.key)}
            />
          ))}
        </div>
      </div>
    </section>
  );
}

window.Career = Career;
