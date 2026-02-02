#!/usr/bin/env bash
set -e



# Remove if exists
rm -rf "${PROJECT}" "${ZIPNAME}"
mkdir -p "${PROJECT}/public" "${PROJECT}/styles" "${PROJECT}/pages" "${PROJECT}/components" "${PROJECT}/lib" "${PROJECT}/locales"

cat > "${PROJECT}/package.json" <<'EOF'
{
  "name": "tonxz-web",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint"
  },
  "dependencies": {
    "next": "13.5.0",
    "react": "18.2.0",
    "react-dom": "18.2.0"
  },
  "devDependencies": {
    "autoprefixer": "^10.4.14",
    "postcss": "^8.4.24",
    "tailwindcss": "^3.4.7",
    "typescript": "^5.2.2"
  }
}
EOF

cat > "${PROJECT}/next.config.js" <<'EOF'
/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  i18n: {
    locales: ['es', 'en'],
    defaultLocale: 'es'
  }
}
module.exports = nextConfig
EOF

cat > "${PROJECT}/tsconfig.json" <<'EOF'
{
  "compilerOptions": {
    "target": "ES2020",
    "lib": ["dom", "dom.iterable", "esnext"],
    "allowJs": false,
    "skipLibCheck": true,
    "strict": true,
    "forceConsistentCasingInFileNames": true,
    "noEmit": true,
    "esModuleInterop": true,
    "module": "ESNext",
    "moduleResolution": "Node",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "incremental": true,
    "types": ["node"]
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx"],
  "exclude": ["node_modules"]
}
EOF

cat > "${PROJECT}/next-env.d.ts" <<'EOF'
/// <reference types="next" />
/// <reference types="next/types/global" />
/// <reference types="next/image-types/global" />
EOF

cat > "${PROJECT}/postcss.config.js" <<'EOF'
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {}
  }
}
EOF

cat > "${PROJECT}/tailwind.config.js" <<'EOF'
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./pages/**/*.{ts,tsx}",
    "./components/**/*.{ts,tsx}"
  ],
  theme: {
    extend: {
      colors: {
        tonxz: {
          50: '#f7fdfc',
          100: '#ecfbf9',
          200: '#d2f6ef',
          300: '#9feedd',
          400: '#64e1cb',
          500: '#2DD4BF',
          600: '#22bca8',
          700: '#1b9b87',
          800: '#166e60',
          900: '#0f493e'
        },
        accent: {
          400: '#7DD3FC',
          500: '#C7B3FF'
        }
      }
    }
  },
  plugins: []
}
EOF

cat > "${PROJECT}/.gitignore" <<'EOF'
node_modules
.next
.env
.DS_Store
.vscode
EOF

cat > "${PROJECT}/public/logo-text.svg" <<'EOF'
<svg xmlns="http://www.w3.org/2000/svg" width="240" height="48" viewBox="0 0 240 48">
  <rect width="240" height="48" rx="8" fill="#2DD4BF"/>
  <text x="24" y="32" font-family="Inter, Arial, sans-serif" font-size="20" fill="#062023">TONXZ</text>
</svg>
EOF

cat > "${PROJECT}/styles/globals.css" <<'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

html, body, #__next {
  height: 100%;
}

body {
  @apply bg-gradient-to-b from-tonxz-50 via-white to-white text-slate-800;
  font-family: Inter, ui-sans-serif, system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial;
}

.heading {
  @apply text-3xl md:text-4xl font-extrabold text-slate-900;
}
EOF

