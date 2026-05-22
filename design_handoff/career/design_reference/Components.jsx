/* Shared small components for the UI kit. Exports to window so other
   Babel-transpiled scripts can find them. */

const { useEffect, useState, useRef } = React;

/* A clickable button styled per the design system. */
function Button({ variant='default', size='normal', children, onClick, as='button', ...rest }) {
  const cls = ['btn',
    variant === 'primary'   ? 'btn-primary'   : '',
    variant === 'secondary' ? 'btn-secondary' : '',
    size === 'sm' ? 'btn-sm' : size === 'lg' ? 'btn-lg' : '',
  ].filter(Boolean).join(' ');
  if (as === 'a') return <a className={cls} onClick={onClick} {...rest}>{children}</a>;
  return <button className={cls} onClick={onClick} {...rest}>{children}</button>;
}

/* Pill chip used in skill rows. */
function SkillTag({ skill }) {
  const chipC = skill.accent || 'var(--color-text-faint)';
  return (
    <span className="skill-tag" style={{ '--chip-c': chipC }} title={skill.desc}>
      <i className={skill.icon}></i>{skill.name}
    </span>
  );
}

/* Filled circle with one devicon. Used in the hero chip field and below it. */
function SkillChip({ skill, size=40 }) {
  return (
    <span className="skill-chip" style={{ '--chip-c': skill.accent, width: size, height: size, fontSize: size*0.5 }}>
      <i className={skill.icon}></i>
    </span>
  );
}

/* The site-wide image stub. */
function ImgStub({ label='screenshot', round=false, style={} }) {
  return (
    <div className="img-stub" style={{ borderRadius: round ? '50%' : 0, ...style }}>
      <span style={{ fontSize: '0.55rem' }}>{label}</span>
    </div>
  );
}

/* Inline rarity highlight — wraps text in a paint-stroke span. */
function Highlight({ tier='primary', children }) {
  return <span className={`highlight-${tier}`}>{children}</span>;
}

/* Plain tag with no icon. */
function Tag({ children }) { return <span className="tag">{children}</span>; }

/* Open-to-work badge. */
function StatusBadge({ label='Open to work' }) {
  return (
    <span className="home-badge"><span className="home-badge-dot"></span>{label}</span>
  );
}

Object.assign(window, { Button, SkillTag, SkillChip, ImgStub, Highlight, Tag, StatusBadge });
