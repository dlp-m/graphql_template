const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './app/components/**/*.html.erb',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        sidebar: {
          DEFAULT: '#3A0E52',
          50: 'rgba(255, 255, 255, 0.5)',
          200: 'rgba(255, 255, 255, 0.2)',
          900: 'rgba(0, 0, 0, 0.2)',
        },
        home: {
          DEFAULT: '#F5F5F5'
        }
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}
