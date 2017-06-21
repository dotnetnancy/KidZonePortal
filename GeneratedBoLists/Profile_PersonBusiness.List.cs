//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:2.0.50727.3623
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TestSprocGenerator.Business.SingleTable.Bo.List
{
    using System;
    using System.Collections.Generic;
    using System.Text;
    using CommonLibrary;
    using System.Reflection;
    
    
    public class Profile_Person : List<TestSprocGenerator.Data.SingleTable.Dto.Profile_Person>
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
        
        private void FillByGetPermutation(CommonLibrary.Enumerations.GetPermutations getPermutation, TestSprocGenerator.Business.SingleTable.Bo.Profile_Person filledBo)
        {
            if (this.BaseDataAccessAvailable())
            {
                this.Clear();
                TestSprocGenerator.Data.SingleTable.Dto.Profile_Person dto = ((TestSprocGenerator.Data.SingleTable.Dto.Profile_Person)(filledBo));
                List<TestSprocGenerator.Data.SingleTable.Dto.Profile_Person> returnDto = _baseDataAccess.Get(dto, getPermutation);
                int control = returnDto.Count;
                if ((control > 0))
                {
                    int counter;
                    for (counter = 0; (counter < control); counter = (counter + 1))
                    {
                        TestSprocGenerator.Business.SingleTable.Bo.Profile_Person boToFill = new TestSprocGenerator.Business.SingleTable.Bo.Profile_Person(_databaseSmoObjectsAndSettings);
                        _baseBusiness.FillThisWithDto(returnDto[counter], boToFill);
                        this.Add(boToFill);
                    }
                }
            }
            else
            {
                throw new System.ApplicationException(FILL_DB_SETTINGS_EXCEPTION);
            }
        }
        
        public virtual void FillByPrimaryKey(TestSprocGenerator.Business.SingleTable.Bo.Profile_Person filledBo)
        {
            CommonLibrary.Enumerations.GetPermutations getPermutation = CommonLibrary.Enumerations.GetPermutations.ByPrimaryKey;
            this.FillByGetPermutation(getPermutation, filledBo);
        }
        
        public virtual void FillByCriteriaFuzzy(TestSprocGenerator.Business.SingleTable.Bo.Profile_Person filledBo)
        {
            CommonLibrary.Enumerations.GetPermutations getPermutation = CommonLibrary.Enumerations.GetPermutations.ByFuzzyCriteria;
            this.FillByGetPermutation(getPermutation, filledBo);
        }
        
        public virtual void FillByCriteriaExact(TestSprocGenerator.Business.SingleTable.Bo.Profile_Person filledBo)
        {
            CommonLibrary.Enumerations.GetPermutations getPermutation = CommonLibrary.Enumerations.GetPermutations.ByExplicitCriteria;
            this.FillByGetPermutation(getPermutation, filledBo);
        }
        
        public virtual void FillByGetAll(TestSprocGenerator.Business.SingleTable.Bo.Profile_Person filledBo)
        {
            CommonLibrary.Enumerations.GetPermutations getPermutation = CommonLibrary.Enumerations.GetPermutations.AllByColumnMappings;
            this.FillByGetPermutation(getPermutation, filledBo);
        }
    }
}