cat > "${PROJECT}/locales/es.json" <<'EOF'
{
  "site": {
    "title": "TONXZ",
    "slogan": "Tu universo de conocimiento y motivación en un solo lugar."
  },
  "nav": {
    "home": "Inicio",
    "explora": "Explora",
    "inspira": "Inspira",
    "mediateca": "Mediateca",
    "herramientas": "Herramientas"
  },
  "hero": {
    "title": "Despierta tu curiosidad. Crece cada día.",
    "cta": "Empezar ahora"
  },
  "explora": {
    "intro": "Encuentra contenido verificado organizado por categorías: Historia, Ciencia, Cultura, Filosofía, Matemáticas, Comunicación y más."
  },
  "inspira": {
    "intro": "Frases del día, historias de éxito y retos personales para motivarte a dar el siguiente paso."
  },
  "mediateca": {
    "intro": "Libros, videos y una colección de imágenes libres de derechos para aprendizaje y proyectos."
  },
  "herramientas": {
    "intro": "Planificador de estudios, creador de presentaciones y foros de colaboración."
  },
  "footer": {
    "rights": "© TONXZ — Todos los derechos reservados."
  }
}
EOF

cat > "${PROJECT}/locales/en.json" <<'EOF'
{
  "site": {
    "title": "TONXZ",
    "slogan": "Your universe of knowledge and motivation in one place."
  },
  "nav": {
    "home": "Home",
    "explora": "Explore",
    "inspira": "Inspire",
    "mediateca": "Media",
    "herramientas": "Tools"
  },
  "hero": {
    "title": "Awaken your curiosity. Grow every day.",
    "cta": "Get started"
  },
  "explora": {
    "intro": "Find verified content organized by categories: History, Science, Culture, Philosophy, Math, Communication and more."
  },
  "inspira": {
    "intro": "Daily quotes, success stories and personal challenges to motivate your next step."
  },
  "mediateca": {
    "intro": "Books, videos and a collection of free-to-use images for learning and projects."
  },
  "herramientas": {
    "intro": "Study planner, presentation builder and collaboration forums."
  },
  "footer": {
    "rights": "© TONXZ — All rights reserved."
  }
}
EOF

cat > "${PROJECT}/lib/i18n.ts" <<'EOF'
import es from '../locales/es.json';
import en from '../locales/en.json';
import { useRouter } from 'next/router';

const translations: Record<string, any> = {
  es,
  en
};

export function useT() {
  const { locale } = useRouter();
  const t = translations[locale ?? 'es'];
  return t;
}
EOF

cat > "${PROJECT}/pages/_app.tsx" <<'EOF'
import '../styles/globals.css'
import type { AppProps } from 'next/app'
import Layout from '../components/Layout'

export default function App({ Component, pageProps }: AppProps) {
  return (
    <Layout>
      <Component {...pageProps} />
    </Layout>
  )
}
EOF

cat > "${PROJECT}/components/Layout.tsx" <<'EOF'
import React from 'react'
import Header from './Header'
import Footer from './Footer'

const Layout: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  return (
    <div className="min-h-screen flex flex-col">
      <Header />
      <main className="flex-1 container mx-auto px-4 py-12">
        {children}
      </main>
      <Footer />
    </div>
  )
}

export default Layout
EOF

cat > "${PROJECT}/components/Header.tsx" <<'EOF'
import Link from 'next/link'
import Image from 'next/image'
import { useT } from '../lib/i18n'
import LanguageSwitcher from './LanguageSwitcher'

const Header: React.FC = () => {
  const t = useT()
  return (
    <header className="bg-white/60 backdrop-blur sticky top-0 z-30 border-b">
      <div className="container mx-auto px-4 py-4 flex items-center justify-between">
        <Link href="/" locale={false}>
          <a className="flex items-center gap-3">
            <Image src="/logo-text.svg" alt="TONXZ" width={140} height={28} />
            <div className="hidden md:block text-sm text-slate-600">{t.site.slogan}</div>
          </a>
        </Link>

        <nav className="flex items-center gap-6">
          <Link href="/" locale={false}><a className="text-slate-700 hover:text-tonxz-600">{t.nav.home}</a></Link>
          <Link href="/explora" locale={false}><a className="text-slate-700 hover:text-tonxz-600">{t.nav.explora}</a></Link>
          <Link href="/inspira" locale={false}><a className="text-slate-700 hover:text-tonxz-600">{t.nav.inspira}</a></Link>
          <Link href="/mediateca" locale={false}><a className="text-slate-700 hover:text-tonxz-600">{t.nav.mediateca}</a></Link>
          <Link href="/herramientas" locale={false}><a className="text-slate-700 hover:text-tonxz-600">{t.nav.herramientas}</a></Link>

          <LanguageSwitcher />
        </nav>
      </div>
    </header>
  )
}

