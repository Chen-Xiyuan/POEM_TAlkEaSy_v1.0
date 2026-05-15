# =============================================================================
# Parameters_TAlkEaSy.jl
# =============================================================================

module Parameters

export Pars, default_parameters, default_initial_state

Base.@kwdef struct Pars

    ####---------------------------------####
    ####  ocean 1 box physical features  ####
    ####---------------------------------####
    area_1box::Float64
    z_1box::Float64
    vol_1box::Float64
    rho_sw::Float64

    ####-------------------------------------####
    ####  Present-day reservoir sizes (mol)  ####
    ####-------------------------------------####
    P0::Float64
    AO20::Float64
    OO20::Float64
    CO20::Float64
    DIC0::Float64
    ORG0::Float64
    CARB0::Float64
    S0::Float64
    PYR0::Float64
    GYP0::Float64
    N0::Float64
    Mg0::Float64
    Ca0::Float64
    Na0::Float64
    K0::Float64
    Cl0::Float64
    NaCl0::Float64
    KCl0::Float64
    OSr0::Float64
    SSr0::Float64
    U0::Float64


    # atmospheric moles corresponding to 1 atm (used to convert mol -> atm)
    moles1atm::Float64

    ####------------------------------####
    ####  air-sea exchange (CO2, O2)  ####
    ####------------------------------####
    vpiston::Float64
    K_0_CO2::Float64
    K_0_O2::Float64

    ####-----------------------------####
    ####  ocean carbonate chemistry  ####
    ####-----------------------------####
    K_1::Float64
    K_2::Float64
    K_B::Float64
    K_sp::Float64
    Omega0::Float64
    Eta_carb::Float64
    K_W::Float64

    ####---------------####
    ####  climate      ####
    ####---------------####
    k_c::Float64
    k_l::Float64

    ####------------------------------------------------####
    ####  Present-day inorganic carbon fluxes (mol/yr)  ####
    ####------------------------------------------------####
    k_granw_CO2::Float64
    k_basw_CO2::Float64
    k_carbw_CO2::Float64

    k_ccdeg::Float64

    k_mcb_total::Float64
    mcb_total0::Float64

    k_sfwSimple::Float64
    k_sfwMg::Float64

    ####----------------------------------------------####
    ####  Present-day organic carbon fluxes (mol/yr)  ####
    ####----------------------------------------------####
    k_oxidw::Float64
    k_lob_C::Float64
    k_mob_C::Float64
    k_ocdeg::Float64

    ####-----------------------------------------------------####
    ####  Present-day sulfate-pyrite-gypsum fluxes (mol/yr)  ####
    ####-----------------------------------------------------####
    k_pyrw::Float64
    k_pyrdeg::Float64
    k_mpb_S::Float64

    k_gypw::Float64
    k_gypdeg::Float64
    k_mgb::Float64

    ####------------------------------------------####
    ####  Present-day phosphorus fluxes (mol/yr)  ####
    ####------------------------------------------####

    pfrac_silw::Float64
    pfrac_carbw::Float64
    pfrac_oxidw::Float64

    k_capb::Float64
    k_fepb::Float64
    k_phosw::Float64

    k_landfrac::Float64
    k_aq::Float64

    k_hyd_highT_P::Float64
    k_hyd_lowT_P::Float64

    ####  Marine organic matter C:P ratio (oxic endmember)  ####
    CPsea0::Float64

    ####----------------------------------------####
    ####  Present-day nitrogen fluxes (mol/yr)  ####
    ####----------------------------------------####
    k_nfix::Float64
    k_denit::Float64

    ####-----------------------------------------####
    ####  Present-day magnesium fluxes (mol/yr)  ####
    ####-----------------------------------------####
    molf_Mg_GRAN::Float64
    molf_Mg_BAS::Float64

    k_hyd_highT_Mg::Float64
    k_hyd_lowT_Mg::Float64

    molf_Mg_CARB::Float64
    k_dolo_sec::Float64


    ####-----------------------------------------####
    ####  Present-day calcium fluxes (mol/yr)  ####
    ####-----------------------------------------####
    molf_Ca_GRAN::Float64
    molf_Ca_BAS::Float64

    molf_Ca_CARB::Float64

    ####--------------------------------------####
    ####  Present-day sodium fluxes (mol/yr)  ####
    ####--------------------------------------####
    molf_Na_GRAN::Float64
    molf_Na_BAS::Float64

    k_hyd_highT_Na::Float64
    k_rw_Na::Float64

    k_NaClw::Float64
    k_NaClb::Float64

    k_Exb_Na::Float64
    k_Exr_Na::Float64
    k_Exd_Na::Float64

    ####-----------------------------------------####
    ####  Present-day potassium fluxes (mol/yr)  ####
    ####-----------------------------------------####
    molf_K_GRAN::Float64
    molf_K_BAS::Float64

    k_rw_K::Float64
    k_hyd_highT_K::Float64

    k_KClw::Float64
    k_KClb::Float64

    ####------------------------------------------####
    ####  Present-day strontiumr fluxes (mol/yr)  ####
    ####------------------------------------------####
    k_Sr_granw_CO2::Float64
    k_Sr_basw_CO2::Float64
    k_Sr_carbw_CO2::Float64
    k_Sr_hyd_highT::Float64
    k_Sr_hyd_lowT::Float64
    k_Sr_metam::Float64
    mcb_Sr::Float64
    k_sfwSimple_Sr::Float64
    k_sfwMg_Sr::Float64

    ####---------------------------------------####
    ####  Present-day uranium fluxes (mol/yr)  ####
    ####---------------------------------------####
    k_U_granw_CO2::Float64
    k_U_basw_CO2::Float64
    k_U_carbw_CO2::Float64
    k_anoxic_U::Float64
    k_other_U::Float64
    k_U_hyd_highT::Float64
    k_U_hyd_lowT::Float64

    ####---------------------------####
    ####  productivity parameters  ####
    ####---------------------------####
    k_oxfrac::Float64
    newp0::Float64
    copsek16::Float64
    plantenhance::Float64
    a::Float64  
    kfire::Float64
    b::Float64  
    k_ANOX0::Float64

    ####----------####
    ####  others  ####
    ####----------####
    alpha_arag::Float64

    ####-------------------------------------------------------------####
    ####  magnesium isotope dynamic fractionation (δ26/24Mg, DSM-3)  ####
    ####-------------------------------------------------------------####
    delta_26_granw_initial::Float64
    delta_26_basw_initial::Float64
    delta_26_carbw_initial::Float64
    delta_26_sfw_initial::Float64

    ####-------------------------------------------------------------------####
    ####  calcium isotope dynamic fractionation (δ44/40Ca, NIST SRM-915a)  ####
    ####-------------------------------------------------------------------####
    delta_44_granw_initial::Float64
    delta_44_basw_initial::Float64
    delta_44_carbw_initial::Float64
    delta_44_gypw_initial::Float64
    D_44_mgb_initial::Float64
    D_44_dolo_sec_initial::Float64
    D_44_sfw_initial::Float64
    delta_44_hyd_highT_initial::Float64
    delta_44_hyd_lowT_initial::Float64
    D_44_pelagic_mcb_initial::Float64
    D_44_shelf_mcb_arag_initial::Float64
    D_44_shelf_mcb_calc_initial::Float64

    ####-----------------------------------------------####
    ####  strontium isotope fractionation (87Sr/86Sr)  ####
    ####-----------------------------------------------####
    delta_87_granw_initial::Float64
    delta_87_basw_initial::Float64
    delta_87_mantle_initial::Float64
    delta_87_Sr_0::Float64
    lambda::Float64
    RbSr_carbonate::Float64

    ####-------------------------------------------------------####
    ####  uranium isotope dynamic fractionation (δ238/235U, )  ####
    ####-------------------------------------------------------####
    delta_238_granw_initial::Float64
    delta_238_basw_initial::Float64
    D_238_anoxic_initial::Float64
    D_238_other_initial::Float64
    D_238_hyd_highT_initial::Float64
    D_238_hyd_lowT_initial::Float64

    ####---------------------------------####
    ####  Initial values of reservoirs   ####
    ####---------------------------------####
    P_initial::Float64
    AO2_initial::Float64
    OO2_initial::Float64
    CO2_initial::Float64
    DIC_initial::Float64
    ORG_initial::Float64
    CARB_initial::Float64
    S_initial::Float64
    PYR_initial::Float64
    GYP_initial::Float64
    N_initial::Float64
    Mg_initial::Float64
    Ca_initial::Float64
    Na_initial::Float64
    K_initial::Float64
    Cl_initial::Float64
    NaCl_initial::Float64
    KCl_initial::Float64
    OSr_initial::Float64
    SSr_initial::Float64
    U_initial::Float64
    pH_initial::Float64

    ####-----------------------------------------####
    ####  Initial values of reservoir isotopes   ####
    ####-----------------------------------------####
    delta_13_CO2_initial::Float64
    delta_13_DIC_initial::Float64
    delta_13_ORG_initial::Float64
    delta_13_CARB_initial::Float64
    delta_34_S_initial::Float64
    delta_34_PYR_initial::Float64
    delta_34_GYP_initial::Float64
    delta_26_Mg_initial::Float64
    delta_44_Ca_initial::Float64
    delta_87_OSr_initial::Float64
    delta_87_SSr_initial::Float64
    delta_238_U_initial::Float64

