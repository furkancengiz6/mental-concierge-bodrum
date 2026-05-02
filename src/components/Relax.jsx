import { useState, useEffect, useRef } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Wind, X } from 'lucide-react';

const Relax = ({ onBack }) => {
  const [ripples, setRipples] = useState([]);
  const containerRef = useRef(null);

  const addRipple = (e) => {
    const rect = containerRef.current.getBoundingClientRect();
    const x = e.clientX - rect.left;
    const y = e.clientY - rect.top;
    
    const newRipple = {
      id: Date.now(),
      x,
      y,
      size: Math.random() * 100 + 50
    };

    setRipples(prev => [...prev.slice(-15), newRipple]);
  };

  const handleTouch = (e) => {
    const touch = e.touches[0];
    addRipple(touch);
  };

  useEffect(() => {
    const timer = setInterval(() => {
      setRipples(prev => prev.filter(r => Date.now() - r.id < 2000));
    }, 100);
    return () => clearInterval(timer);
  }, []);

  return (
    <div 
      ref={containerRef}
      onMouseMove={addRipple}
      onTouchMove={handleTouch}
      onTouchStart={handleTouch}
      className="absolute inset-0 bg-black overflow-hidden flex flex-col items-center justify-center cursor-none"
    >
      <div className="absolute top-8 left-8 right-8 flex justify-between items-center z-50">
        <div className="flex items-center gap-4">
          <Wind className="text-accent" size={20} />
          <span className="text-[10px] uppercase tracking-[0.6em] text-accent">Aegean Calm</span>
        </div>
        <button onClick={onBack} className="p-2 hover:bg-white/10 rounded-full transition-colors">
          <X size={24} />
        </button>
      </div>

      <div className="text-center z-10 pointer-events-none">
        <h2 className="text-4xl font-light italic mb-4 opacity-40">Move with the tide.</h2>
        <p className="text-[10px] uppercase tracking-[0.4em] text-white/20">Clear your mind through movement.</p>
      </div>

      {/* Ripple Canvas Simulation */}
      <AnimatePresence>
        {ripples.map(ripple => (
          <motion.div
            key={ripple.id}
            initial={{ scale: 0, opacity: 0.5 }}
            animate={{ scale: 4, opacity: 0 }}
            exit={{ opacity: 0 }}
            transition={{ duration: 2, ease: "easeOut" }}
            className="absolute rounded-full border border-accent/30 pointer-events-none"
            style={{
              left: ripple.x,
              top: ripple.y,
              width: ripple.size,
              height: ripple.size,
              marginLeft: -ripple.size/2,
              marginTop: -ripple.size/2,
              boxShadow: '0 0 40px rgba(212, 175, 55, 0.1)'
            }}
          />
        ))}
      </AnimatePresence>

      {/* Ambient background glow */}
      <div className="absolute inset-0 bg-[radial-gradient(circle_at_50%_50%,rgba(212,175,55,0.05),transparent_70%)]" />
      
      {/* Custom Cursor */}
      <motion.div 
        className="w-4 h-4 bg-accent rounded-full fixed pointer-events-none mix-blend-difference blur-[2px]"
        animate={{ scale: [1, 1.5, 1] }}
        transition={{ duration: 2, repeat: Infinity }}
      />
    </div>
  );
};

export default Relax;
