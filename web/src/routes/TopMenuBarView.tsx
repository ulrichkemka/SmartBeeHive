import './TopMenuBarView.css'
import { Outlet, useLocation, redirect } from 'react-router-dom'
import { EuiPage, EuiPageBody, EuiPageSection, EuiSpacer } from '@elastic/eui'
import { useLoaderData } from 'react-router-dom'
import TopMenuBar from '../components/TopMenuBar'
import { ModalProvider } from '../contexts/modal'
import authService from '../services/auth.service'

export async function loader() {
  const user = await authService.getCurrentUser()
  return { user }
}

const TopMenuBarView = () => {
  const { user } = useLoaderData()

  const { pathname } = useLocation()
  const isExploitation = pathname.match(
    /account|\/users/
  )


  return (
    <ModalProvider>
      <EuiPage restrictWidth={!isExploitation} className='euiPage-transparent'>
        <TopMenuBar user={user}/>
        <EuiPageBody>
          <EuiSpacer size='xxl' />
          <EuiPageSection>
            <Outlet />
          </EuiPageSection>
        </EuiPageBody>
      </EuiPage>
    </ModalProvider>
  )
}
export default TopMenuBarView
