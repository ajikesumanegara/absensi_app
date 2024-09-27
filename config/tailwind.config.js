const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        'primary': {
          100: '#EFF6FF',
          200: '#3B82F6',
          300: '#2563EB',
          400: '#1D4ED8',
          500: '#172554',
        },
        'grayscale': {
          100: '#F9FAFB',
          200: '#666D76',
          300: '#333C49',
          400: '#1A2332',
          500: '#000B1B',
        },
        'danger': {
          100: '#fef2f2',
          200: '#fecaca',
          300: '#ef4444',
          400: '#dc2626',
          500: '#b91c1c',
        },
        'success': {
          100: '#F0FDF4',
          200: '#BBF7D0',
          300: '#22C55E',
          400: '#16A34A',
          500: '#15803D',
        },
      },
      keyframes: {
        fadeBlink: {
          '0%, 100%': { opacity: 0 },
          '25%, 50%, 75%': { opacity: 1 },
        },
      },
      animation: {
        fadeBlink: 'fadeBlink 5s ease-in-out',
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