end


function default_parameters()

    ####---------------------------------####
    ####  ocean 1 box physical features  ####
    ####---------------------------------####

    area_1box    =  3.6e14               ####----  (m^2)
    z_1box       =  3688.0               ####----  (m)
    vol_1box     =  area_1box * z_1box   ####----  (m^3)
    rho_sw       =  1027.0               ####----  (kg * m^3)

    ####-------------------####
    ####  reservoir sizes  ####
    ####-------------------####
    P0     =  3.100e15                 
    AO20   =  3.665e19                 
    OO20   =  3.340e17                 
    CO20   =  4.956e16                 
    DIC0   =  2.600e18                 
    ORG0   =  12.500e20                
    CARB0  =  50.000e20                
    S0     =  3.920e19                 
    PYR0   =  1.800e20                 
    GYP0   =  2.000e20                 
    N0     =  4.350e16                 
    Mg0    =  7.196e19                 
    Ca0    =  1.433e19                 
    Na0    =  66.020e19                
    K0     =  1.488e19                 
    Cl0    =  76.984e19                
    NaCl0  =  18.300e19                
    KCl0   =  2.000e18                 
    OSr0   =  1.200e17                 
    SSr0   =  5.000e18                 
    U0     =  1.900e13                 

    moles1atm = 1.77e20                

    ####----------------------####
    ####  reservoir isotopes  ####
    ####----------------------####
    delta_13_CO2_initial  =    -8.5       
    delta_13_DIC_initial  =     0.0       ####----  (‰, δ13/12C, V-CDB)
    delta_13_ORG_initial  =   -27.0       ####----  (‰, δ13/12C, V-CDB)
    delta_13_CARB_initial =     1.0       ####----  (‰, δ13/12C, V-CDB)
    delta_34_S_initial    =    20.0       ####----  (‰, δ34/32S, V-CDT)
    delta_34_PYR_initial  =   -15.0       ####----  (‰, δ34/32S, V-CDT)
    delta_34_GYP_initial  =    20.0       ####----  (‰, δ34/32S, V-CDT)
    delta_26_Mg_initial   =   -0.82       ####----  (‰, δ26/24Mg, DSM-3)
    delta_44_Ca_initial   =    1.89       ####----  (‰, δ44/40Ca, NIST SRM915-a)
    delta_87_OSr_initial  =   0.709       ####----  (/, 87Sr/86Sr, )
    delta_87_SSr_initial  =   0.708       ####----  (/, 87Sr/86Sr, )
    delta_238_U_initial   =   -0.39       ####----  (‰, δ238/235U, )

    ####------------------------------####
    ####  air-sea exchange (CO2, O2)  ####
    ####------------------------------####
    vpiston  =  1138.8                  
    K_0_CO2  =  38.50                 
    K_0_O2   =  1.37                   

    ####-----------------------------####
    ####  ocean carbonate chemistry  ####
    ####-----------------------------####
    K_1 = 1.1500e-6                   
    K_2 = 0.9000e-9                  
    K_W = 2.500e-14                  
    K_B = 1.921e-9                  

    K_sp = 0.800e-6                  
    Omega0 = 3.0                     
    Eta_carb = 1.7                   

    ####--------------####
    ####  climate     ####      
    ####--------------####
    k_c = 4.328
    k_l = 0.0                        

    ####------------------------------------------------####
    ####  Present-day inorganic carbon fluxes (mol/yr)  ####
    ####------------------------------------------------####
    k_granw_CO2 = 10.0e12                               
    k_basw_CO2 = 2.5e12                                 
    k_carbw_CO2 = 8.0e12                                

    k_ccdeg = 14.400e12                                                                  
    k_mcb_total = 18.46e12                                                                  
    mcb_total0 = 18.46e12                                                                   

    k_sfwSimple = 2.00e12                               
    k_sfwMg = 1.00e12                                                                      

    ####----------------------------------------------####
    ####  Present-day organic carbon fluxes (mol/yr)  ####
    ####----------------------------------------------####
    k_oxidw = 3.75e12                                 
    k_lob_C = 2.5e12                                  
    k_mob_C = 2.5e12                                  
    k_ocdeg = 1.25e12                                 

    ####-----------------------------------------------------####
    ####  Present-day sulfate-pyrite-gypsum fluxes (mol/yr)  ####
    ####-----------------------------------------------------####
    k_pyrw = 0.45e12                                         
    k_pyrdeg = 0.25e12                                       
    k_mpb_S = 0.70e12                                        

    k_gypw = 2.0e12                                          
    k_gypdeg = 0.5e12                                        
    k_mgb = 2.5e12                                           

    ####------------------------------------------####
    ####  Present-day phosphorus fluxes (mol/yr)  ####
    ####------------------------------------------####

    pfrac_silw = 0.88                             
    pfrac_carbw = 0.06                            
    pfrac_oxidw = 0.06                            

    k_capb = 10.0e9                               
    k_fepb = 10.0e9                               
    k_phosw = 4.25e10                             
    k_landfrac = 0.0588                           
    k_aq = 0.85                                   
    CPsea0 = 250.0                                

    k_hyd_highT_P = 4.0e9                         
    k_hyd_lowT_P  = 6.0e9                         

    ####----------------------------------------####
    ####  Present-day nitrogen fluxes (mol/yr)  ####
    ####----------------------------------------####
    k_nfix = 8.67e12                            
    k_denit = 4.3e12                            

    ####-----------------------------------------####                                                                                                           
    ####  Present-day magnesium fluxes (mol/yr)  ####
    ####-----------------------------------------####
    molf_Mg_GRAN = 0.250                            
    molf_Mg_BAS = 0.350                          

    k_hyd_highT_Mg = 1.425e12                    
    k_hyd_lowT_Mg = 2.950e12                     

    molf_Mg_CARB = 0.400                         
    k_dolo_sec = 3.200e12                        

    ####-----------------------------------------####
    ####  Present-day calcium fluxes (mol/yr)    ####
    ####-----------------------------------------####
    molf_Ca_GRAN = 0.601                                                                                                
    molf_Ca_BAS = 0.630                          
    molf_Ca_CARB = 0.600                             

    ####--------------------------------------####
    ####  Present-day sodium fluxes (mol/yr)  ####
    ####--------------------------------------####
    molf_Na_GRAN = 0.100                      
    molf_Na_BAS = 0.016                       
    k_hyd_highT_Na = 0.98e12                  
    k_rw_Na = 2.10e12                         
    k_NaClw = 1.00e12                         
    k_NaClb = 1.00e12                         
    k_Exb_Na = 5.00e12                        
    k_Exr_Na = 1.00e12                        
    k_Exd_Na = 3.00e12                        

    ####-----------------------------------------####
    ####  Present-day potassium fluxes (mol/yr)  ####
    ####-----------------------------------------####
    molf_K_GRAN = 0.0490                         
    molf_K_BAS = 0.0040                          
    k_rw_K = 0.6e12                                                                         
    k_hyd_highT_K = 0.4e12                                                           
    k_KClw = 0.05e12                                                                   
    k_KClb = 0.05e12                                                                 
    
    ####------------------------------------------####
    ####  Present-day strontiumr fluxes (mol/yr)  ####
    ####------------------------------------------####
    k_Sr_granw_CO2    =  14.50e9                  
    k_Sr_basw_CO2     =  4.00e9                   
    k_Sr_carbw_CO2    =  16.00e9                  
    k_Sr_hyd_highT    =  1.00e9                   
    k_Sr_hyd_lowT     =  5.00e9                   
    mcb_Sr            =  36.00e9                  
    k_sfwSimple_Sr    =  3.00e9                   
    k_sfwMg_Sr        =  1.50e9                   
    k_Sr_metam        =  20.00e9                  

    ####---------------------------------------####
    ####  Present-day uranium fluxes (mol/yr)  ####
    ####---------------------------------------####
    k_U_granw_CO2    =     40.0e6              
    k_U_basw_CO2     =     10.0e6               
    k_U_carbw_CO2    =     0.0e6               
    k_anoxic_U       =     6.0e6               
    k_other_U        =     34.0e6              
    k_U_hyd_highT    =     3.0e6               
    k_U_hyd_lowT     =     7.0e6               

    ####---------------------------####
    ####  productivity parameters  ####
    ####---------------------------####
    k_ANOX0      =      0.0025                 
    k_oxfrac     =      0.9975                                  
    newp0        =      225.95625                               
    copsek16     =      3.762
    plantenhance =      0.15                                
    a            =      0.5                                            
    kfire        =      3.0
    b            =      2.0                                       

    ####----------####
    ####  others  ####
    ####----------####
    alpha_arag = 1.50                                                      

    ####-------------------------------------------------------------####
    ####  magnesium isotope dynamic fractionation (δ26/24Mg, DSM-3)  ####
    ####-------------------------------------------------------------####
    delta_26_granw_initial = -0.25
    delta_26_basw_initial  = -0.25
    delta_26_carbw_initial = -2.00
    delta_26_sfw_initial   = -1.10                                   

    ####-------------------------------------------------------------------####
    ####  calcium isotope dynamic fractionation (δ44/40Ca, NIST SRM-915a)  ####
    ####-------------------------------------------------------------------####
    delta_44_granw_initial = 0.625
    delta_44_basw_initial  = 1.125
    delta_44_carbw_initial = 0.65
    delta_44_gypw_initial = 1.75
    D_44_mgb_initial = -0.50
    D_44_dolo_sec_initial = -1.80
    D_44_sfw_initial = 0.00
    delta_44_hyd_highT_initial = 0.85
    delta_44_hyd_lowT_initial = 0.85
    D_44_pelagic_mcb_initial = -1.10
    D_44_shelf_mcb_arag_initial = -1.70
    D_44_shelf_mcb_calc_initial = -0.80

    ####-----------------------------------------------####
    ####  strontium isotope fractionation (87Sr/86Sr)  ####
    ####-----------------------------------------------####
    delta_87_granw_initial    =  0.714            
    delta_87_basw_initial     =  0.705            
    delta_87_mantle_initial   =  0.702            
    delta_87_Sr_0             =  0.69898          
    lambda                    =  1.4e-11          
    RbSr_carbonate            =  0.05      

    ####-------------------------------------------------------####
    ####  uranium isotope dynamic fractionation (δ238/235U, )  ####
    ####-------------------------------------------------------####
    delta_238_granw_initial    = -0.26                         ####----  (‰, δ238/235U, )
    delta_238_basw_initial     = -0.26                         ####----  (‰, δ238/235U, )
    D_238_anoxic_initial       = 0.80                          ####----  (‰, δ238/235U, )
    D_238_other_initial        = 0.005                         ####----  (‰, δ238/235U, )
    D_238_hyd_highT_initial    = 0.00                          ####----  (‰, δ238/235U, )
    D_238_hyd_lowT_initial     = 0.30                          ####----  (‰, δ238/235U, )

    ####--------------------------------####
    ####  Initial values of reservoirs  ####
    ####--------------------------------####
    P_initial = P0
    AO2_initial = AO20
    OO2_initial = OO20
    CO2_initial = CO20
    DIC_initial = DIC0
    ORG_initial = ORG0
    CARB_initial = CARB0
    S_initial = S0
    PYR_initial = PYR0
    GYP_initial = GYP0
    N_initial = N0
    Mg_initial = Mg0
    Ca_initial = Ca0
    Na_initial = Na0
    K_initial = K0
    Cl_initial = Cl0
    NaCl_initial = NaCl0
    KCl_initial = KCl0
    OSr_initial = OSr0
    SSr_initial = SSr0
    U_initial = U0
    pH_initial = 8.05


    return Pars(

        ####---------------------------------####
        ####  ocean 1 box physical features  ####
        ####---------------------------------####
        area_1box = area_1box,
        z_1box = z_1box,
        vol_1box = vol_1box,
        rho_sw = rho_sw,

        ####-------------------------------####
        ####  Present-day reservoir sizes  ####
        ####-------------------------------####
        P0 = P0,
        AO20 = AO20,
        OO20 = OO20,
        CO20 = CO20,
        DIC0 = DIC0,
        ORG0 = ORG0,
        CARB0 = CARB0,
        S0 = S0,
        PYR0 = PYR0,
        GYP0 = GYP0,
        N0 = N0,
        Mg0 = Mg0,
        Ca0 = Ca0,
        Na0 = Na0,
        K0 = K0,
        Cl0 = Cl0,
        NaCl0 = NaCl0,
        KCl0 = KCl0,
        OSr0 = OSr0,
        SSr0 = SSr0,
        U0 = U0,


        moles1atm = moles1atm,

        ####----------------------------------####
        ####  Present-day reservoir isotopes  ####
        ####----------------------------------####
        delta_13_CO2_initial = delta_13_CO2_initial,
        delta_13_DIC_initial = delta_13_DIC_initial,
        delta_13_ORG_initial = delta_13_ORG_initial,
        delta_13_CARB_initial = delta_13_CARB_initial,
        delta_34_S_initial = delta_34_S_initial,
        delta_34_PYR_initial = delta_34_PYR_initial,
        delta_34_GYP_initial = delta_34_GYP_initial,
        delta_26_Mg_initial = delta_26_Mg_initial,
        delta_44_Ca_initial = delta_44_Ca_initial,
        delta_87_OSr_initial = delta_87_OSr_initial,
        delta_87_SSr_initial = delta_87_SSr_initial,
        delta_238_U_initial = delta_238_U_initial,

        ####------------------------------####
        ####  air-sea exchange (CO2, O2)  ####
        ####------------------------------####
        vpiston = vpiston,
        K_0_CO2 = K_0_CO2,
        K_0_O2 = K_0_O2,

        ####-----------------------------####
        ####  ocean carbonate chemistry  ####
        ####-----------------------------####
        K_1 = K_1,       
        K_2 = K_2,      
        K_W = K_W,     
        K_B = K_B,    

        K_sp = K_sp,
        Omega0 = Omega0,
        Eta_carb = Eta_carb,

        ####-----------------------------####
        ####  climate (Berner GMST)     ####
        ####-----------------------------####
        k_c = k_c,
        k_l = k_l,

        ####------------------------------------------------####
        ####  Present-day inorganic carbon fluxes (mol/yr)  ####
        ####------------------------------------------------####
        k_granw_CO2 = k_granw_CO2,
        k_basw_CO2 = k_basw_CO2,
        k_carbw_CO2 = k_carbw_CO2,

        k_ccdeg = k_ccdeg,

        k_mcb_total = k_mcb_total,
        mcb_total0 = mcb_total0,

        k_sfwSimple = k_sfwSimple,
        k_sfwMg = k_sfwMg,

        ####----------------------------------------------####
        ####  Present-day organic carbon fluxes (mol/yr)  ####
        ####----------------------------------------------####
        k_oxidw = k_oxidw,
        k_lob_C = k_lob_C,
        k_mob_C = k_mob_C,
        k_ocdeg = k_ocdeg,

        ####-----------------------------------------------------####
        ####  Present-day sulfate-pyrite-gypsum fluxes (mol/yr)  ####
        ####-----------------------------------------------------####
        k_pyrw = k_pyrw,
        k_pyrdeg = k_pyrdeg,
        k_mpb_S = k_mpb_S,

        k_gypw = k_gypw,
        k_gypdeg = k_gypdeg,
        k_mgb = k_mgb,

        ####------------------------------------------####
        ####  Present-day phosphorus fluxes (mol/yr)  ####
        ####------------------------------------------####
        pfrac_silw = pfrac_silw,
        pfrac_carbw = pfrac_carbw,
        pfrac_oxidw = pfrac_oxidw,

        k_capb = k_capb,
        k_fepb = k_fepb,
        k_phosw = k_phosw,
        k_landfrac = k_landfrac,
        k_aq = k_aq,

        CPsea0 = CPsea0,

        k_hyd_highT_P = k_hyd_highT_P,
        k_hyd_lowT_P = k_hyd_lowT_P,
        
        ####----------------------------------------####
        ####  Present-day nitrogen fluxes (mol/yr)  ####
        ####----------------------------------------####
        k_nfix = k_nfix,
        k_denit = k_denit,

        ####-----------------------------------------####
        ####  Present-day magnesium fluxes (mol/yr)  ####
        ####-----------------------------------------####
        molf_Mg_GRAN = molf_Mg_GRAN,
        molf_Mg_BAS = molf_Mg_BAS,

        k_hyd_highT_Mg = k_hyd_highT_Mg,
        k_hyd_lowT_Mg = k_hyd_lowT_Mg,

        molf_Mg_CARB = molf_Mg_CARB,
        k_dolo_sec = k_dolo_sec,

        ####-----------------------------------------####
        ####  Present-day calcium fluxes (mol/yr)  ####
        ####-----------------------------------------####
        molf_Ca_GRAN = molf_Ca_GRAN,
        molf_Ca_BAS = molf_Ca_BAS,

        molf_Ca_CARB = molf_Ca_CARB,

        ####--------------------------------------####
        ####  Present-day sodium fluxes (mol/yr)  ####
        ####--------------------------------------####
        molf_Na_GRAN = molf_Na_GRAN,
        molf_Na_BAS = molf_Na_BAS,

        k_hyd_highT_Na = k_hyd_highT_Na,
        k_rw_Na = k_rw_Na,

        k_NaClw = k_NaClw,
        k_NaClb = k_NaClb,

        k_Exb_Na = k_Exb_Na,
        k_Exr_Na = k_Exr_Na,
        k_Exd_Na = k_Exd_Na,

        ####-----------------------------------------####
        ####  Present-day potassium fluxes (mol/yr)  ####
        ####-----------------------------------------####
        molf_K_GRAN = molf_K_GRAN,
        molf_K_BAS = molf_K_BAS,

        k_rw_K = k_rw_K,
        k_hyd_highT_K = k_hyd_highT_K,

        k_KClw = k_KClw,
        k_KClb = k_KClb,

        ####------------------------------------------####
        ####  Present-day strontiumr fluxes (mol/yr)  ####
        ####------------------------------------------####
        k_Sr_granw_CO2 = k_Sr_granw_CO2,
        k_Sr_basw_CO2 = k_Sr_basw_CO2,
        k_Sr_carbw_CO2 = k_Sr_carbw_CO2,
        k_Sr_hyd_highT = k_Sr_hyd_highT,
        k_Sr_hyd_lowT = k_Sr_hyd_lowT,
        k_Sr_metam = k_Sr_metam,
        mcb_Sr = mcb_Sr,

        k_sfwSimple_Sr = k_sfwSimple_Sr,
        k_sfwMg_Sr = k_sfwMg_Sr,

        ####---------------------------------------####
        ####  Present-day uranium fluxes (mol/yr)  ####
        ####---------------------------------------####
        k_U_granw_CO2 = k_U_granw_CO2,
        k_U_basw_CO2 = k_U_basw_CO2,
        k_U_carbw_CO2 = k_U_carbw_CO2,
        k_anoxic_U = k_anoxic_U,
        k_other_U = k_other_U,
        k_U_hyd_highT = k_U_hyd_highT,
        k_U_hyd_lowT = k_U_hyd_lowT,


        ####---------------------------####
        ####  productivity parameters  ####
        ####---------------------------####
        k_oxfrac = k_oxfrac,
        newp0 = newp0,
        copsek16 = copsek16,
        plantenhance =  plantenhance,
        a = a,
        kfire = kfire,
        b = b,
        k_ANOX0 = k_ANOX0,
        
        ####----------####
        ####  others  ####
        ####----------####
        alpha_arag = alpha_arag,

        ####-------------------------------------------------------------####
        ####  magnesium isotope dynamic fractionation (δ26/24Mg, DSM-3)  ####
        ####-------------------------------------------------------------####
        delta_26_granw_initial = delta_26_granw_initial,
        delta_26_basw_initial = delta_26_basw_initial,
        delta_26_carbw_initial = delta_26_carbw_initial,
        delta_26_sfw_initial = delta_26_sfw_initial,

        ####-------------------------------------------------------------------####
        ####  calcium isotope dynamic fractionation (δ44/40Ca, NIST SRM-915a)  ####
        ####-------------------------------------------------------------------####
        delta_44_granw_initial = delta_44_granw_initial,
        delta_44_basw_initial = delta_44_basw_initial,
        delta_44_carbw_initial = delta_44_carbw_initial,
        delta_44_gypw_initial = delta_44_gypw_initial,
        D_44_mgb_initial = D_44_mgb_initial,
        D_44_dolo_sec_initial = D_44_dolo_sec_initial,
        D_44_sfw_initial = D_44_sfw_initial,
        delta_44_hyd_highT_initial = delta_44_hyd_highT_initial,
        delta_44_hyd_lowT_initial = delta_44_hyd_lowT_initial,
        D_44_pelagic_mcb_initial = D_44_pelagic_mcb_initial,
        D_44_shelf_mcb_arag_initial = D_44_shelf_mcb_arag_initial,
        D_44_shelf_mcb_calc_initial = D_44_shelf_mcb_calc_initial,

        ####-----------------------------------------------####
        ####  strontium isotope fractionation (87Sr/86Sr)  ####
        ####-----------------------------------------------####
        delta_87_granw_initial = delta_87_granw_initial,
        delta_87_basw_initial = delta_87_basw_initial,
        delta_87_mantle_initial = delta_87_mantle_initial,
        delta_87_Sr_0 = delta_87_Sr_0,
        lambda = lambda,
        RbSr_carbonate = RbSr_carbonate,

        ####-------------------------------------------------------####
        ####  uranium isotope dynamic fractionation (δ238/235U, )  ####
        ####-------------------------------------------------------####
        delta_238_granw_initial = delta_238_granw_initial,
        delta_238_basw_initial = delta_238_basw_initial,
        D_238_anoxic_initial = D_238_anoxic_initial,
        D_238_other_initial = D_238_other_initial,
        D_238_hyd_highT_initial = D_238_hyd_highT_initial,
        D_238_hyd_lowT_initial = D_238_hyd_lowT_initial,

        ####---------------------------------####
        ####  Initial values of reservoirs   ####
        ####---------------------------------####
        P_initial = P_initial,
        AO2_initial = AO2_initial,
        OO2_initial = OO2_initial,
        CO2_initial = CO2_initial,
        DIC_initial = DIC_initial,
        ORG_initial = ORG_initial,
        CARB_initial = CARB_initial,
        S_initial = S_initial,
        PYR_initial = PYR_initial,
        GYP_initial = GYP_initial,
        N_initial = N_initial,
        Mg_initial = Mg_initial,
        Ca_initial = Ca_initial,
        Na_initial = Na_initial,
        K_initial = K_initial,
        Cl_initial = Cl_initial,
        NaCl_initial = NaCl_initial,
        KCl_initial = KCl_initial,
        OSr_initial = OSr_initial,
        SSr_initial = SSr_initial,
        U_initial = U_initial,
        pH_initial = pH_initial,

    )

