import { useState, useEffect } from 'react';
import { motion } from 'framer-motion';
import { bodrumData } from '../data/bodrumData';
import { ChevronLeft, MapPin, Clock, Anchor, Compass, ShoppingBag } from 'lucide-react';

export default function Directory({ onBack }) {
  const [activeTab, setActiveTab] = useState('yachts');

  // Smooth entry animation
  useEffect(() => {
    window.scrollTo(0, 0);
  }, [activeTab]);

  return (
    <div className="min-h-screen bg-[#050505] text-white font-sans selection:bg-[#D4AF37] selection:text-black">
      
      {/* Header */}
      <header className="sticky top-0 z-40 bg-[#050505]/80 backdrop-blur-xl border-b border-white/5">
        <div className="flex items-center justify-between px-6 py-6 max-w-2xl mx-auto">
          <button onClick={onBack} className="p-2 -ml-2 text-white/50 hover:text-white transition-colors">
            <ChevronLeft className="w-6 h-6" />
          </button>
          <h1 className="text-[10px] font-bold tracking-[6px] text-[#D4AF37]">THE DIRECTORY</h1>
          <div className="w-10"></div> {/* Balance spacer */}
        </div>
        
        {/* Navigation Tabs */}
        <div className="flex overflow-x-auto hide-scrollbar px-6 pb-4 max-w-2xl mx-auto space-x-6">
          <TabButton active={activeTab === 'yachts'} onClick={() => setActiveTab('yachts')} icon={<Anchor size={14}/>} label="Yachts" />
          <TabButton active={activeTab === 'dining'} onClick={() => setActiveTab('dining')} icon={<MapPin size={14}/>} label="Dining" />
          <TabButton active={activeTab === 'activities'} onClick={() => setActiveTab('activities')} icon={<Compass size={14}/>} label="Activities" />
          <TabButton active={activeTab === 'boutiques'} onClick={() => setActiveTab('boutiques')} icon={<ShoppingBag size={14}/>} label="Boutiques" />
        </div>
      </header>

      {/* Content Area */}
      <main className="px-6 py-8 max-w-2xl mx-auto pb-32">
        
        {activeTab === 'yachts' && (
          <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} className="space-y-12">
            <Section title="THE SUPERYACHT FLEET" items={bodrumData.superyachts} />
            <Section title="LUXURY CHARTERS" items={bodrumData.luxuryYachts} />
          </motion.div>
        )}

        {activeTab === 'dining' && (
          <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} className="space-y-12">
            <RestaurantSection title="YALIKAVAK MARINA" items={bodrumData.restaurants.yalikavak} />
            <RestaurantSection title="MANDARIN ORIENTAL" items={bodrumData.restaurants.mandarinOriental} />
          </motion.div>
        )}

        {activeTab === 'activities' && (
          <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} className="space-y-12">
            <Section title="CURATED EXPERIENCES" items={bodrumData.activities} isCompact />
          </motion.div>
        )}

        {activeTab === 'boutiques' && (
          <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} className="space-y-12">
             <BoutiqueSection title="DESIGNER DIRECTORY" items={bodrumData.boutiques} />
          </motion.div>
        )}

      </main>
    </div>
  );
}

// --- Subcomponents ---

const TabButton = ({ active, onClick, icon, label }) => (
  <button 
    onClick={onClick}
    className={`flex items-center space-x-2 whitespace-nowrap pb-2 border-b-2 transition-all ${
      active ? 'border-[#D4AF37] text-white' : 'border-transparent text-white/40 hover:text-white/70'
    }`}
  >
    <span className={active ? 'text-[#D4AF37]' : ''}>{icon}</span>
    <span className="text-xs tracking-widest font-light">{label.toUpperCase()}</span>
  </button>
);

const Section = ({ title, items }) => (
  <div className="space-y-6">
    <h2 className="text-[10px] font-bold tracking-[4px] text-white/40">{title}</h2>
    <div className="space-y-4">
      {items.map(item => (
        <div key={item.id} className="bg-white/[0.02] border border-white/5 rounded-2xl p-6 hover:bg-white/[0.04] transition-colors cursor-pointer group">
          <div className="flex justify-between items-start mb-2">
            <h3 className="text-2xl font-light font-serif text-white">{item.name}</h3>
            {item.length && <span className="text-[#D4AF37] text-xs tracking-widest">{item.length}</span>}
          </div>
          <p className="text-sm text-white/50 leading-relaxed font-light mb-4">{item.description}</p>
          <div className="flex items-center space-x-4 text-xs tracking-widest text-white/30">
            {item.capacity && <span>{item.capacity.toUpperCase()}</span>}
            {item.location && <span><MapPin size={10} className="inline mr-1"/> {item.location.toUpperCase()}</span>}
          </div>
        </div>
      ))}
    </div>
  </div>
);

const RestaurantSection = ({ title, items }) => (
  <div className="space-y-6">
    <h2 className="text-[10px] font-bold tracking-[4px] text-[#D4AF37]">{title}</h2>
    <div className="space-y-4">
      {items.map(item => (
        <div key={item.id} className="flex flex-col space-y-2 pb-4 border-b border-white/5 last:border-0">
          <div className="flex justify-between items-end">
            <h3 className="text-xl font-light font-serif text-white">{item.name}</h3>
            <span className="text-[10px] tracking-widest text-white/40 flex items-center">
              <Clock size={10} className="mr-1"/> {item.hours}
            </span>
          </div>
          <p className="text-sm text-white/50 font-light">{item.description}</p>
        </div>
      ))}
    </div>
  </div>
);

const BoutiqueSection = ({ title, items }) => (
  <div className="space-y-6">
    <h2 className="text-[10px] font-bold tracking-[4px] text-white/40">{title}</h2>
    <div className="space-y-2">
      {items.map(item => (
        <div key={item.id} className="flex items-center justify-between p-4 bg-white/[0.02] rounded-xl border border-white/5">
          <div>
            <h3 className="text-lg font-light font-serif text-white">{item.name}</h3>
            <p className="text-[10px] tracking-widest text-white/40 mt-1">{item.location.toUpperCase()}</p>
          </div>
          <div className="text-right">
             <span className="text-[10px] tracking-widest text-[#D4AF37]">{item.hours}</span>
          </div>
        </div>
      ))}
    </div>
  </div>
);
