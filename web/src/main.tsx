import './axios'
import React from 'react'
import ReactDOM from 'react-dom'
import { createBrowserRouter, RouterProvider } from 'react-router-dom'
import { Global } from '@emotion/react'
import { EuiProvider } from '@elastic/eui'
import { AuthProvider } from './contexts/auth'
import { ToastsProvider } from './contexts/toasts'
import { routes } from './Routes'
import '@elastic/eui/dist/eui_theme_light.css'
import './index.css'
import './icons'

const router = createBrowserRouter(routes)

ReactDOM.render(
  <React.StrictMode>
    <EuiProvider colorMode='light'>
      <Global
        styles={{
          '*:focus:focus-visible': {
            outlineStyle: 'none',
          },
        }}
      />
      <AuthProvider>
        <ToastsProvider>
          <RouterProvider router={router} />
        </ToastsProvider>
      </AuthProvider>
    </EuiProvider>
  </React.StrictMode>,
  document.getElementById('root')
)
