import {
  EuiButton,
  EuiCheckboxGroup,
  EuiFieldPassword,
  EuiFieldText,
  EuiFlexGroup,
  EuiForm,
  EuiFormRow,
  EuiSelect,
  EuiSpacer,
  EuiTitle,
} from '@elastic/eui'
import { useFormik } from 'formik'
import { FunctionComponent, useState } from 'react'
import { useAuth } from '../../contexts/auth'
import { User } from '../../types'

interface UserFormProps {
  users: User[] | null
  user: User
  onCancel: () => void
  handleSubmit: (user: User) => void
  account: Boolean
}

const UserForm: FunctionComponent<UserFormProps> = ({
  user,
  users,
  onCancel,
  handleSubmit,
  account,
}) => {
  const { user: currentUser } = useAuth()
  const createUser = !user
  const updadeAccount = account
  const roleOptions = [
    { value: '', text: 'Sélectionner un rôle' },
    { value: 'administrateur', text: 'Administrateur' },
    { value: 'apiculteur', text: 'Apiculteur' },
  ]

  const formik = useFormik({
    initialValues: {
      id: createUser ? '' : user.id,
      username: createUser ? '' : user.username,
      nom: createUser ? '' : user.nom,
      prenom: createUser ? '' : user.prenom,
      email: createUser ? '' : user.email,
      adresse: createUser ? '' : user.adresse,
      role: createUser ? '' : user.role,
      password: '',
      confirmPassword: '',
    },
    onSubmit: (values) => {
      handleSubmit(values)
    },
    validate: (values) => {
      const errors = {}
      if (!values.username) {
        errors.username = "Veuillez renseigner un identifiant."
      } else if (
        createUser &&
        users.some(u => u.username === values.username)
      ) {
        errors.username = "Cet identifiant est déjà utilisé par un autre utilisateur."
      } else if (
        !createUser &&
        users.some(u => u.username === values.username && u.username !== user.username)
      ) {
        errors.username = "Cet identifiant est déjà utilisé par un autre utilisateur."
      }
      if (!values.nom) {
        errors.nom = "Veuillez renseigner un nom."
      }
      if (!values.prenom) {
        errors.prenom = "Veuillez renseigner un prénom."
      }
      if (!values.email) {
        errors.email = "Veuillez renseigner un email."
      } else if (!/^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$/g.test(values.email)) {
        errors.email = "Veuillez renseigner un email au bon format."
      } else if (
        createUser &&
        users.some(u => u.email === values.email)
      ) {
        errors.email = "Cet email est déjà utilisé par un autre utilisateur."
      } else if (
        !createUser &&
        users.some(u => u.email === values.email && u.email !== user.email)
      ) {
        errors.email = "Cet email est déjà utilisé par un autre utilisateur."
      }
      if (!values.adresse) {
        errors.adresse = "Veuillez renseigner une adresse postale."
      }
      if (!values.role) {
        errors.role = "Veuillez selectionner un rôle."
      }
      if (createUser && !values.password) {
        errors.password = 'Veuillez renseigner un mot de passe.'
      } else if (createUser && values.password.length < 6 ) {
        errors.password = 'Le mot de passe doit contenir au moins 6 caractères.'
      }
      if (createUser && !values.confirmPassword) {
        errors.confirmPassword = 'Veuillez confirmer le mot de passe.'
      } else if (createUser && values.confirmPassword.length < 6 ) {
        errors.confirmPassword = 'Le mot de passe doit contenir au moins 6 caractères.'
      } else if (values.password !== values.confirmPassword) {
        errors.confirmPassword = 'Les mots de passe ne correspondent pas.'
      }
      return errors
    },
  })

  return (
    <EuiForm component='form' onSubmit={formik.handleSubmit} noValidate>
      <EuiTitle size='s'>
        {createUser ? (
          <h1>Créer un compte utilisateur</h1>
        ) : (
          <h1>Modifier un compte utilisateur</h1>
        )}
      </EuiTitle>
      <EuiSpacer />
      <EuiFormRow
        fullWidth
        label="Identifiant"
        isInvalid={Boolean(formik.touched.username && formik.errors.username)}
        error={formik.errors.username}
      >
        <EuiFieldText
          fullWidth
          placeholder="Identifiant"
          name='username'
          onChange={formik.handleChange}
          value={formik.values.username}
        />
      </EuiFormRow>
      <EuiFormRow
        fullWidth
        label="Nom d'utilisateur"
        isInvalid={Boolean(formik.touched.nom && formik.errors.nom)}
        error={formik.errors.nom}
      >
        <EuiFieldText
          fullWidth
          placeholder="Nom de l'utilisateur"
          name='nom'
          onChange={formik.handleChange}
          value={formik.values.nom}
        />
      </EuiFormRow>
      <EuiFormRow
        fullWidth
        label="Prénom"
        isInvalid={Boolean(formik.touched.prenom && formik.errors.prenom)}
        error={formik.errors.prenom}
      >
        <EuiFieldText
          fullWidth
          placeholder="Prénom de l'utilisateur"
          name='prenom'
          onChange={formik.handleChange}
          value={formik.values.prenom}
        />
      </EuiFormRow>
      <EuiFormRow
        fullWidth
        label="Email"
        isInvalid={Boolean(formik.touched.email && formik.errors.email)}
        error={formik.errors.email}
      >
        <EuiFieldText
          fullWidth
          placeholder="Email de l'utilisateur"
          name='email'
          onChange={formik.handleChange}
          value={formik.values.email}
        />
      </EuiFormRow>
      <EuiFormRow
        fullWidth
        label="Adresse postale"
        isInvalid={Boolean(formik.touched.adresse && formik.errors.adresse)}
        error={formik.errors.adresse}
      >
        <EuiFieldText
          fullWidth
          placeholder="Adresse de l'utilisateur"
          name='adresse'
          onChange={formik.handleChange}
          value={formik.values.adresse}
        />
      </EuiFormRow>
      {!updadeAccount && (
        <EuiFormRow
          fullWidth
          label="Rôle"
          isInvalid={Boolean(formik.touched.role && formik.errors.role)}
          error={formik.errors.role}
        >
          <EuiSelect
            fullWidth
            placeholder="Rôle de l'utilisateur"
            name='role'
            onChange={formik.handleChange}
            value={formik.values.role}
            options={roleOptions}
          />
        </EuiFormRow>
      )}
      <EuiFormRow
        fullWidth
        label='Mot de passe'
        isInvalid={Boolean(formik.touched.password && formik.errors.password)}
        error={formik.errors.password}
      >
        <EuiFieldPassword
          fullWidth
          placeholder='Entrer le mot de passe'
          type={'dual'}
          name='password'
          onChange={formik.handleChange}
          value={formik.values.password}
          role='textbox'
        />
      </EuiFormRow>
      <EuiFormRow
        fullWidth
        label='Confirmer le mot de passe'
        isInvalid={Boolean(
          formik.touched.confirmPassword && formik.errors.confirmPassword
        )}
        error={formik.errors.confirmPassword}
      >
        <EuiFieldPassword
          fullWidth
          placeholder='Confirmer le mot de passe'
          type={'dual'}
          name='confirmPassword'
          onChange={formik.handleChange}
          value={formik.values.confirmPassword}
          role='textbox'
        />
      </EuiFormRow>
      <EuiSpacer />
      <EuiFlexGroup>
          <EuiButton type='submit'>
            {createUser? 'Créer' : 'Modifier'}
          </EuiButton>
        <EuiButton onClick={onCancel} color={'danger'}>
          Annuler
        </EuiButton>
      </EuiFlexGroup>
    </EuiForm>
  )
}

export default UserForm
