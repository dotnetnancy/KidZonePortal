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
    
    
    public class Profile_Person : TestSprocGenerator.Data.SingleTable.Dto.Profile_Person
    {
        
        public const string FILL_DB_SETTINGS_EXCEPTION = "Please Fill the DatabaseSmoObjectsAndSettings_Property with a filled DatabaseSmoO" +
            "bjectsAndSettings class and try again";
        
        public const string PRIMARY_KEY_NOT_FOUND_EXCEPTION_VAR_NAME = "PRIMARY_KEY_NOT_FOUND_EXCEPTION_VAR_NAME";
        
        private CommonLibrary.DatabaseSmoObjectsAndSettings _databaseSmoObjectsAndSettings;
        
        private CommonLibrary.Base.Business.BaseBusiness<TestSprocGenerator.Business.SingleTable.Bo.Profile_Person, TestSprocGenerator.Data.SingleTable.Dto.Profile_Person> _baseBusiness;
        
        private CommonLibrary.Base.Database.BaseDataAccess<TestSprocGenerator.Data.SingleTable.Dto.Profile_Person> _baseDataAccess;
        
        public Profile_Person()
        {
        }
        
        public Profile_Person(CommonLibrary.DatabaseSmoObjectsAndSettings databaseSmoObjectsAndSettings)
        {
            _databaseSmoObjectsAndSettings = databaseSmoObjectsAndSettings;
            _baseDataAccess = 
                new CommonLibrary.Base.Database.BaseDataAccess<TestSprocGenerator.Data.SingleTable.Dto.Profile_Person>(_databaseSmoObjectsAndSettings);
            _baseBusiness = 
                new CommonLibrary.Base.Business.BaseBusiness<TestSprocGenerator.Business.SingleTable.Bo.Profile_Person, TestSprocGenerator.Data.SingleTable.Dto.Profile_Person>(_databaseSmoObjectsAndSettings);
        }
        
        public Profile_Person(CommonLibrary.DatabaseSmoObjectsAndSettings databaseSmoObjectsAndSettings, TestSprocGenerator.Business.SingleTable.Bo.Profile_Person filledBo)
        {
            _databaseSmoObjectsAndSettings = databaseSmoObjectsAndSettings;
            _baseDataAccess = 
                new CommonLibrary.Base.Database.BaseDataAccess<TestSprocGenerator.Data.SingleTable.Dto.Profile_Person>(_databaseSmoObjectsAndSettings);
            _baseBusiness = 
                new CommonLibrary.Base.Business.BaseBusiness<TestSprocGenerator.Business.SingleTable.Bo.Profile_Person, TestSprocGenerator.Data.SingleTable.Dto.Profile_Person>(_databaseSmoObjectsAndSettings);
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
        
        private void FillPropertiesFromBo(TestSprocGenerator.Business.SingleTable.Bo.Profile_Person filledBo)
        {
            _baseBusiness.FillPropertiesFromBo(filledBo, this);
        }
        
        private void FillThisWithDto(TestSprocGenerator.Data.SingleTable.Dto.Profile_Person filledDto)
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
                new CommonLibrary.Base.Database.BaseDataAccess<TestSprocGenerator.Data.SingleTable.Dto.Profile_Person>(_databaseSmoObjectsAndSettings);
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
                TestSprocGenerator.Data.SingleTable.Dto.Profile_Person dto = _baseBusiness.FillDtoWithThis(this);
                TestSprocGenerator.Data.SingleTable.Dto.Profile_Person returnDto = _baseDataAccess.Insert(dto);
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
                TestSprocGenerator.Data.SingleTable.Dto.Profile_Person dto = _baseBusiness.FillDtoWithThis(this);
                TestSprocGenerator.Data.SingleTable.Dto.Profile_Person returnDto = _baseDataAccess.Update(dto);
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
                TestSprocGenerator.Data.SingleTable.Dto.Profile_Person dto = _baseBusiness.FillDtoWithThis(this);
                TestSprocGenerator.Data.SingleTable.Dto.Profile_Person returnDto = _baseDataAccess.Delete(dto);
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
                TestSprocGenerator.Data.SingleTable.Dto.Profile_Person dto = this;
                List<TestSprocGenerator.Data.SingleTable.Dto.Profile_Person> returnDto = _baseDataAccess.Get(dto, CommonLibrary.Enumerations.GetPermutations.ByPrimaryKey);
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
