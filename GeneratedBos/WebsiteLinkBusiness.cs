//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:2.0.50727.3623
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TestSprocGenerator.Business.SingleTable.Bo
{
    using System;
    using System.Collections.Generic;
    using System.Text;
    using CommonLibrary;
    using System.Reflection;
    
    
    public class WebsiteLink : TestSprocGenerator.Data.SingleTable.Dto.WebsiteLink
    {
        
        public const string FILL_DB_SETTINGS_EXCEPTION = "Please Fill the DatabaseSmoObjectsAndSettings_Property with a filled DatabaseSmoO" +
            "bjectsAndSettings class and try again";
        
        public const string PRIMARY_KEY_NOT_FOUND_EXCEPTION_VAR_NAME = "PRIMARY_KEY_NOT_FOUND_EXCEPTION_VAR_NAME";
        
        private CommonLibrary.DatabaseSmoObjectsAndSettings _databaseSmoObjectsAndSettings;
        
        private CommonLibrary.Base.Business.BaseBusiness<TestSprocGenerator.Business.SingleTable.Bo.WebsiteLink, TestSprocGenerator.Data.SingleTable.Dto.WebsiteLink> _baseBusiness;
        
        private CommonLibrary.Base.Database.BaseDataAccess<TestSprocGenerator.Data.SingleTable.Dto.WebsiteLink> _baseDataAccess;
        
        public WebsiteLink()
        {
        }
        
        public WebsiteLink(CommonLibrary.DatabaseSmoObjectsAndSettings databaseSmoObjectsAndSettings)
        {
            _databaseSmoObjectsAndSettings = databaseSmoObjectsAndSettings;
            _baseDataAccess = 
                new CommonLibrary.Base.Database.BaseDataAccess<TestSprocGenerator.Data.SingleTable.Dto.WebsiteLink>(_databaseSmoObjectsAndSettings);
            _baseBusiness = 
                new CommonLibrary.Base.Business.BaseBusiness<TestSprocGenerator.Business.SingleTable.Bo.WebsiteLink, TestSprocGenerator.Data.SingleTable.Dto.WebsiteLink>(_databaseSmoObjectsAndSettings);
        }
        
        public WebsiteLink(CommonLibrary.DatabaseSmoObjectsAndSettings databaseSmoObjectsAndSettings, TestSprocGenerator.Business.SingleTable.Bo.WebsiteLink filledBo)
        {
            _databaseSmoObjectsAndSettings = databaseSmoObjectsAndSettings;
            _baseDataAccess = 
                new CommonLibrary.Base.Database.BaseDataAccess<TestSprocGenerator.Data.SingleTable.Dto.WebsiteLink>(_databaseSmoObjectsAndSettings);
            _baseBusiness = 
                new CommonLibrary.Base.Business.BaseBusiness<TestSprocGenerator.Business.SingleTable.Bo.WebsiteLink, TestSprocGenerator.Data.SingleTable.Dto.WebsiteLink>(_databaseSmoObjectsAndSettings);
            this.FillPropertiesFromBo(filledBo);
        }
        
        public virtual CommonLibrary.DatabaseSmoObjectsAndSettings DatabaseSmoObjectsAndSettings
        {
            get
            {
                return this._databaseSmoObjectsAndSettings;
            }
            set
            {
                this._databaseSmoObjectsAndSettings = value;
            }
        }
        
        private void FillPropertiesFromBo(TestSprocGenerator.Business.SingleTable.Bo.WebsiteLink filledBo)
        {
            _baseBusiness.FillPropertiesFromBo(filledBo, this);
        }
        
        private void FillThisWithDto(TestSprocGenerator.Data.SingleTable.Dto.WebsiteLink filledDto)
        {
            _baseBusiness.FillThisWithDto(filledDto, this);
        }
        
        private void FillDtoWithThis()
        {
            _baseBusiness.FillDtoWithThis(this);
        }
        
        private bool BaseDataAccessAvailable()
        {
            bool baseDataAccessAvailable = false;
            if ((_baseDataAccess == null))
            {
                if ((_databaseSmoObjectsAndSettings != null))
                {
                    _baseDataAccess = 
                new CommonLibrary.Base.Database.BaseDataAccess<TestSprocGenerator.Data.SingleTable.Dto.WebsiteLink>(_databaseSmoObjectsAndSettings);
                }
                baseDataAccessAvailable = true;
            }
            else
            {
                baseDataAccessAvailable = true;
            }
            return baseDataAccessAvailable;
        }
        
        public virtual void Insert()
        {
            if (this.BaseDataAccessAvailable())
            {
                TestSprocGenerator.Data.SingleTable.Dto.WebsiteLink dto = _baseBusiness.FillDtoWithThis(this);
                TestSprocGenerator.Data.SingleTable.Dto.WebsiteLink returnDto = _baseDataAccess.Insert(dto);
                this.FillThisWithDto(returnDto);
            }
            else
            {
                throw new System.ApplicationException(FILL_DB_SETTINGS_EXCEPTION);
            }
        }
        
        public virtual void Update()
        {
            if (this.BaseDataAccessAvailable())
            {
                TestSprocGenerator.Data.SingleTable.Dto.WebsiteLink dto = _baseBusiness.FillDtoWithThis(this);
                TestSprocGenerator.Data.SingleTable.Dto.WebsiteLink returnDto = _baseDataAccess.Update(dto);
                this.FillThisWithDto(returnDto);
            }
            else
            {
                throw new System.ApplicationException(FILL_DB_SETTINGS_EXCEPTION);
            }
        }
        
        public virtual void Delete()
        {
            if (this.BaseDataAccessAvailable())
            {
                TestSprocGenerator.Data.SingleTable.Dto.WebsiteLink dto = _baseBusiness.FillDtoWithThis(this);
                TestSprocGenerator.Data.SingleTable.Dto.WebsiteLink returnDto = _baseDataAccess.Delete(dto);
                this.FillThisWithDto(returnDto);
            }
            else
            {
                throw new System.ApplicationException(FILL_DB_SETTINGS_EXCEPTION);
            }
        }
        
        public virtual void GetByPrimaryKey()
        {
            if (this.BaseDataAccessAvailable())
            {
                TestSprocGenerator.Data.SingleTable.Dto.WebsiteLink dto = this;
                List<TestSprocGenerator.Data.SingleTable.Dto.WebsiteLink> returnDto = _baseDataAccess.Get(dto, CommonLibrary.Enumerations.GetPermutations.ByPrimaryKey);
                if ((returnDto.Count > 0))
                {
                    this.FillThisWithDto(returnDto[0]);
                }
                else
                {
                    throw new System.ApplicationException(PRIMARY_KEY_NOT_FOUND_EXCEPTION_VAR_NAME);
                }
            }
            else
            {
                throw new System.ApplicationException(FILL_DB_SETTINGS_EXCEPTION);
            }
        }
    }
}