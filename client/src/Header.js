import React from 'react'
import { Link, useNavigate } from 'react-router-dom';
import { useStateContext } from '../context';

function Header() {

    const { connect, address } = useStateContext();
    const navigate = useNavigate();

  return (

    <div>
        <div className="sm:flex hidden flex-row justify-end gap-4">
          
        <CustomButton 
          btnType="button"
          title={address ? 'Create a campaign' : 'Connect'}
          styles={address ? 'bg-[#ed7014]' : 'bg-[#fcae1e]'}
          handleClick={() => {
            if(address) navigate('create-campaign')
            else connect()
          }}
        />
        </div>
    </div>
  )
}

export default Header