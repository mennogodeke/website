/* Contact page — form + socials sidebar. */

const { useState: useContactState } = React;

function Contact() {
  const [sent, setSent] = useContactState(false);
  const [emailErr, setEmailErr] = useContactState(false);
  const [form, setForm] = useContactState({ name: '', email: '', message: '' });

  const handleSubmit = (e) => {
    e.preventDefault();
    const looksValid = /.+@.+\..+/.test(form.email);
    if (!looksValid) { setEmailErr(true); setSent(false); return; }
    setEmailErr(false);
    setSent(true);
  };

  return (
    <section className="section container" data-screen-label="Contact">
      <p className="text-muted mb-2">Wanna work together?</p>
      <h1 className="page-h1">Get in touch</h1>
      <p className="contact-intro" style={{ marginTop: '2rem' }}>
        Have a project in mind, or just want to say hi? Either way, my inbox is open.
      </p>

      <div className="contact-layout">
        <div>
          {sent && <div className="notification notification-success">Message sent — I'll get back to you within a few days.</div>}
          <form className="contact-form" onSubmit={handleSubmit}>
            <div className="field">
              <label className="label">Name</label>
              <input className="input" type="text" placeholder="Your name" value={form.name}
                     onChange={e => setForm({...form, name: e.target.value})} />
            </div>
            <div className="field">
              <label className="label">Email</label>
              <input className={`input ${emailErr ? 'input-error' : ''}`} type="email" placeholder="your@email.com"
                     value={form.email} onChange={e => { setForm({...form, email: e.target.value}); setEmailErr(false); }} />
              {emailErr && <p className="field-error">Please enter a valid email address.</p>}
            </div>
            <div className="field">
              <label className="label">Message</label>
              <textarea className="textarea" placeholder="What's on your mind?" rows={6}
                        value={form.message} onChange={e => setForm({...form, message: e.target.value})}></textarea>
            </div>
            <div className="field">
              <Button variant="primary" onClick={handleSubmit}>Send message →</Button>
            </div>
          </form>
        </div>

        <div className="social-icons">
          <a className="social-icon" title="GitHub"><i className="fa-brands fa-github"></i></a>
          <a className="social-icon" title="LinkedIn"><i className="fa-brands fa-linkedin-in"></i></a>
          <a className="social-icon" title="Discord"><i className="fa-brands fa-discord"></i></a>
          <a className="social-icon" title="Slack"><i className="fa-brands fa-slack"></i></a>
          <a className="social-icon" title="Email"><i className="fa-solid fa-envelope"></i></a>
        </div>
      </div>
    </section>
  );
}

window.Contact = Contact;
