/* Projects page — alternating-direction list with image stubs. */

function ProjectRow({ project, index, onClick }) {
  return (
    <a className={`proj-row ${index % 2 ? 'flipped' : ''}`} onClick={onClick}>
      <div className="proj-content">
        <p className="text-xs mb-2 text-faint">{project.year}</p>
        <h3 className="mb-2">{project.name}</h3>
        <p className="mb-4 text-muted">{project.desc}</p>
        <div className="tags mb-4">
          {project.skillKeys.map(k => <Tag key={k}>{window.skillByKey[k].name}</Tag>)}
        </div>
        <div className="proj-cta-row">
          <span className="proj-cta">View case study →</span>
        </div>
      </div>
      <div className="proj-img"><ImgStub label={`${project.name} screenshot`} style={{ width: '100%', height: '100%' }} /></div>
    </a>
  );
}

function Projects({ onSelectProject }) {
  return (
    <section className="section container" data-screen-label="Projects">
      <h1 className="page-h1">Projects</h1>
      <h2>What I've built</h2>
      <div className="proj-list mt-5">
        {window.projects.map((p, i) => (
          <ProjectRow key={p.key} project={p} index={i} onClick={() => onSelectProject && onSelectProject(p)} />
        ))}
      </div>
    </section>
  );
}

window.Projects = Projects;
