/* Experience page — skill explorer.

   v3 changes:
   - Progress bars replaced with skill chips. Each skill is a brand-colored
     chip (using its own devicon accent), not a tier-based bar.
   - Level dimension is suppressed for now — skills are equal here.
   - Tier-label hero, ranked rail, year-bar still drive panel ranking
     (those are based on years_of_experience, not skill level).
*/

const { useState: useExpState, useMemo: useExpMemo } = React;

const ACCENT_VAR = {
  legendary: 'var(--color-legendary)',
  epic: 'var(--color-epic)',
  rare: 'var(--color-rare)',
  uncommon: 'var(--color-uncommon)',
  common: 'var(--color-common)',
};
const ACCENT_GRADIENT = {
  legendary: 'linear-gradient(160deg, var(--highlight-legendary-from) 0%, var(--highlight-legendary-mid) 50%, var(--highlight-legendary-to) 100%)',
  epic:      'linear-gradient(160deg, var(--highlight-epic-from) 0%,      var(--highlight-epic-mid) 50%,      var(--highlight-epic-to) 100%)',
  rare:      'linear-gradient(160deg, var(--highlight-rare-from) 0%,      var(--highlight-rare-mid) 50%,      var(--highlight-rare-to) 100%)',
  uncommon:  'linear-gradient(160deg, var(--highlight-uncommon-from) 0%,  var(--highlight-uncommon-mid) 50%,  var(--highlight-uncommon-to) 100%)',
  common:    'linear-gradient(160deg, var(--highlight-common-from) 0%,    var(--highlight-common-mid) 50%,    var(--highlight-common-to) 100%)',
};

// Years → seniority tier label. Mirrors the rarity ladder.
function tierForYears(years) {
  if (years >= 10) return 'MASTER';
  if (years >= 5)  return 'EXPERT';
  if (years >= 3)  return 'PROFICIENT';
  return 'FAMILIAR';
}

function Experience() {
  // Rank by years_of_experience desc.
  const ranked = useExpMemo(
    () => [...window.experiences].sort((a, b) => b.years - a.years),
    []
  );
  const maxYears = ranked[0].years;

  const [active, setActive] = useExpState(ranked[0].key);
  const exp = ranked.find(e => e.key === active);

  // Skills keep their author order (most relevant first). No level sorting.
  const allSkills = exp.skillKeys.map(k => window.skillByKey[k]);
  const primarySkills = allSkills.slice(0, 3);
  const secondarySkills = allSkills.slice(3);

  return (
    <section className="section container" data-screen-label="Experience">
      <h1 className="page-h1">Experience</h1>
      <h2>What I've been doing</h2>

      <div className="exp-row mt-5">
        {/* Rail */}
        <div className="exp-rail" role="tablist">
          {ranked.map((e, i) => (
            <button
              key={e.key}
              className={`row ${active === e.key ? 'active' : ''}`}
              style={{ '--row-color': ACCENT_VAR[e.accent] }}
              onClick={() => setActive(e.key)}
            >
              <span className="rank">{String(i + 1).padStart(2, '0')}</span>
              <div className="label-col">
                <span className="name">{e.name}</span>
                <div className="year-bar"><i style={{ width: `${(e.years / maxYears) * 100}%` }}></i></div>
              </div>
              <span className="chevron">›</span>
            </button>
          ))}
        </div>

        {/* Panel */}
        <div>
          <div
            className="exp-panel"
            style={{
              '--panel-color': ACCENT_VAR[exp.accent],
              '--panel-grad': ACCENT_GRADIENT[exp.accent],
            }}
          >
            <div className="exp-panel-header">
              <h2 style={{ margin: 0 }}>
                <span className="exp-title-stroke">{exp.name.toUpperCase()}</span>
              </h2>
            </div>

            <p className="exp-panel-desc">
              <strong>{exp.years} years of experience</strong> — {exp.desc}
            </p>

            <div className="exp-skills-header">
              <span>Top {primarySkills.length} · primary</span>
            </div>
            <div className="sk-primary">
              {primarySkills.map(s => (
                <div className="sk-card" key={s.key} style={{ '--chip-c': s.accent }}>
                  <i className={`icon ${s.icon}`}></i>
                  <div className="name">{s.name}</div>
                  <p className="desc">{s.desc}</p>
                </div>
              ))}
            </div>

            {secondarySkills.length > 0 && (
              <>
                <div className="exp-skills-header">
                  <span>Also used</span>
                </div>
                <div className="sk-secondary">
                  {secondarySkills.map(s => (
                    <span key={s.key} className="sk-chip" style={{ '--chip-c': s.accent }} title={s.desc}>
                      <i className={s.icon}></i>{s.name}
                    </span>
                  ))}
                </div>
              </>
            )}
          </div>
        </div>
      </div>
    </section>
  );
}

window.Experience = Experience;
