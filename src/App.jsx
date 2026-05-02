import { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import Onboarding from './components/Onboarding';
import Home from './components/Home';
import Directory from './components/Directory';
import Relax from './components/Relax';
import LandingPage from './components/LandingPage';
import AppetizeEmulator from './components/AppetizeEmulator';
import { ShieldCheck, User, Monitor, Smartphone, X } from 'lucide-react';

function App() {
  const [showDemo, setShowDemo] = useState(false);
  const [demoMode, setDemoMode] = useState('web'); // 'web' or 'native'
  const [user, setUser] = useState(() => {
    try {
      const savedUser = localStorage.getItem('mental_concierge_user');
      return savedUser ? JSON.parse(savedUser) : null;
    } catch {
      return null;
    }
  });
  const [view, setView] = useState(() => {
    try {
      const savedUser = localStorage.getItem('mental_concierge_user');
      return savedUser ? 'home' : 'onboarding';
    } catch {
      return 'onboarding';
    }
  });
  const locationInBodrum = true; // Simulated static value

  const handleOnboardingComplete = (data) => {
    setUser(data);
    localStorage.setItem('mental_concierge_user', JSON.stringify(data));
    setView('home');
  };

  if (!showDemo) {
    return <LandingPage onEnterDemo={() => setShowDemo(true)} />;
  }

  return (
    <div className="app-container" style={{ maxWidth: 'none' }}>
      {/* Demo Controls */}
      <div style={{ 
        position: 'fixed', 
        bottom: '32px', 
        left: '50%', 
        transform: 'translateX(-50%)', 
        zIndex: 1000, 
        display: 'flex', 
        alignItems: 'center', 
        gap: '8px', 
        padding: '8px', 
        background: 'rgba(0,0,0,0.6)', 
        backdropFilter: 'blur(20px)', 
        border: '1px solid rgba(255,255,255,0.1)', 
        borderRadius: '100px', 
        boxShadow: '0 20px 40px rgba(0,0,0,0.4)' 
      }}>
        <button 
          onClick={() => setDemoMode('web')}
          style={{ 
            display: 'flex', 
            alignItems: 'center', 
            gap: '8px', 
            padding: '10px 24px', 
            borderRadius: '100px', 
            fontSize: '10px', 
            textTransform: 'uppercase', 
            letterSpacing: '0.2em', 
            transition: 'all 0.3s',
            border: 'none',
            cursor: 'pointer',
            background: demoMode === 'web' ? 'var(--accent)' : 'transparent',
            color: demoMode === 'web' ? '#000' : 'rgba(255,255,255,0.6)',
            fontWeight: demoMode === 'web' ? 'bold' : 'normal'
          }}
        >
          <Monitor size={14} /> Web View
        </button>
        <button 
          onClick={() => setDemoMode('native')}
          style={{ 
            display: 'flex', 
            alignItems: 'center', 
            gap: '8px', 
            padding: '10px 24px', 
            borderRadius: '100px', 
            fontSize: '10px', 
            textTransform: 'uppercase', 
            letterSpacing: '0.2em', 
            transition: 'all 0.3s',
            border: 'none',
            cursor: 'pointer',
            background: demoMode === 'native' ? 'var(--accent)' : 'transparent',
            color: demoMode === 'native' ? '#000' : 'rgba(255,255,255,0.6)',
            fontWeight: demoMode === 'native' ? 'bold' : 'normal'
          }}
        >
          <Smartphone size={14} /> Native Preview
        </button>
        <div style={{ width: '1px', height: '16px', background: 'rgba(255,255,255,0.1)', margin: '0 8px' }} />
        <button 
          onClick={() => setShowDemo(false)}
          style={{ 
            padding: '8px', 
            borderRadius: '50%', 
            border: 'none', 
            background: 'transparent', 
            color: 'rgba(255,255,255,0.4)', 
            cursor: 'pointer',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center'
          }}
          title="Exit Demo"
        >
          <X size={16} />
        </button>
      </div>

      {demoMode === 'native' ? (
        <AppetizeEmulator publicKey="b_ilpzkb37ouqpt4m2r2suhcfgpe" />
      ) : (
        <>
          {/* Premium Status Bar Simulation */}
          {view !== 'onboarding' && (
            <motion.header 
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              className="fixed top-0 left-0 right-0 max-w-[500px] mx-auto p-6 flex justify-between items-center z-50 pointer-events-none"
            >
              <div className="flex items-center gap-2 pointer-events-auto cursor-pointer" aria-label="Profile">
                <div className="w-8 h-8 rounded-full bg-white/5 border border-white/10 flex items-center justify-center">
                  <User size={14} className="text-white/60" />
                </div>
              </div>
              <div className="text-[10px] uppercase tracking-[0.3em] text-accent/60">
                {locationInBodrum ? "Bodrum, TR" : "Mental Concierge"}
              </div>
              <div className="flex items-center gap-2 pointer-events-auto cursor-pointer">
                <div className="w-8 h-8 rounded-full bg-white/5 border border-white/10 flex items-center justify-center">
                  <ShieldCheck size={14} className="text-accent" />
                </div>
              </div>
            </motion.header>
          )}

          <AnimatePresence mode="wait">
            {view === 'onboarding' && (
              <motion.div
                key="onboarding"
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                exit={{ opacity: 0 }}
                className="flex-1 flex flex-col"
              >
                <Onboarding onComplete={handleOnboardingComplete} />
              </motion.div>
            )}

            {view === 'home' && (
              <motion.div
                key="home"
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                exit={{ opacity: 0 }}
                className="flex-1 flex flex-col"
              >
                <Home user={user} onNavigate={setView} />
              </motion.div>
            )}

            {view === 'directory' && (
              <motion.div
                key="directory"
                initial={{ opacity: 0, x: 100 }}
                animate={{ opacity: 1, x: 0 }}
                exit={{ opacity: 0, x: -100 }}
                className="flex-1 flex flex-col"
              >
                <Directory onBack={() => setView('home')} />
              </motion.div>
            )}

            {view === 'relax' && (
              <motion.div
                key="relax"
                initial={{ opacity: 0, scale: 1.1 }}
                animate={{ opacity: 1, scale: 1 }}
                exit={{ opacity: 0, scale: 0.9 }}
                className="flex-1 flex flex-col"
              >
                <Relax onBack={() => setView('home')} />
              </motion.div>
            )}
          </AnimatePresence>
        </>
      )}
    </div>
  );
}

export default App;
