/* App — root + simple route switcher. */

const { useState: useAppState, useEffect: useAppEffect } = React;

function App() {
  const [route, setRoute] = useAppState('home');
  const [theme, setTheme] = useAppState('dark');

  useAppEffect(() => {
    document.documentElement.setAttribute('data-theme', theme);
  }, [theme]);

  // Scroll to top on every route change.
  useAppEffect(() => {
    window.scrollTo({ top: 0, behavior: 'instant' in window ? 'instant' : 'auto' });
  }, [route]);

  const navigate = (r) => setRoute(r);

  return (
    <>
      <Navbar route={route} onNavigate={navigate} theme={theme} onToggleTheme={() => setTheme(theme === 'dark' ? 'light' : 'dark')} />
      <main className="main-content">
        {route === 'home'       && <Home       onNavigate={navigate} />}
        {route === 'career'     && <Career     onNavigate={navigate} />}
        {route === 'experience' && <Experience />}
        {route === 'projects'   && <Projects />}
        {route === 'contact'    && <Contact />}
        {route === 'cv'         && <CvDownload onNavigate={navigate} />}
      </main>
      <Footer />
    </>
  );
}

window.App = App;
ReactDOM.createRoot(document.getElementById('root')).render(<App />);
