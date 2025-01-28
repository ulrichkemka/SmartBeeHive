import { FunctionComponent } from 'react'
import {
  EuiForm,
  EuiFormRow,
  EuiTextArea,
  EuiDatePicker,
  EuiSpacer,
  EuiTitle,
  EuiButton,
  EuiFlexGroup,
  EuiFieldText,
  EuiText,
  EuiSelect,
} from '@elastic/eui'
import { Ruche } from '../../types'
import { useNavigate, useParams } from 'react-router-dom'
import { useFormik } from 'formik'
import { AxiosError } from 'axios'
import { useToasts } from '../../contexts/toasts'

interface RucheFormProps {
  ruche: Ruche | null
  onCancel: () => void
  handleSubmit: (ruche: Ruche) => void
}

const RucheForm: FunctionComponent<RucheFormProps> = ({
  ruche,
  onCancel,
  handleSubmit,
}) => {

  const createRuche = !ruche
  const roleOptions = [
    { value: '', text: 'Sélectionnez un état' },
    { value: '1', text: 'Activer' },
    { value: '0', text: 'Désactiver' },
  ]

  const formik = useFormik({
    initialValues: {
      id: createRuche ? '' : ruche.id,
      nom: createRuche ? '' : ruche.nom,
      description: createRuche ? '' : ruche.description,
      adresseMac: createRuche ? '' : ruche.adresseMac,
      email: createRuche ? '' : ruche.email,
    },
    onSubmit: handleSubmit,
    validate: (values) => {
      const errors = {}
      if (!values.nom) {
        errors.nom = 'Veuillez renseigner un nom.'
      }
      if (!values.description) {
        errors.description = 'Veuillez renseigner une description.'
      }
      if (createRuche && !values.adresseMac) {
        errors.adresseMac = 'Veuillez renseigner une adresse mac.'
      }
      if (!values.email) {
        errors.email = 'Veuillez selectionner un état.'
      }
      return errors
    },
  })

  return (
    <EuiForm component='form' onSubmit={formik.handleSubmit} noValidate>
      <EuiTitle size='m'>
        {createRuche ? (
          <h1>Créer une ruche </h1>
        ) : (
          <h1>Modifier une ruche</h1>
        )}
      </EuiTitle>
      <EuiSpacer />
      <EuiFormRow
        fullWidth
        label='Nom'
        isInvalid={Boolean(formik.touched.nom && formik.errors.nom)}
        error={formik.errors.nom}
      >
        <EuiFieldText
          fullWidth
          placeholder='Nom de la ruche'
          name='nom'
          onChange={formik.handleChange}
          value={formik.values.nom}
        />
      </EuiFormRow>
      <EuiFormRow
        fullWidth
        label='Descritopn'
        isInvalid={Boolean(formik.touched.description && formik.errors.description)}
        error={formik.errors.description}
      >
        <EuiFieldText
          fullWidth
          placeholder='Descritopn de la ruche'
          name='description'
          onChange={formik.handleChange}
          value={formik.values.description}
        />
      </EuiFormRow>
      {createRuche && 
          <EuiFormRow
            fullWidth
            label='Adresse Mac'
            isInvalid={Boolean(formik.touched.adresseMac && formik.errors.adresseMac)}
            error={formik.errors.adresseMac}
          >
            <EuiFieldText
              fullWidth
              placeholder='Adresse mac de la ruche'
              name='adresseMac'
              onChange={formik.handleChange}
              value={formik.values.adresseMac}
            />
          </EuiFormRow>
      }
      <EuiFormRow
        fullWidth
        label='Envoi des mails'
        isInvalid={Boolean(formik.touched.email && formik.errors.email)}
        error={formik.errors.email}
      >
        <EuiSelect
          fullWidth
          placeholder="Sélectionner l'envoi des mails"
          name='email'
          onChange={formik.handleChange}
          value={formik.values.email}
          options={roleOptions}
        />
      </EuiFormRow>
      <EuiSpacer />
      <EuiFlexGroup>
        <EuiButton type='submit'>
          {createRuche ? 'Créer' : 'Modifier'}
        </EuiButton>

        <EuiButton onClick={onCancel} color={'danger'}>
          Annuler
        </EuiButton>
      </EuiFlexGroup>
    </EuiForm>
  )
}

export default RucheForm
