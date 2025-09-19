import { useEffect } from "react";

function useAutoScale(classname: string) {
  useEffect(() => {
    const scale = () => {
      const designWidth = 1920;
      const designHeight = 1080;

      const ww = window.innerWidth;
      const wh = window.innerHeight;

      const scale = Math.min(ww / designWidth, wh / designHeight);
      const x = (ww - designWidth * scale) / 2;
      const y = (wh - designHeight * scale) / 2;

      const el = document.querySelector(classname) as HTMLElement;
      if (el) {
        el.style.transform = `translate(${x}px, ${y}px) scale(${scale})`;
      }
    };

    scale();
    window.addEventListener('resize', scale);
    return () => window.removeEventListener('resize', scale);
  }, []);
}