import { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { ChevronRight } from 'lucide-react';

const Onboarding = ({ onComplete }) => {
  const [step, setStep] = useState(0);
  const [name, setName] = useState('');

  const steps = [
    {
      title: "The Art of Hospitality",
      desc: "Welcome to Bodrum. May we know your name?",
      component: (
        <input 
          type="text" 
          value={name}
          onChange={(e) => setName(e.target.value)}
          placeholder="Your Name"
          className="w-full bg-transparent border-b border-accent py-4 text-2xl font-light focus:outline-none placeholder:opacity-20"
        />
      )
    },
    {
      title: "Your Sanctuary",
      desc: "What brings you to the peninsula?",
      options: ["Exclusive Dining", "Private Yachting", "Hidden Retreats", "Nightlife"]
    }
  ];

  const next = () => {
    if (step < steps.length - 1) setStep(step + 1);
    else onComplete({ name, preference: 'luxury' });
  };

  return (
    <div className="flex-1 flex flex-col items-center justify-center p-12 text-center bg-black">
      <AnimatePresence mode="wait">
        <motion.div 
          key={step}
          initial={{ opacity: 0, scale: 0.95 }}
          animate={{ opacity: 1, scale: 1 }}
          exit={{ opacity: 0, scale: 1.05 }}
          className="flex flex-col gap-8 w-full max-w-sm"
        >
          <span className="text-[10px] uppercase tracking-[1em] text-accent">Mental Concierge</span>
          <h1 className="text-4xl md:text-5xl font-light">{steps[step].title}</h1>
          <p className="text-text-muted text-sm tracking-wide">{steps[step].desc}</p>
          
          <div className="py-8">
            {steps[step].component}
            {steps[step].options && (
              <div className="flex flex-col gap-4">
                {steps[step].options.map(opt => (
                  <button 
                    key={opt}
                    onClick={next}
                    className="py-4 border border-white/10 hover:border-accent hover:text-accent transition-all text-xs uppercase tracking-widest"
                  >
                    {opt}
                  </button>
                ))}
              </div>
            )}
          </div>

          {!steps[step].options && (
            <button 
              onClick={next}
              disabled={step === 0 && !name}
              className="premium-button flex items-center justify-center gap-4 disabled:opacity-20"
            >
              Continue <ChevronRight size={16} />
            </button>
          )}
        </motion.div>
      </AnimatePresence>
    </div>
  );
};

export default Onboarding;
