﻿using Entity.Concrete;
using SS.BusinessLogicLayer.BBL;
using SS.BusinessLogicLayer.Commen;

namespace SS.WinForm.UI.Commen
{
    public static class Connection
    {
        private static IBBL<Users> _UserBBL;

        public static IBBL<Users> UserBBL
        {
            get
            {
                if (_UserBBL == null)
                {
                    _UserBBL = new UsersBBL();
                }
                
                return _UserBBL;
            }
        }
    }
}
