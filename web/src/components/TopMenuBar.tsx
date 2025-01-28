import {
  EuiContextMenu,
  EuiHeader,
  EuiHeaderBreadcrumbs,
  EuiHeaderLogo,
  EuiHeaderSection,
  EuiHeaderSectionItem,
  EuiHeaderSectionItemButton,
  EuiPopover,
} from '@elastic/eui'
import { useState, useEffect } from 'react'
import { useNavigate, useParams, useRouteLoaderData, useLocation  } from 'react-router-dom'
import './TopMenuBar.css'
import logo from '../logo.jpg'
import { useAuth } from '../contexts/auth'
import { User } from '../types'

type TopMenuBarProps = {
  user: User
}

const TopMenuBar: FunctionComponent<TopMenuBarProps> = ({ user }) => {
  const navigate = useNavigate()
  const admin = user?.role === 'administrateur'
  const currentUser = user 

  const location = useLocation();

  const isLoginPage = location.pathname === '/login';
  if (isLoginPage) {
    return null; // Ne rien afficher sur la page de connexion
  }

  return (
    <EuiHeader position='fixed' className='il-top-menu-bar'>
      <EuiHeaderSection>
          <EuiHeaderSectionItem style = {{cursor: "pointer"}} onClick={() => navigate('/home')}>
            {/* <EuiHeaderLogo> */}
              <div className="logo-container">
                <img src={logo} alt="SmartBeeHive" />
                <span className="logo-text">Smart BeeHive</span>
              </div>
            {/* </EuiHeaderLogo> */}
          </EuiHeaderSectionItem>
          <EuiHeaderSectionItem border='right'>
             <ProfileMenu user={user}/>
          </EuiHeaderSectionItem>
      </EuiHeaderSection>
      <EuiHeaderSection side='left' style={{ marginRight: '3em' }}>
          <EuiHeaderSectionItem border='right'>
            {admin && <AdminMenu />}
          </EuiHeaderSectionItem>
      </EuiHeaderSection>

    </EuiHeader>
  )
}

const AdminMenu = () => {
  const [isMenuOpen, setIsMenuOpen] = useState(false)
  const onButtonClick = () => setIsMenuOpen(!isMenuOpen)
  const closeMenu = () => {
    setIsMenuOpen(false)
  }
  const navigate = useNavigate()

  const adminMenuItems = [
    {
      id: 0,
      title: 'Administration',
      items: [
        {
          name: 'Gestion des utilisateurs',
          icon: 'users',
          onClick: () => {
            navigate('users')
            setIsMenuOpen(false)
          },
        },
        {
          name: 'Gestion des ruchers',
          icon: 'pencil',
          onClick: () => {
            navigate('users')
            setIsMenuOpen(false)
          },
        },
      ],
    },
  ]

  const adminMenuBtn = (
    <EuiHeaderSectionItemButton
      iconType='arrowDown'
      iconSide='right'
      onClick={onButtonClick}
    >
      Admin
    </EuiHeaderSectionItemButton>
  )

  return (
    <EuiPopover
      button={adminMenuBtn}
      isOpen={isMenuOpen}
      closePopover={closeMenu}
      panelPaddingSize='none'
      anchorPosition='downLeft'
    >
      <EuiContextMenu initialPanelId={0} panels={adminMenuItems} />
    </EuiPopover>
  )
}

type ProfileMenuProps = {
  user: User
}

const ProfileMenu: FunctionComponent<ProfileMenuProps> = ({ user }) => {
  const [isMenuOpen, setIsMenuOpen] = useState(false)
  const onButtonClick = () => setIsMenuOpen(!isMenuOpen)
  const closeMenu = () => {
    setIsMenuOpen(false)
  }
  const navigate = useNavigate()
  const { logout } = useAuth()

  useEffect(() => {
    closeMenu()
  }, [navigate])

  const menuItems = [
    {
      id: 0,
      title: 'Profil',
      items: [
        {
          isSeparator: true,
          key: 'profile-sep-1',
        },
        {
          name: 'Modifier mon profil',
          icon: 'user',
          onClick: () => {
            navigate('/account')
            setIsMenuOpen(false)
          },
        },
        {
          name: 'Déconnexion',
          icon: 'exit',
          onClick: () => {
            logout()
            navigate('/login')
            setIsMenuOpen(false)
          },
        },
      ],
    },
  ]

  const menuBtn = (
    <EuiHeaderSectionItemButton
      iconType='user'
      iconSide='left'
      onClick={onButtonClick}
    >
      {user?.prenom + ' ' + user?.nom}

    </EuiHeaderSectionItemButton>
  )

  return (
    <EuiPopover
      button={menuBtn}
      isOpen={isMenuOpen}
      closePopover={closeMenu}
      panelPaddingSize='none'
      anchorPosition='downLeft'
    >
      <EuiContextMenu initialPanelId={0} panels={menuItems} />
    </EuiPopover>
  )
}

export default TopMenuBar
