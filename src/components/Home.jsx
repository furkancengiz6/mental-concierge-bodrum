
import { motion } from 'framer-motion';
import { Compass, Wind, Calendar, ChevronRight, Star } from 'lucide-react';

const Home = ({ user, onNavigate }) => {
  return (
    <div className="flex-1 flex flex-col bg-black overflow-y-auto hide-scrollbar text-white">
      {/* Hero Header */}
      <section className="relative w-full h-[60vh] flex-shrink-0">
        <div className="absolute inset-0 bg-gradient-to-t from-black via-black/40 to-transparent z-10" />
        <div 
          className="absolute inset-0 bg-cover bg-center opacity-60"
          style={{ 
            backgroundImage: `url('/images/hero.png')`,
            backgroundColor: '#0a0a0a'
          }}
        />
        
        <div className="relative z-20 h-full flex flex-col justify-end p-10 pb-12">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
          >
            <div className="flex items-center gap-3 mb-4">
               <div className="w-1 h-1 bg-accent rounded-full animate-pulse" />
               <span className="text-[10px] uppercase tracking-[0.8em] text-accent">BODRUM EDITION</span>
            </div>
            <h1 className="text-5xl font-light leading-tight mb-2 font-serif">
                Good Evening,<br />
                <span className="italic text-white/90">{user.name}</span>
            </h1>
          </motion.div>
        </div>
      </section>

      {/* Editorial Content - Forced Vertical Layout */}
      <section className="flex flex-col gap-12 px-8 py-10 pb-32">
        
        {/* Directory Card */}
        <button 
          onClick={() => onNavigate('directory')}
          className="group relative w-full overflow-hidden rounded-sm border border-white/5 transition-all hover:border-accent/30 text-left text-white"
          style={{ 
            aspectRatio: '16/9', 
            backgroundColor: '#0a0a0a',
            display: 'block',
            width: '100%'
          }}
        >
          <div className="absolute inset-0 bg-gradient-to-br from-accent/5 to-transparent" />
          <div className="absolute inset-0 flex flex-col justify-between p-8">
            <div className="flex justify-between items-start">
                <Compass className="text-accent/30" size={24} />
                <Star size={12} className="text-accent/10" />
            </div>
            <div className="flex justify-between items-end">
                <div className="text-left w-full">
                    <h2 className="text-2xl font-light tracking-[0.2em] uppercase mb-1 font-serif text-white">The Directory</h2>
                    <p className="text-[10px] tracking-[0.4em] text-zinc-500 uppercase">Yachts, Dining & Boutiques</p>
                </div>
                <ChevronRight size={20} className="text-accent/40 group-hover:translate-x-2 transition-transform flex-shrink-0" />
            </div>
          </div>
        </button>

        {/* Relax Card */}
        <button 
          onClick={() => onNavigate('relax')}
          className="group relative w-full overflow-hidden rounded-sm border border-white/5 transition-all hover:border-blue-500/30 text-left text-white"
          style={{ 
            aspectRatio: '16/9', 
            backgroundColor: '#0a0a0a',
            display: 'block',
            width: '100%'
          }}
        >
          <div className="absolute inset-0 bg-gradient-to-br from-blue-500/5 to-transparent" />
          <div className="absolute inset-0 flex flex-col justify-between p-8">
            <div className="flex justify-between items-start">
                <Wind className="text-blue-400/30" size={24} />
                <div className="w-8 h-[1px] bg-blue-400/10 mt-3" />
            </div>
            <div className="flex justify-between items-end">
                <div className="text-left w-full">
                    <h2 className="text-2xl font-light tracking-[0.2em] uppercase mb-1 font-serif text-white">Aegean Calm</h2>
                    <p className="text-[10px] tracking-[0.4em] text-zinc-500 uppercase">Sensorial Reset</p>
                </div>
                <ChevronRight size={20} className="text-blue-400/40 group-hover:translate-x-2 transition-transform flex-shrink-0" />
            </div>
          </div>
        </button>

        {/* Itinerary Section */}
        <div className="mt-6 pt-10 border-t border-white/5 flex flex-col gap-6">
            <div className="flex items-center gap-3">
                <Calendar size={14} className="text-accent" />
                <span className="text-[9px] uppercase tracking-[0.5em] text-accent">ITINERARY ENGINE</span>
            </div>
            <p className="text-xl font-light text-zinc-400 leading-relaxed font-serif italic">
                "The evening breeze at Maçakızı is perfect for a late dinner. I've secured a tentative table for you."
            </p>
            <button className="w-full bg-accent text-black py-5 text-[10px] font-bold uppercase tracking-[0.5em] hover:bg-accent/90 transition-all">
                View Tonight's Plan
            </button>
        </div>

        {/* Member Card */}
        <div className="mt-8 p-10 bg-zinc-900/20 border border-white/5 rounded-sm flex flex-col gap-4 text-center">
             <span className="text-[9px] tracking-[0.4em] text-zinc-600 uppercase">Member Privilege</span>
             <h3 className="text-xl font-light font-serif">The Black Membership</h3>
             <p className="text-xs text-zinc-500 leading-relaxed italic">Unlock unlimited AI concierge assistance and exclusive island secrets.</p>
             <button className="text-accent text-[10px] uppercase tracking-[0.6em] underline underline-offset-8 decoration-accent/30 mt-4">Upgrade to Black</button>
        </div>

      </section>

      <footer className="py-20 flex flex-col items-center gap-4 opacity-10">
        <div className="w-4 h-4 border border-white rounded-full flex items-center justify-center">
            <div className="w-1 h-1 bg-white rounded-full" />
        </div>
        <span className="text-[8px] tracking-[1.5em] uppercase">Mental Concierge</span>
      </footer>
    </div>
  );
};

export default Home;
