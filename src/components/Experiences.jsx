import { motion } from 'framer-motion';
import { ChevronLeft, MapPin } from 'lucide-react';

const Experiences = ({ onBack }) => {
  const items = [
    {
      title: "Private Yacht Experience",
      desc: "An afternoon sailing the crystal bays of Bodrum on a custom 40m gulet.",
      image: "/images/yacht.png",
      tag: "Exclusive"
    },
    {
      title: "Hidden Aegean Gems",
      desc: "A private table at a family-run terrace overlooking the harbor.",
      image: "/images/dining.png",
      tag: "Hidden"
    },
    {
      title: "Silent Beach Sanctuary",
      desc: "Absolute solitude on the north peninsula. No phones, just the sea.",
      image: "/images/silent_beach.png",
      tag: "Calm"
    },
    {
      title: "The White Cabana",
      desc: "Premium beach service with private deck and underwater viewing.",
      image: "/images/beach_club.png",
      tag: "Premium"
    },
    {
      title: "Nocturnal Aegean",
      desc: "An elegant night of jazz and deep house at the limestone cliffs.",
      image: "/images/night.png",
      tag: "Vibrant"
    }
  ];

  return (
    <div className="flex-1 flex flex-col bg-black overflow-y-auto hide-scrollbar text-white">
      {/* Header */}
      <div className="flex items-center justify-between p-8 pt-16">
        <button onClick={onBack} className="p-2 hover:bg-white/5 rounded-full transition-all">
          <ChevronLeft size={28} strokeWidth={1} />
        </button>
        <div className="text-right">
            <span className="text-[10px] uppercase tracking-[0.6em] text-accent">THE SELECTION</span>
            <h1 className="text-2xl font-light font-serif mt-1">Curated For You</h1>
        </div>
      </div>

      {/* List */}
      <div className="flex flex-col gap-16 px-8 pb-32">
        {items.map((item, idx) => (
          <motion.div 
            key={idx}
            initial={{ opacity: 0, y: 30 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            className="flex flex-col gap-6"
          >
            <div className="relative aspect-[16/10] w-full overflow-hidden rounded-sm bg-zinc-900">
              <img 
                src={item.image} 
                alt={item.title} 
                className="w-full h-full object-cover opacity-60 transition-transform duration-1000 hover:scale-105"
                onError={(e) => e.target.style.display = 'none'}
              />
              <div className="absolute top-6 left-6 bg-accent text-black px-3 py-1 text-[9px] font-bold uppercase tracking-widest">
                {item.tag}
              </div>
            </div>
            
            <div className="flex flex-col gap-4">
              <div className="flex items-center gap-2 text-[9px] text-accent uppercase tracking-[0.4em]">
                <MapPin size={10} /> Bodrum Peninsula
              </div>
              <h2 className="text-3xl font-light font-serif tracking-tight leading-tight">{item.title}</h2>
              <p className="text-zinc-500 text-sm leading-relaxed italic">{item.desc}</p>
              <button className="premium-button primary w-full py-4 mt-2">Check Availability</button>
            </div>
          </motion.div>
        ))}
      </div>
    </div>
  );
};

export default Experiences;
