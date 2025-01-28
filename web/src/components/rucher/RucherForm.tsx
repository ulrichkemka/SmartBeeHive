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
} from '@elastic/eui'
import { Rucher } from '../../types'
import { useNavigate, useParams } from 'react-router-dom'
import { useFormik } from 'formik'
import { AxiosError } from 'axios'
import { useToasts } from '../../contexts/toasts'

interface RucherFormProps {
  rucher: Rucher | null
  onCancel: () => void
  handleSubmit: (rucher: Rucher) => void
}

const RucherForm: FunctionComponent<RucherFormProps> = ({
  rucher,
  onCancel,
  handleSubmit,
}) => {

  const createRucher = !rucher

  const formik = useFormik({
    initialValues: {
      id: createRucher ? '' : rucher.id,
      nom: createRucher ? '' : rucher.nom,
      description: createRucher ? '' : rucher.description,
      adresse: createRucher ? '' : rucher.adresse,
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
      if (!values.adresse) {
        errors.adresse = 'Veuillez renseigner une adresse.'
      }
      return errors
    },
  })

  return (
    <EuiForm component='form' onSubmit={formik.handleSubmit} noValidate>
      <EuiTitle size='m'>
        {createRucher ? (
          <h1>Créer un rucher </h1>
        ) : (
          <h1>Modifier un rucher</h1>
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
          placeholder='Nom du rucher'
          name='nom'
          onChange={formik.handleChange}
          value={formik.values.nom}
        />
      </EuiFormRow>
      <EuiFormRow
        fullWidth
        label='Description'
        isInvalid={Boolean(
          formik.touched.description && formik.errors.description
        )}
        error={formik.errors.description}
      >
        <EuiFieldText
          fullWidth
          placeholder='Description du rucher'
          name='description'
          onChange={formik.handleChange}
          value={formik.values.description}
        />
      </EuiFormRow>

      <EuiFormRow
        fullWidth
        label='Adresse'
        isInvalid={Boolean(
          formik.touched.adresse && formik.errors.adresse
        )}
        error={formik.errors.adresse}
      >
        <EuiFieldText
          fullWidth
          placeholder='Adresse du rucher'
          name='adresse'
          onChange={formik.handleChange}
          value={formik.values.adresse}
        />
      </EuiFormRow>

      <EuiSpacer />
      <EuiFlexGroup>
        <EuiButton type='submit'>
          {createRucher ? 'Créer' : 'Modifier'}
        </EuiButton>

        <EuiButton onClick={onCancel} color={'danger'}>
          Annuler
        </EuiButton>
      </EuiFlexGroup>
    </EuiForm>
  )
}

export default RucherForm
