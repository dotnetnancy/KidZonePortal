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
    using System.Runtime.Serialization;
    

    public class Country : List<TestSprocGenerator.Data.SingleTable.Dto.Country>
    {
        
        public const string FILL_DB_SETTINGS_EXCEPTION = "Please Fill the DatabaseSmoObjectsAndSettings_Property with a filled DatabaseSmoO" +
            "bjectsAndSettings class and try again";
        
        public const string PRIMARY_KEY_NOT_FOUND_EXCEPTION_VAR_NAME = "PRIMARY_KEY_NOT_FOUND_EXCEPTION_VAR_NAME";
        
        private CommonLibrary.DatabaseSmoObjectsAndSettings _databaseSmoObjectsAndSettings;
        
        private CommonLibrary.Base.Business.BaseBusiness<TestSprocGenerator.Business.SingleTable.Bo.Country, TestSprocGenerator.Data.SingleTable.Dto.Country> _baseBusiness;
        
        private CommonLibrary.Base.Database.BaseDataAccess<TestSprocGenerator.Data.SingleTable.Dto.Country> _baseDataAccess;
        
        public Country()
        {
        }
        
        public Country(CommonLibrary.DatabaseSmoObjectsAndSettings databaseSmoObjectsAndSettings)
        {
            _databaseSmoObjectsAndSettings = databaseSmoObjectsAndSettings;
            _baseDataAccess = 
                new CommonLibrary.Base.Database.BaseDataAccess<TestSprocGenerator.Data.SingleTable.Dto.Country>(_databaseSmoObjectsAndSettings);
            _baseBusiness = 
                new CommonLibrary.Base.Business.BaseBusiness<TestSprocGenerator.Business.SingleTable.Bo.Country, TestSprocGenerator.Data.SingleTable.Dto.Country>(_databaseSmoObjectsAndSettings);
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
                new CommonLibrary.Base.Database.BaseDataAccess<TestSprocGenerator.Data.SingleTable.Dto.Country>(_databaseSmoObjectsAndSettings);
                }
                baseDataAccessAvailable = true;
            }
            else
            {
                baseDataAccessAvailable = true;
            }
            return baseDataAccessAvailable;
        }
        
        private void FillByGetPermutation(CommonLibrary.Enumerations.GetPermutations getPermutation, TestSprocGenerator.Business.SingleTable.Bo.Country filledBo)
        {
            if (this.BaseDataAccessAvailable())
            {
                this.Clear();
                TestSprocGenerator.Data.SingleTable.Dto.Country dto = ((TestSprocGenerator.Data.SingleTable.Dto.Country)(filledBo));
                List<TestSprocGenerator.Data.SingleTable.Dto.Country> returnDto = _baseDataAccess.Get(dto, getPermutation);
                int control = returnDto.Count;
                if ((control > 0))
                {
                    int counter;
                    for (counter = 0; (counter < control); counter = (counter + 1))
                    {
                        TestSprocGenerator.Business.SingleTable.Bo.Country boToFill = new TestSprocGenerator.Business.SingleTable.Bo.Country(_databaseSmoObjectsAndSettings);
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
        
        public virtual void FillByPrimaryKey(TestSprocGenerator.Business.SingleTable.Bo.Country filledBo)
        {
            CommonLibrary.Enumerations.GetPermutations getPermutation = CommonLibrary.Enumerations.GetPermutations.ByPrimaryKey;
            this.FillByGetPermutation(getPermutation, filledBo);
        }
        
        public virtual void FillByCriteriaFuzzy(TestSprocGenerator.Business.SingleTable.Bo.Country filledBo)
        {
            CommonLibrary.Enumerations.GetPermutations getPermutation = CommonLibrary.Enumerations.GetPermutations.ByFuzzyCriteria;
            this.FillByGetPermutation(getPermutation, filledBo);
        }
        
        public virtual void FillByCriteriaExact(TestSprocGenerator.Business.SingleTable.Bo.Country filledBo)
        {
            CommonLibrary.Enumerations.GetPermutations getPermutation = CommonLibrary.Enumerations.GetPermutations.ByExplicitCriteria;
            this.FillByGetPermutation(getPermutation, filledBo);
        }
        
        public virtual void FillByGetAll(TestSprocGenerator.Business.SingleTable.Bo.Country filledBo)
        {
            CommonLibrary.Enumerations.GetPermutations getPermutation = CommonLibrary.Enumerations.GetPermutations.AllByColumnMappings;
            this.FillByGetPermutation(getPermutation, filledBo);
        }
    }
}
