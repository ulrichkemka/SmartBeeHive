import { EuiPanel, EuiFlexGroup, EuiFlexItem } from '@elastic/eui'
import LoginForm from '../components/login/LoginForm'

export default function Login() {
  return (
    <EuiFlexGroup justifyContent='spaceAround' style={{ marginTop: '8em' }}>
      <EuiFlexItem grow={false}>
        <EuiPanel paddingSize='m'>
          <LoginForm />
        </EuiPanel>
      </EuiFlexItem>
    </EuiFlexGroup>
  )
}
