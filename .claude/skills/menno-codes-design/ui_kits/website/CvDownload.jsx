/* CV download — email-gated, mirrors website/app/views/cv_downloads/new.html.erb. */

const { useState: useCvState } = React;

function CvDownload({ onNavigate }) {
  const [sent, setSent] = useCvState(false);
  const [email, setEmail] = useCvState('');

  return (
    <section className="section container" data-screen-label="Get my CV">
      <h1 className="page-h1">Curriculum Vitae</h1>
      <p className="text-muted mt-5 mb-6" style={{ maxWidth: 640 }}>
        Drop your email and I'll send you a fresh signed link to the PDF. The link expires in 24 hours.
        Or just open the live HTML version in your browser.
      </p>

      <div className="cv-download-grid" style={{
        display: 'grid', gridTemplateColumns: '1fr 80px 1fr', alignItems: 'center', minHeight: 260,
      }}>
        <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'flex-start', gap: '1.25rem', paddingRight: '2rem' }}>
          {sent && <div className="notification notification-success" style={{ width: '100%' }}>Your CV link has been sent — check your inbox.</div>}
          <h3 style={{ marginTop: 0 }}>Get a download link</h3>
          <form style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem', width: '100%' }}
                onSubmit={e => { e.preventDefault(); setSent(true); }}>
            <div className="field">
              <label className="label">Email</label>
              <input className="input" type="email" placeholder="your@email.com" value={email} onChange={e => setEmail(e.target.value)} />
            </div>
            <Button variant="primary">Send →</Button>
          </form>
        </div>

        <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '1rem', alignSelf: 'stretch', padding: '1rem 0' }}>
          <div style={{ flex: 1, width: 1, background: 'var(--color-border-2)' }}></div>
          <span style={{ fontFamily: 'var(--font-display)', fontWeight: 700, fontSize: '0.85rem', letterSpacing: '0.15em', color: 'var(--color-text-faint)', textTransform: 'uppercase' }}>OR</span>
          <div style={{ flex: 1, width: 1, background: 'var(--color-border-2)' }}></div>
        </div>

        <div style={{ paddingLeft: '2rem', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
          <a style={{
            display: 'inline-flex', alignItems: 'center', justifyContent: 'center',
            fontFamily: 'var(--font-display)', fontWeight: 900, fontSize: '1.5rem',
            letterSpacing: '0.08em', textTransform: 'uppercase', color: 'var(--color-text-muted)',
            border: '2px solid var(--color-border-2)', textAlign: 'center', padding: '1.5rem 2rem',
            cursor: 'pointer'
          }} onClick={() => onNavigate('home')}>OPEN IN BROWSER →</a>
        </div>
      </div>
    </section>
  );
}

window.CvDownload = CvDownload;
