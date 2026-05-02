
import React from 'react';
import { motion } from 'framer-motion';
import { Smartphone, RefreshCw, ExternalLink } from 'lucide-react';

const AppetizeEmulator = ({ publicKey = "demo", device = "iphone15pro", osVersion = "17.0" }) => {
  const embedUrl = `https://appetize.io/embed/${publicKey}?device=${device}&osVersion=${osVersion}&scale=75&orientation=portrait&centered=true&screenOnly=false`;

  return (
    <div style={{ 
      display: 'flex', 
      flexDirection: 'column', 
      alignItems: 'center', 
      justifyContent: 'center', 
      minHeight: '100vh', 
      padding: '80px 20px',
      background: 'var(--bg)'
    }}>
      <motion.div 
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        style={{ textAlign: 'center', marginBottom: '48px' }}
      >
        <h2 style={{ color: 'var(--accent)', fontSize: '10px', textTransform: 'uppercase', letterSpacing: '0.6em', marginBottom: '16px' }}>Native Experience</h2>
        <h3 style={{ fontSize: '32px', fontWeight: '300', color: 'white', marginBottom: '16px' }}>Live iOS Preview</h3>
        <p style={{ color: 'var(--text-muted)', fontSize: '14px', maxWidth: '400px', margin: '0 auto', lineHeight: '1.6' }}>
          Experience the full fidelity of the Mental Concierge Bodrum app directly in your browser.
        </p>
      </motion.div>

      <div style={{ position: 'relative' }}>
        {/* iPhone Frame Mockup */}
        <div style={{ 
          position: 'relative', 
          margin: '0 auto', 
          border: '8px solid rgba(255,255,255,0.1)', 
          borderRadius: '48px', 
          overflow: 'hidden', 
          boxShadow: '0 0 100px rgba(212, 175, 55, 0.1)', 
          background: 'black', 
          width: '320px', 
          height: '650px' 
        }}>
          <iframe 
            src={embedUrl}
            width="100%" 
            height="100%" 
            frameBorder="0" 
            scrolling="no"
            title="Mental Concierge iOS Preview"
            style={{ borderRadius: '40px' }}
          />
        </div>
      </div>

      <div style={{ marginTop: '48px', display: 'flex', gap: '24px' }}>
        <button 
          onClick={() => window.location.reload()}
          className="premium-button"
          style={{ padding: '12px 24px', letterSpacing: '0.2em' }}
        >
          <RefreshCw size={12} /> Reset
        </button>
        <a 
          href={`https://appetize.io/app/${publicKey}`}
          target="_blank"
          rel="noopener noreferrer"
          className="premium-button primary"
          style={{ padding: '12px 24px', letterSpacing: '0.2em', textDecoration: 'none' }}
        >
          <ExternalLink size={12} /> Full Screen
        </a>
      </div>

      <div className="premium-card" style={{ marginTop: '48px', maxWidth: '380px', textAlign: 'center', padding: '24px' }}>
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '12px', color: 'var(--accent)', marginBottom: '12px' }}>
          <Smartphone size={16} />
          <span style={{ fontSize: '10px', textTransform: 'uppercase', letterSpacing: '0.2em', fontWeight: 'bold' }}>Hardware Acceleration Active</span>
        </div>
        <p style={{ fontSize: '10px', color: 'var(--text-muted)', lineHeight: '1.6' }}>
          The app is running on a high-performance virtual iPhone 15 Pro. Some sensory features may be limited in web view.
        </p>
      </div>
    </div>
  );
};

export default AppetizeEmulator;