export default Header
EOF

cat > "${PROJECT}/components/LanguageSwitcher.tsx" <<'EOF'
import { useRouter } from 'next/router'

const LanguageSwitcher: React.FC = () => {
  const router = useRouter()
  const { locale, asPath } = router

  const toggle = () => {
    const nextLocale = locale === 'es' ? 'en' : 'es'
    router.push(asPath, asPath, { locale: nextLocale })
  }

  return (
    <button onClick={toggle} className="px-3 py-1 rounded-md bg-tonxz-50 border text-sm">
      {locale === 'es' ? 'ES' : 'EN'}
    </button>
  )
}

export default LanguageSwitcher
EOF

cat > "${PROJECT}/components/Footer.tsx" <<'EOF'
import { useT } from '../lib/i18n'

const Footer: React.FC = () => {
  const t = useT()
  return (
    <footer className="bg-white border-t mt-12">
      <div className="container mx-auto px-4 py-6 text-center text-sm text-slate-600">
        {t.footer.rights}
      </div>
    </footer>
  )
}

export default Footer
EOF

cat > "${PROJECT}/pages/index.tsx" <<'EOF'
import Link from 'next/link'
import { useT } from '../lib/i18n'

export default function Home() {
  const t = useT()
  return (
    <>
      <section className="text-center max-w-3xl mx-auto">
        <h1 className="heading mb-4">{t.hero.title}</h1>
        <p className="text-lg text-slate-700 mb-6">{t.site.slogan}</p>
        <Link href="/explora"><a className="inline-block bg-tonxz-500 text-white px-6 py-3 rounded-md shadow hover:opacity-95">{t.hero.cta}</a></Link>
      </section>

      <section className="grid md:grid-cols-2 gap-8 mt-12">
        <article className="p-6 bg-white rounded-lg shadow">
          <h3 className="font-semibold text-xl mb-2">{t.nav.explora}</h3>
          <p className="text-slate-600">{t.explora.intro}</p>
        </article>

        <article className="p-6 bg-white rounded-lg shadow">
          <h3 className="font-semibold text-xl mb-2">{t.nav.inspira}</h3>
          <p className="text-slate-600">{t.inspira.intro}</p>
        </article>

        <article className="p-6 bg-white rounded-lg shadow">
          <h3 className="font-semibold text-xl mb-2">{t.nav.mediateca}</h3>
          <p className="text-slate-600">{t.mediateca.intro}</p>
        </article>

        <article className="p-6 bg-white rounded-lg shadow">
          <h3 className="font-semibold text-xl mb-2">{t.nav.herramientas}</h3>
          <p className="text-slate-600">{t.herramientas.intro}</p>
        </article>
      </section>
    </>
  )
}
EOF

cat > "${PROJECT}/pages/explora.tsx" <<'EOF'
import { useT } from '../lib/i18n'

export default function Explora() {
  const t = useT()
  return (
    <div>
      <h1 className="heading mb-4">{t.nav.explora}</h1>
      <p className="text-slate-700 mb-6">{t.explora.intro}</p>

      <div className="grid md:grid-cols-3 gap-6">
        <div className="p-6 bg-white rounded-lg shadow">
          <h4 className="font-semibold">Historia</h4>
          <p className="text-sm text-slate-600 mt-2">Líneas de tiempo, biografías y análisis sobre momentos cruciales.</p>
        </div>
        <div className="p-6 bg-white rounded-lg shadow">
          <h4 className="font-semibold">Ciencia</h4>
          <p className="text-sm text-slate-600 mt-2">Conceptos claros, simulaciones y videos explicativos.</p>
        </div>
        <div className="p-6 bg-white rounded-lg shadow">
          <h4 className="font-semibold">Cultura & Filosofía</h4>
          <p className="text-sm text-slate-600 mt-2">Arte, música, corrientes filosóficas y foros de debate.</p>
        </div>
      </div>
    </div>
  )
}
EOF

