
import { motion } from 'framer-motion';
import { Apple, ArrowRight, ShieldCheck, MapPin, Wind, Compass, Star } from 'lucide-react';

const LandingPage = ({ onEnterDemo }) => {
  return (
    <div className="bg-black text-white selection:bg-accent selection:text-black">
      {/* Navigation */}
      <nav className="fixed top-0 left-0 right-0 z-50 flex justify-between items-center px-8 py-6 backdrop-blur-md bg-black/20">
        <div className="flex items-center gap-2">
          <div className="w-8 h-8 rounded-full border border-accent flex items-center justify-center">
            <div className="w-2 h-2 bg-accent rounded-full" />
          </div>
          <span className="text-xs font-bold tracking-[0.4em] uppercase">Mental Concierge</span>
        </div>
        <div className="hidden md:flex items-center gap-12 text-[10px] uppercase tracking-widest text-text-muted">
          <a href="#experience" className="hover:text-accent transition-colors">Experience</a>
          <a href="#services" className="hover:text-accent transition-colors">Services</a>
          <a href="#membership" className="hover:text-accent transition-colors">Membership</a>
        </div>
        <button 
          onClick={onEnterDemo}
          className="text-[10px] uppercase tracking-widest border border-white/20 px-6 py-2 rounded-full hover:border-accent hover:text-accent transition-all"
        >
          Web Demo
        </button>
      </nav>

      {/* Hero Section */}
      <section className="relative min-h-screen flex flex-col items-center justify-center pt-20 overflow-hidden">
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_50%_50%,rgba(212,175,55,0.1),transparent_70%)]" />
        
        <motion.div 
          initial={{ opacity: 0, y: 30 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 1 }}
          className="relative z-10 text-center"
        >
          <h2 className="text-accent text-sm md:text-base uppercase tracking-[0.6em] mb-6">Bodrum Edition</h2>
          <h1 className="text-5xl md:text-8xl font-light mb-12 leading-tight">
            The Aegean,<br /><span className="italic">Reimagined.</span>
          </h1>
          
          <div className="flex flex-col md:flex-row items-center justify-center gap-6">
            <button className="premium-button primary px-12 py-5 flex items-center gap-4 group">
              <Apple size={20} />
              <span className="text-sm">Download on App Store</span>
            </button>
            <button 
              onClick={onEnterDemo}
              className="flex items-center gap-2 text-text-muted hover:text-white transition-all text-xs uppercase tracking-widest group"
            >
              Explore Interactive Demo <ArrowRight size={14} className="group-hover:translate-x-1 transition-transform" />
            </button>
          </div>
        </motion.div>

        {/* Scroll Indicator */}
        <motion.div 
          animate={{ y: [0, 10, 0] }}
          transition={{ duration: 2, repeat: Infinity }}
          className="absolute bottom-12 left-1/2 -translate-x-1/2 text-white/20"
        >
          <div className="w-px h-12 bg-gradient-to-b from-white/20 to-transparent mx-auto" />
        </motion.div>
      </section>

      {/* Feature Showcase */}
      <section id="experience" className="py-32 px-8 max-w-6xl mx-auto">
        <div className="grid md:grid-grid-cols-2 gap-24 items-center">
          <motion.div 
            initial={{ opacity: 0, x: -50 }}
            whileInView={{ opacity: 1, x: 0 }}
            viewport={{ once: true }}
            className="flex flex-col gap-8"
          >
            <div className="flex items-center gap-4 text-accent">
              <ShieldCheck size={20} />
              <span className="text-[10px] uppercase tracking-[0.4em]">Personalized Intelligence</span>
            </div>
            <h2 className="text-4xl md:text-6xl font-light">Your Private Key to the Island.</h2>
            <p className="text-text-muted text-lg leading-relaxed">
              Mental Concierge is an elite digital gateway designed for the discerning traveler. We bridge the gap between AI-driven intelligence and high-end human hospitality.
            </p>
            <div className="grid grid-cols-2 gap-8 mt-4">
              <div className="flex flex-col gap-2">
                <span className="text-2xl font-light">24/7</span>
                <span className="text-[10px] uppercase tracking-widest text-text-muted">VIP Assistance</span>
              </div>
              <div className="flex flex-col gap-2">
                <span className="text-2xl font-light">100%</span>
                <span className="text-[10px] uppercase tracking-widest text-text-muted">Bespoke Curation</span>
              </div>
            </div>
          </motion.div>
          
          <div className="relative">
            <div className="absolute inset-0 bg-accent/20 blur-[120px] rounded-full" />
            <div className="relative aspect-[9/16] max-w-[320px] mx-auto rounded-[48px] border-[8px] border-white/10 overflow-hidden shadow-2xl bg-black">
              {/* This would be an image/video of the App UI */}
              <div className="w-full h-full flex items-center justify-center bg-black">
                 <div className="scale-50">
                    <div className="relative w-64 h-64 flex items-center justify-center">
                        <div className="absolute inset-0 bg-accent rounded-full blur-[60px] opacity-20" />
                        <div className="w-40 h-40 rounded-full border border-white/10 bg-gradient-to-br from-white/10 to-transparent" />
                    </div>
                 </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Services Section */}
      <section id="services" className="py-32 bg-white/5">
        <div className="max-w-6xl mx-auto px-8">
            <div className="text-center mb-24">
                <h2 className="text-[10px] uppercase tracking-[0.6em] text-accent mb-4">Curated Offerings</h2>
                <h3 className="text-4xl md:text-6xl font-light">The Unseen Bodrum.</h3>
            </div>
            
            <div className="grid md:grid-cols-3 gap-12">
                {[
                    { icon: <Compass />, title: "Yachting", desc: "Private gulets and custom itineraries across the Aegean coast." },
                    { icon: <Star />, title: "Gastronomy", desc: "Invitation-only tables at family-run gems and Michelin spots." },
                    { icon: <Wind />, title: "Relaxation", desc: "The Aegean Calm module, built to sensorial reset your travel fatigue." }
                ].map((service, i) => (
                    <motion.div 
                        key={i}
                        whileHover={{ y: -10 }}
                        className="premium-card flex flex-col items-center text-center gap-6"
                    >
                        <div className="p-4 bg-accent/10 rounded-full text-accent">
                            {service.icon}
                        </div>
                        <h4 className="text-xl uppercase tracking-widest font-light">{service.title}</h4>
                        <p className="text-sm text-text-muted leading-relaxed">{service.desc}</p>
                    </motion.div>
                ))}
            </div>
        </div>
      </section>

      {/* Membership */}
      <section id="membership" className="py-32 px-8">
        <div className="max-w-4xl mx-auto premium-card bg-accent/5 border-accent/20 p-12 md:p-24 text-center flex flex-col items-center gap-12">
            <MapPin className="text-accent" size={32} />
            <div className="flex flex-col gap-6">
                <h2 className="text-3xl md:text-5xl font-light italic">The Black Membership.</h2>
                <p className="text-text-muted text-lg max-w-xl mx-auto">
                    Priority access to Yalıkavak’s most coveted events and 24/7 dedicated personal concierge support.
                </p>
            </div>
            <button className="premium-button primary px-16 py-5">
                Apply for Privilege
            </button>
        </div>
      </section>

      {/* Footer */}
      <footer className="py-12 border-t border-white/5 px-8">
        <div className="max-w-6xl mx-auto flex flex-col md:flex-row justify-between items-center gap-8">
            <div className="text-[10px] uppercase tracking-widest text-text-muted">
                © 2026 Mental Concierge Bodrum Edition.
            </div>
            <div className="flex gap-8 text-[10px] uppercase tracking-widest text-text-muted">
                <a href="#" className="hover:text-white transition-colors">Privacy</a>
                <a href="#" className="hover:text-white transition-colors">Terms</a>
                <a href="#" className="hover:text-white transition-colors">Contact</a>
            </div>
        </div>
      </footer>
    </div>
  );
};

export default LandingPage;