end


function default_initial_state(pars::Pars; tuning=nothing)
    
    u0 = zeros(Float64, 34)

    u0[1]  = pars.P_initial                  
    u0[2]  = pars.AO2_initial                
    u0[3]  = pars.OO2_initial                
    u0[4]  = pars.CO2_initial                
    u0[5]  = pars.DIC_initial                
    u0[6]  = pars.ORG_initial                
    u0[7]  = pars.CARB_initial               
    u0[8]  = pars.S_initial                 
    u0[9]  = pars.PYR_initial                
    u0[10] = pars.GYP_initial                
    u0[11] = pars.N_initial                  
    u0[12] = pars.Mg_initial                 
    u0[13] = pars.Ca_initial                
    u0[14] = pars.Na_initial                 
    u0[15] = pars.K_initial                 
    u0[16] = pars.Cl_initial                 
    u0[17] = pars.NaCl_initial               
    u0[18] = pars.KCl_initial                
    u0[19] = pars.OSr_initial                
    u0[20] = pars.SSr_initial                
    u0[21] = pars.U_initial                  
    u0[22] = pars.pH_initial               
    u0[23] = pars.delta_13_CO2_initial  * u0[4]    
    u0[24] = pars.delta_13_DIC_initial  * u0[5]    
    u0[25] = pars.delta_13_ORG_initial  * u0[6]    
    u0[26] = pars.delta_13_CARB_initial * u0[7]    
    u0[27] = pars.delta_34_S_initial    * u0[8]    
    u0[28] = pars.delta_34_PYR_initial  * u0[9]    
    u0[29] = pars.delta_34_GYP_initial  * u0[10]   
    u0[30] = pars.delta_26_Mg_initial   * u0[12]   
    u0[31] = pars.delta_44_Ca_initial   * u0[13]   
    u0[32] = pars.delta_87_OSr_initial  * u0[19]   
    u0[33] = pars.delta_87_SSr_initial  * u0[20]   
    u0[34] = pars.delta_238_U_initial   * u0[21]   

    return u0

end

end # module Parameters
