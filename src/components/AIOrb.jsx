
import { motion } from 'framer-motion';

const AIOrb = () => {
  return (
    <div className="relative w-64 h-64 flex items-center justify-center">
      {/* Liquid Aura (Siri-style) */}
      <motion.div
        animate={{
          scale: [1, 1.1, 0.9, 1],
          rotate: [0, 90, 180, 270, 360],
          filter: ["blur(40px)", "blur(60px)", "blur(40px)"]
        }}
        transition={{
          duration: 10,
          repeat: Infinity,
          ease: "linear"
        }}
        className="absolute inset-0 rounded-full opacity-40"
        style={{ 
          background: 'conic-gradient(from 0deg, #D4AF37, #3b82f6, #a855f7, #D4AF37)',
          mixBlendMode: 'screen'
        }}
      />
      
      {/* Inner Core (Liquid Glass) */}
      <motion.div
        animate={{
          scale: [1, 1.05, 1],
        }}
        transition={{
          duration: 4,
          repeat: Infinity,
          ease: "easeInOut"
        }}
        className="relative w-44 h-44 rounded-full flex items-center justify-center overflow-hidden"
        style={{ 
          background: 'rgba(255, 255, 255, 0.03)',
          backdropFilter: 'blur(30px)',
          border: '1px solid rgba(255, 255, 255, 0.1)',
          boxShadow: 'inset 0 0 30px rgba(255, 255, 255, 0.05), 0 0 50px rgba(212, 175, 55, 0.1)'
        }}
      >
        <div className="absolute inset-0 bg-gradient-to-br from-white/10 to-transparent opacity-50" />
        
        {/* Pulsing Center */}
        <motion.div
            animate={{
                scale: [1, 2, 1],
                opacity: [0.3, 0.7, 0.3]
            }}
            transition={{
                duration: 3,
                repeat: Infinity,
                ease: "easeInOut"
            }}
            className="w-3 h-3 bg-accent rounded-full blur-[4px]"
        />
      </motion.div>
    </div>
  );
};

export default AIOrb;