cat > "${PROJECT}/pages/inspira.tsx" <<'EOF'
import { useT } from '../lib/i18n'

export default function Inspira() {
  const t = useT()
  return (
    <div>
      <h1 className="heading mb-4">{t.nav.inspira}</h1>
      <p className="text-slate-700 mb-6">{t.inspira.intro}</p>

      <section className="grid md:grid-cols-2 gap-6">
        <div className="p-6 bg-white rounded-lg shadow">
          <h4 className="font-semibold">Frase del Día</h4>
          <p className="mt-2 text-slate-600 italic">"La educación es el arma más poderosa para cambiar el mundo." — Nelson Mandela</p>
        </div>

        <div className="p-6 bg-white rounded-lg shadow">
          <h4 className="font-semibold">Retos Personales</h4>
          <ul className="mt-2 text-slate-600 list-disc list-inside">
            <li>Una semana de aprendizaje diario (15 min/día)</li>
            <li>Desafío de escritura: 1 ensayo breve por semana</li>
          </ul>
        </div>
      </section>
    </div>
  )
}
EOF

cat > "${PROJECT}/pages/mediateca.tsx" <<'EOF'
import { useT } from '../lib/i18n'
import Link from 'next/link'

export default function Mediateca() {
  const t = useT()
  return (
    <div>
      <h1 className="heading mb-4">{t.nav.mediateca}</h1>
      <p className="text-slate-700 mb-6">{t.mediateca.intro}</p>

      <div className="grid md:grid-cols-3 gap-6">
        <div className="p-6 bg-white rounded-lg shadow">
          <h4 className="font-semibold">Biblioteca Digital</h4>
          <p className="text-slate-600 mt-2">Acceso a clásicos y ensayos seleccionados.</p>
        </div>
        <div className="p-6 bg-white rounded-lg shadow">
          <h4 className="font-semibold">Videoteca</h4>
          <p className="text-slate-600 mt-2">Documentales y conferencias curadas.</p>
        </div>
        <div className="p-6 bg-white rounded-lg shadow">
          <h4 className="font-semibold">Banco de Imágenes</h4>
          <p className="text-slate-600 mt-2">Imágenes libres para proyectos educativos.</p>
        </div>
      </div>
    </div>
  )
}
EOF

cat > "${PROJECT}/pages/herramientas.tsx" <<'EOF'
import { useT } from '../lib/i18n'

export default function Herramientas() {
  const t = useT()
  return (
    <div>
      <h1 className="heading mb-4">{t.nav.herramientas}</h1>
      <p className="text-slate-700 mb-6">{t.herramientas.intro}</p>

      <div className="grid md:grid-cols-2 gap-6">
        <div className="p-6 bg-white rounded-lg shadow">
          <h4 className="font-semibold">Planificador de Estudios</h4>
          <p className="text-slate-600 mt-2">Organiza horarios, metas y seguimiento.</p>
        </div>
        <div className="p-6 bg-white rounded-lg shadow">
          <h4 className="font-semibold">Creador de Presentaciones</h4>
          <p className="text-slate-600 mt-2">Plantillas visuales y recursos para presentaciones.</p>
        </div>
      </div>
    </div>
  )
}
EOF

cat > "${PROJECT}/README.md" <<'EOF'
TONXZ - Starter web (Next.js + Tailwind)

- Idiomas: Español (por defecto) y English
- Framework: Next.js en TypeScript
- CSS: Tailwind CSS

- Contentful
- Supabase
- EOF

${PROJECT}/.."
zip -r ${ZIPNAME} ${PROJECT} -x ${PROJECT}/node_modules/* ${PROJECT}/.next

cd ${PROJECT} && npm install && npm run dev

# End of script
chmod +x create_tonxz.sh
./create_tonxz.sh