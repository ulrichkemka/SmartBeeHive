import { EuiGlobalToastList } from '@elastic/eui'
import { v4 as uuidv4 } from 'uuid'
import { createContext, FC, useState, ReactNode, useContext } from 'react'

interface Toast {
  id: string
  title?: string
  text?: string | ReactNode
  color?: string
  iconType?: string
  toastLifeTimeMs?: number
}

type ToastsContextActions = {
  showToasts: (toasts: Toast[], timeout?: number) => void
}

const ToastsContext = createContext<ToastsContextActions>(
  {} as ToastsContextActions
)

interface ToastsContextProviderProps {
  children: ReactNode
}

const ToastsProvider: FC<ToastsContextProviderProps> = ({ children }) => {
  const [toasts, setToasts] = useState<Toast[]>([])
  const [timeout, setTimeout] = useState<number>(5000)

  const showToasts = (toasts: Toast[], timeout?: number) => {
    if (toasts) {
      toasts.forEach((toast) => {
        if (!toast.id) {
          toast.id = uuidv4()
        }
      })
    }
    setToasts(toasts)
    if (timeout) {
      setTimeout(timeout)
    }
  }

  const handleClose = () => {
    setToasts([])
    setTimeout(5000)
  }

  return (
    <ToastsContext.Provider value={{ showToasts }}>
      <EuiGlobalToastList
        toasts={toasts}
        dismissToast={handleClose}
        toastLifeTimeMs={timeout}
      />
      {children}
    </ToastsContext.Provider>
  )
}

const useToasts = (): ToastsContextActions => {
  const context = useContext(ToastsContext)

  if (!context) {
    throw new Error('useToasts must be used within a ToastsContextProvider')
  }

  return context
}

export { ToastsProvider, useToasts }
