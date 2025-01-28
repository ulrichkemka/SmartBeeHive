import { useNavigate } from 'react-router-dom'
import { AxiosError } from 'axios'
import { useFormik } from 'formik'
import {
  EuiFieldText,
  EuiForm,
  EuiButton,
  EuiFormRow,
  EuiTitle,
  EuiSpacer,
  EuiFieldPassword,
  EuiIcon,
} from '@elastic/eui'
import { useAuth } from '../../contexts/auth'
import { useToasts } from '../../contexts/toasts'

export default function LoginForm() {
  const navigate = useNavigate()
  const { login } = useAuth()
  const { showToasts } = useToasts()

  const formik = useFormik({
    initialValues: {
      email: '',
      password: '',
    },
    onSubmit: async (values) => {
      try {
        await login(values.email, values.password)
        showToasts([
          {
            title: 'Connexion réussie.',
            color: 'success',
          },
        ])
        navigate(`/home`)
      } catch (error) {
        // let msg = 
        // if (
        //   error instanceof AxiosError &&
        //   typeof error.response.data.message == 'string'
        // )
        //   msg = error.response.data.message
        // else if (error instanceof Error) msg = error.message
        // else msg = String(error)
        showToasts([
          {
            title: 'Une erreur est survenue lors de la connexion',
            color: 'danger',
            iconType: 'error',
            text: 'User or password is not correct ...',
          },
        ])
      }
    },
    validate: (values) => {
      const errors = {}

      if (!values.email) {
        errors.email = "Le mail de l'utilisateur est requis."
      }
      if (!values.password) {
        errors.password = 'Un mot de passe est requis.'
      }

      return errors
    },
  })

  return (
    <EuiForm component='form' onSubmit={formik.handleSubmit}>
      <EuiTitle size='l'>
        <h1>Connexion</h1>
      </EuiTitle>

      <EuiSpacer />

      <EuiFormRow
        label="Mail"
        isInvalid={Boolean(formik.touched.email && formik.errors.email)}
        error={formik.errors.email}
      >
        <EuiFieldText
          prepend={<EuiIcon type='email' />}
          placeholder='Adresse mail'
          name='email'
          onChange={formik.handleChange}
          value={formik.values.email}
        />
      </EuiFormRow>

      <EuiSpacer />

      <EuiFormRow
        label='Mot de passe'
        isInvalid={Boolean(formik.touched.password && formik.errors.password)}
        error={formik.errors.password}
      >
        <EuiFieldPassword
          placeholder='Mot de passe'
          type={'dual'}
          name='password'
          onChange={formik.handleChange}
          value={formik.values.password}
        />
      </EuiFormRow>

      <EuiSpacer />

      <EuiButton type='submit'>Se connecter</EuiButton>
    </EuiForm>
  )
}
