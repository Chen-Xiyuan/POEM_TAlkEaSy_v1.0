# =============================================================================
# TAlkEaSy Equations.jl
# =============================================================================

module Equations

using Statistics


import ..Parameters: Pars
import ..Forcings: ForcingsBundle, forcing_value
import ..Register: make_registered_variables, materialize, @registered_namedtuple


export ModelContext, TAlkEaSy_DAE!, register_variable, output_variables, DAE_algebraic_constraint


struct ModelContext

    pars::Pars

    forcings::ForcingsBundle

end

# -----------------------------
# forcings
# -----------------------------
function _forcings_at(t::Real, ctx::ModelContext)

    f = ctx.forcings

    CPland_relative     =    forcing_value(f.CPland_relative, t)
    EVO                 =    forcing_value(f.EVO, t)
    W                   =    forcing_value(f.W, t)
    COAL                =    forcing_value(f.COAL, t)
    GRAN_EXPOSED_AREA   =    forcing_value(f.GRAN_EXPOSED_AREA, t)
    DEGASS              =    forcing_value(f.DEGASS, t)
    UPLIFT              =    forcing_value(f.UPLIFT, t)
    PG                  =    forcing_value(f.PG, t)
    BA_EXPOSED_AREA     =    forcing_value(f.BA_EXPOSED_AREA, t)
    CARB_EXPOSED_AREA   =    forcing_value(f.CARB_EXPOSED_AREA, t)
    CARB_FLOODED_AREA   =    forcing_value(f.CARB_FLOODED_AREA, t)
    P_selective         =    forcing_value(f.P_selective, t)
    PELAGIC             =    forcing_value(f.PELAGIC, t)
    CO2_pulse           =    forcing_value(f.CO2_pulse, t)

    return (; 

        DEGASS, 
        UPLIFT,
        PG, 
        EVO, 
        W, 
        CPland_relative, 
        P_selective, 
        COAL,     
        PELAGIC,
        GRAN_EXPOSED_AREA, 
        BA_EXPOSED_AREA,
        CARB_EXPOSED_AREA, 
        CARB_FLOODED_AREA,

        CO2_pulse,

    )

end

const REGISTERED_OUTPUTS = make_registered_variables([

        :time,
        :time_myr,
        :DEGASS,
        :UPLIFT,
        :EVO,
        :W,
        :CPland_relative,
        :PELAGIC,
        :PG,
        :P_selective,
        :COAL,
        :GRAN_EXPOSED_AREA,
        :BA_EXPOSED_AREA,
        :CARB_EXPOSED_AREA,
        :CARB_FLOODED_AREA,

        :CO2_pulse,
        :delta_13_CO2_pulse,

        :P,
        :AO2,
        :MO2,
        :CO2,
        :DIC,
        :ORG,
        :CARB,
        :S,
        :PYR,
        :GYP,
        :N,
        :Mg,
        :Ca,
        :Na,
        :K,
        :Cl,
        :NaCl,
        :KCl,
        :OSr,
        :SSr,
        :U,

        :P_roc,
        :AO2_roc,
        :MO2_roc,
        :CO2_roc,
        :DIC_roc,
        :ORG_roc,
        :CARB_roc,
        :S_roc,
        :PYR_roc,
        :GYP_roc,
        :N_roc,
        :Mg_roc,
        :Ca_roc,
        :Na_roc,
        :K_roc,
        :Cl_roc,
        :NaCl_roc,
        :KCl_roc,
        :OSr_roc,
        :SSr_roc,
        :U_roc,
        :delta_13_CO2_roc,
        :delta_13_DIC_roc,
        :delta_13_ORG_roc,
        :delta_13_CARB_roc,
        :delta_34_S_roc,
        :delta_34_PYR_roc,
        :delta_34_GYP_roc,
        :delta_26_Mg_roc,
        :delta_44_Ca_roc,
        :delta_87_OSr_roc,
        :delta_87_SSr_roc,
        :delta_238_U_roc,

        :P_norm,
        :AO2_norm,
        :MO2_norm,
        :CO2_norm,
        :DIC_norm,
        :ORG_norm,
        :CARB_norm,
        :S_norm,
        :PYR_norm,
        :GYP_norm,
        :N_norm,
        :Mg_norm,
        :Ca_norm,
        :Na_norm,
        :K_norm,
        :Cl_norm,
        :NaCl_norm,
        :KCl_norm,
        :OSr_norm,
        :SSr_norm,
        :U_norm,

        :delta_13_CO2,
        :delta_13_DIC,
        :delta_13_ORG,
        :delta_13_CARB,
        :delta_34_S,
        :delta_34_PYR,
        :delta_34_GYP,
        :delta_26_Mg,
        :delta_44_Ca,
        :delta_87_OSr,
        :delta_87_SSr,
        :delta_238_U,

        :Mg_conc_mmolkgH2O,
        :Ca_conc_mmolkgH2O,
        :S_conc_mmolkgH2O,
        :Na_conc_mmolkgH2O,
        :K_conc_mmolkgH2O,
        :Cl_conc_mmolkgH2O,
        :P_conc_mmolkgH2O,
        :N_conc_mmolkgH2O,
        :TAlk_conc_mmolkgH2O,
        :DIC_conc_mmolkgH2O,
        :H_conc_mmolkgH2O,
        :OH_conc_mmolkgH2O,
        :CO2aq_conc_mmolkgH2O,
        :HCO3_conc_mmolkgH2O,
        :CO3_conc_mmolkgH2O,
        :B_conc_mmolkgH2O,
        :BOH4_conc_mmolkgH2O,
        :BOH3_conc_mmolkgH2O,
        :Mg_conc_molm3,
        :Ca_conc_molm3,
        :S_conc_molm3,
        :Na_conc_molm3,
        :K_conc_molm3,
        :Cl_conc_molm3,
        :TAlk_major_molm3,
        :DIC_conc_molm3,
        :B_conc_molm3,
        :MgCa_ratio,
        :TAlk_constraint,

        :pH,
        :Omega,

        :CO2atm,
        :pCO2PAL,
        :pO2PAL,
        :AO2atm,
        :GMST_K,
        :GMST_C,

        :transfer_atm_CO2,
        :transfer_ocean_CO2,
        :f_airsea_CO2,
        :transfer_atm_O2,
        :transfer_ocean_O2,
        :f_airsea_O2,

        :V_T,
        :V_co2,
        :V_o2,
        :V_npp,
        :ignit,
        :firef,
        :VEG,
        :ANOX,

        :f_T_gran,
        :f_T_bas,
        :f_T_runoff,
        :g_T_runoff,
        :gypw_T_runoff,
        :NaClw_T_runoff,
        :KClw_T_runoff,

        :OX_relative,
        :newp,
        :newp_relative,
        :CPsea,
        :f_biota,
        :f_gran,
        :f_bas,
        :f_carb,

        :granw_CO2_relative,
        :granw_CO2,
        :basw_CO2_relative,
        :basw_CO2,
        :silw_CO2_relative,
        :silw_CO2,
        :carbw_CO2_relative,
        :carbw_CO2,
        :mcb_total_relative,
        :mcb_total,
        :ccdeg,
        :sfwSimple_relative,
        :sfwMg_relative,
        :sfwSimple,
        :sfwMg,
        :sfwTotal_C,
        :oxidw_relative,
        :oxidw,
        :lob_C_relative,
        :lob_C,
        :mob_C_relative,
        :mob_C,

        :ocdeg,
        :pyrw_relative,
        :pyrw,
        :gypw_relative,
        :gypw,
        :pyrdeg_relative,
        :pyrdeg,
        :gypdeg_relative,
        :gypdeg,
        :mpb_S_relative,
        :mgb_relative,
        :mpb_S,
        :mgb,

        :phosw,
        :pland,
        :psea,
        :mob_P,
        :capb,
        :fepb,
        :hyd_highT_P,
        :hyd_lowT_P,
        :nfix,
        :denit,
        :mob_N,

        :granw_CO2_Mg,
        :basw_CO2_Mg,
        :silw_CO2_Mg,
        :hyd_highT_Mg_relative,
        :hyd_highT_Mg,
        :hyd_lowT_Mg_relative,
        :hyd_lowT_Mg,
        :carbw_CO2_Mg,
        :dolo_sec,

        :granw_CO2_Ca,
        :basw_CO2_Ca,
        :silw_CO2_Ca,
        :carbw_CO2_Ca,
        :hyd_highT_Ca,
        :hyd_lowT_Ca,

        :granw_CO2_Na,
        :basw_CO2_Na,
        :silw_CO2_Na,
        :hyd_highT_Na,
        :rw_Na_relative,
        :rw_Na,
        :NaClw_relative,
        :NaClw,
        :NaClb_relative,
        :NaClb,
        :Exb_Na_relative,
        :Exr_Na_relative,
        :Exd_Na_relative,
        :Exb_Na,
        :Exr_Na,
        :Exd_Na,

        :granw_CO2_K,
        :basw_CO2_K,
        :silw_CO2_K,
        :hyd_highT_K,
        :rw_K_relative,
        :rw_K,
        :KClw_relative,
        :KClw,
        :KClb_relative,
        :KClb,

        :granw_CO2_Sr,
        :basw_CO2_Sr,
        :silw_CO2_Sr,
        :carbw_CO2_Sr,
        :hyd_highT_Sr_relative,
        :hyd_highT_Sr,
        :hyd_lowT_Sr_relative,
        :hyd_lowT_Sr,
        :metam_Sr,
        :mcb_Sr,
        :sfwSimple_Sr,
        :sfwMg_Sr,
        :sfwTotal_Sr,

        :granw_CO2_U,
        :basw_CO2_U,
        :silw_CO2_U,
        :carbw_CO2_U,
        :anoxic_U,
        :other_U,
        :hyd_highT_U_relative,
        :hyd_highT_U,
        :hyd_lowT_U_relative,
        :hyd_lowT_U,

        :D_mccb_DIC,
        :D_B_mccb_mocb,
        :D_P_CO2_locb,
        :D_eqbw_CO2,
        :delta_13_riv,
        :delta_13_lob,
        :delta_13_mob,
        :delta_13_mcb,
        :eps_k,
        :eps_eqb,

        :D_mpb_S,
        :delta_34_mpb,

        :delta_26_granw,
        :delta_26_basw,
        :delta_26_carbw,
        :delta_26_sfw,
        :D_26_hyd_highT,
        :D_26_hyd_lowT,
        :D_26_dolo_sec,
        :delta_26_hyd_highT,
        :delta_26_hyd_lowT,
        :delta_26_dolo_sec,
        :delta_26_riv,


        :delta_44_granw,
        :delta_44_basw,
        :delta_44_carbw,
        :delta_44_gypw,
        :D_44_mgb,
        :delta_44_mgb,
        :D_44_dolo_sec,
        :delta_44_dolo_sec,
        :D_44_sfw,
        :delta_44_sfw,        
        :delta_44_hyd_highT,
        :delta_44_hyd_lowT,
        :delta_44_pelagic_mcb,
        :delta_44_shelf_mcb_arag,
        :delta_44_shelf_mcb_calc,

        :alpha_arag,
        :f_pelagic_mcb,
        :f_shelf_mcb,
        :shelf_mcb_arag_relative,
        :shelf_mcb_calc_relative,
        :pelagic_mcb,
        :shelf_mcb,
        :shelf_mcb_arag,
        :shelf_mcb_calc,

        :delta_87_granw,
        :delta_87_basw,
        :delta_87_mantle,
        :delta_87_SSr_Rb_decay,

        :delta_238_granw,
        :delta_238_basw,
        :delta_238_anoxic,
        :delta_238_other,
        :delta_238_hyd_highT,
        :delta_238_hyd_lowT,

    ])


function register_variable()

    return REGISTERED_OUTPUTS

end


# -----------------------------
# functional forms
# -----------------------------
function _core_calculations(t::Real, u::AbstractVector{<:Real}, ctx::ModelContext)

    p = ctx.pars
    
    # ---- geological time (Ma) ----
    time = float(t)
    time_myr = time * 1e-6

    # ---- forcings ----
    F = _forcings_at(t, ctx)

    DEGASS            = F.DEGASS
    UPLIFT            = F.UPLIFT
    W                 = F.W
    EVO               = F.EVO
    CPland_relative   = F.CPland_relative
    P_selective       = F.P_selective
    PELAGIC           = F.PELAGIC
    PG                = F.PG
    GRAN_EXPOSED_AREA = F.GRAN_EXPOSED_AREA
    BA_EXPOSED_AREA   = F.BA_EXPOSED_AREA
    CARB_EXPOSED_AREA = F.CARB_EXPOSED_AREA
    CARB_FLOODED_AREA = F.CARB_FLOODED_AREA
    COAL              = F.COAL
    CO2_pulse         = F.CO2_pulse

    # ---- geological reservoir ----
    P                =             float(u[1])                       ####    
    AO2              =             float(u[2])                       ####    
    MO2              =             float(u[3])                       ####    
    CO2              =             float(u[4])                       ####    
    DIC              =             float(u[5])                       ####    
    ORG              =             float(u[6])                       ####    
    CARB             =             float(u[7])                       ####    
    S                =             float(u[8])                       ####    
    PYR              =             float(u[9])                       ####    
    GYP              =             float(u[10])                      ####    
    N                =             float(u[11])                      ####    
    Mg               =             float(u[12])                      ####    
    Ca               =             float(u[13])                      ####    
    Na               =             float(u[14])                      ####    
    K                =             float(u[15])                      ####    
    Cl               =             float(u[16])                      ####    
    NaCl             =             float(u[17])                      ####    
    KCl              =             float(u[18])                      ####    
    OSr              =             float(u[19])                      ####    
    SSr              =             float(u[20])                      ####    
    U                =             float(u[21])                      ####    
    pH               =             float(u[22])                      ####    
    delta_13_CO2     =             float(u[23]) / CO2                ####    
    delta_13_DIC     =             float(u[24]) / DIC                ####    
    delta_13_ORG     =             float(u[25]) / ORG                ####    
    delta_13_CARB    =             float(u[26]) / CARB               ####    
    delta_34_S       =             float(u[27]) / S                  ####    
    delta_34_PYR     =             float(u[28]) / PYR                ####    
    delta_34_GYP     =             float(u[29]) / GYP                ####    
    delta_26_Mg      =             float(u[30]) / Mg                 ####   
    delta_44_Ca      =             float(u[31]) / Ca                 ####    
    delta_87_OSr     =             float(u[32]) / OSr                ####    
    delta_87_SSr     =             float(u[33]) / SSr                ####    
    delta_238_U      =             float(u[34]) / U                  ####    

    # ---- all reservoir normalized values ----
    P_norm      =    P / p.P0
    DIC_norm    =    DIC / p.DIC0
    MO2_norm    =    MO2 / p.MO20
    ORG_norm    =    ORG / p.ORG0
    CARB_norm   =    CARB / p.CARB0
    S_norm      =    S / p.S0
    PYR_norm    =    PYR / p.PYR0
    GYP_norm    =    GYP / p.GYP0
    N_norm      =    N / p.N0
    Mg_norm     =    Mg / p.Mg0
    Ca_norm     =    Ca / p.Ca0
    Na_norm     =    Na / p.Na0
    K_norm      =    K / p.K0
    Cl_norm     =    Cl / p.Cl0
    NaCl_norm   =    NaCl / p.NaCl0    
    KCl_norm    =    KCl / p.KCl0
    OSr_norm    =    OSr / p.OSr0
    SSr_norm    =    SSr / p.SSr0
    U_norm      =    U / p.U0

    # ---- seawater concentrations ----

    #  mol * kg^-1  =  (mol / m^3) / (kg / m^3)
    Mg_conc_molkgH2O   = (Mg  / p.vol_1box) / p.rho_sw
    Ca_conc_molkgH2O   = (Ca  / p.vol_1box) / p.rho_sw
    S_conc_molkgH2O    = (S   / p.vol_1box) / p.rho_sw
    Na_conc_molkgH2O   = (Na  / p.vol_1box) / p.rho_sw
    K_conc_molkgH2O    = (K   / p.vol_1box) / p.rho_sw
    Cl_conc_molkgH2O   = (Cl  / p.vol_1box) / p.rho_sw
    DIC_conc_molkgH2O  = (DIC / p.vol_1box) / p.rho_sw

    #  mmol * kg^-1  =  1000 * (mol * kg^-1)
    Mg_conc_mmolkgH2O   = 1000.0 * Mg_conc_molkgH2O
    Ca_conc_mmolkgH2O   = 1000.0 * Ca_conc_molkgH2O
    S_conc_mmolkgH2O    = 1000.0 * S_conc_molkgH2O
    Na_conc_mmolkgH2O   = 1000.0 * Na_conc_molkgH2O
    K_conc_mmolkgH2O    = 1000.0 * K_conc_molkgH2O
    Cl_conc_mmolkgH2O   = 1000.0 * Cl_conc_molkgH2O
    DIC_conc_mmolkgH2O  = 1000.0 * DIC_conc_molkgH2O

    # Nutrients:
    P_conc_umolkgH2O = P_norm * 2.2
    N_conc_umolkgH2O = N_norm * 30.9

    P_conc_mmolkgH2O = 1000.0 * ((P / p.vol_1box) / p.rho_sw)
    N_conc_mmolkgH2O = 1000.0 * ((N / p.vol_1box) / p.rho_sw)

    #  mol * m^-3       =  (mol / m^3)         
    Mg_conc_molm3       =  (Mg / p.vol_1box) 
    Ca_conc_molm3       =  (Ca / p.vol_1box) 
    S_conc_molm3        =  (S / p.vol_1box)  
    Na_conc_molm3       =  (Na / p.vol_1box) 
    K_conc_molm3        =  (K / p.vol_1box)  
    Cl_conc_molm3       =  (Cl / p.vol_1box) 
    DIC_conc_molm3      =  (DIC / p.vol_1box)

    B_conc_molm3        =  0.427

    #    /
    MgCa_ratio          = Mg_conc_mmolkgH2O / Ca_conc_mmolkgH2O


    # ---- pCO2, pO2 ----
    CO2_norm = CO2 / p.CO20        
    CO2atm = CO2 / p.moles1atm
    pCO2PAL = CO2_norm
    
    AO2_norm    = AO2 / p.AO20        
    pO2PAL = AO2_norm
    AO2atm = AO2 / p.moles1atm

    # ---- Temperature  ----
    k_c      =    p.k_c
    k_l      =    p.k_l
    GMST_K   =    273.15 + 15.0 + k_c * (log(CO2_norm)) + k_l * (time_myr / 570.0)    ####  (K)
    GMST_C   =    GMST_K - 273.15

    # ---- Vegetation / NPP ----
    V_T = 1.0 - (((GMST_K - 273.15 - 25.0) / 25.0) ^ 2)

    P_atm    =   CO2atm * 1e6
    P_half   =   183.6
    P_min    =   10.0
    V_co2    =   (P_atm - P_min) / (P_half + P_atm - P_min)

    V_o2     =   max(1.5 - 0.5 * (AO2 / p.AO20), 0.0)
    V_npp    =   2.0 * EVO * V_T * V_o2 * V_co2

    # Fire feedback 
    ignit = min(max(48.0 * AO2atm - 9.08, 0.0), 5.0)

    firef = p.kfire / (p.kfire - 1.0 + ignit)

    VEG = V_npp * firef

    # ---- Temperature dependencies ----
    f_T_gran = exp(0.0724 * (GMST_K - 273.15 - 15.0))    
    f_T_bas = exp(0.0608 * (GMST_K - 273.15 - 15.0))    

    f_T_runoff = ( max(1 + 0.038*(GMST_K - 273.15 - 15.0), 0)^0.65 )
    g_T_runoff = max(1 + 0.087*(GMST_K - 288.15),0)

    gypw_T_runoff = ( max(1 + 0.0606*(GMST_K - 273.15 - 15.0), 0)^1.0 )    
    NaClw_T_runoff = ( max(1 + 0.0232*(GMST_K - 273.15 - 15.0), 0)^1.0 )    
    KClw_T_runoff = ( max(1 + 0.0123*(GMST_K - 273.15 - 15.0), 0)^1.0 )    

    # ---- Biota factor (COPSE reloaded) ----

    V = VEG

    pCO2PAL_limit = max(pCO2PAL, 0.0)

    f_biota = (1.0 - min(V * W, 1.0)) * p.plantenhance * sqrt(pCO2PAL_limit) + (V * W)

    # ---- Weathering thermodynamic rate ----

    f_gran = f_T_gran * f_T_runoff * f_biota
    f_bas = f_T_bas * f_T_runoff * f_biota
    f_carb = g_T_runoff * f_biota

    # ---- land weathering fluxes ----
    granw_CO2_relative = UPLIFT * PG * GRAN_EXPOSED_AREA * f_gran
    basw_CO2_relative = PG * BA_EXPOSED_AREA * f_bas

    granw_CO2 = granw_CO2_relative * p.k_granw_CO2
    basw_CO2 = basw_CO2_relative * p.k_basw_CO2

    silw_CO2 = granw_CO2 + basw_CO2
    silw_CO2_relative = silw_CO2 / (p.k_granw_CO2 + p.k_basw_CO2)

    carbw_CO2_relative = CARB_EXPOSED_AREA * UPLIFT * PG * f_carb
    carbw_CO2 = carbw_CO2_relative * p.k_carbw_CO2

    AO2_limit = max(AO2 / p.AO20, 0.0)
    oxidw_relative = UPLIFT * (ORG / p.ORG0) * (AO2_limit ^ p.a)
    oxidw = oxidw_relative * p.k_oxidw

    pyrw_relative = UPLIFT * (PYR / p.PYR0)
    gypw_relative = UPLIFT * PG * (GYP / p.GYP0) * f_biota * gypw_T_runoff

    pyrw = p.k_pyrw * pyrw_relative
    gypw = p.k_gypw * gypw_relative

    phosw = P_selective * p.k_phosw * (
        p.pfrac_silw  * (silw_CO2  / (p.k_granw_CO2 + p.k_basw_CO2)) +
        p.pfrac_carbw * (carbw_CO2 / p.k_carbw_CO2) +
        p.pfrac_oxidw * (oxidw / p.k_oxidw)
    )

    phosw_relative = phosw / p.k_phosw

    # ---- Land vs sea P ----
    k_aq = p.k_aq
    pland = p.k_landfrac * VEG * phosw * (k_aq + (1.0 - k_aq) * COAL)
    pland0 = p.k_landfrac * p.k_phosw
    psea = phosw - pland

    # ---- Degassing ----
    ocdeg = p.k_ocdeg * DEGASS * (ORG / p.ORG0)
    ccdeg = p.k_ccdeg * DEGASS * (CARB / p.CARB0) * PELAGIC

    pyrdeg_relative = (PYR / p.PYR0) * DEGASS
    gypdeg_relative = (GYP / p.GYP0) * DEGASS
    pyrdeg = p.k_pyrdeg * pyrdeg_relative
    gypdeg = p.k_gypdeg * gypdeg_relative

    # ---- Nutrient concentrations and new production ----
    newp = 117.0 * min(N_conc_umolkgH2O / 16.0, P_conc_umolkgH2O)
    newp_relative = newp / p.newp0

    # ---- Ocean anoxic fraction ----
    k_anox = 12.0      
    k_u = 0.505    
    ANOX = 1.0 / (1.0 + exp(-k_anox * (k_u * newp_relative - pO2PAL)))

    # ---- Oxic fraction relative to initial oxic fraction (k_oxfrac) ----
    OX_relative = (1.0 - ANOX) / p.k_oxfrac


    # ---- Carbon burial ----
    mob_C_relative = (newp_relative ^ p.b) 
    lob_C_relative = (pland / pland0) * CPland_relative

    mob_C = p.k_mob_C * mob_C_relative
    lob_C = p.k_lob_C * lob_C_relative

    # ---- Sulfur burial ----
    mpb_S_relative = (S / p.S0) * (p.MO20 / MO2) * mob_C_relative

    mgb_relative = (S / p.S0) * (Ca / p.Ca0)

    mpb_S = p.k_mpb_S * mpb_S_relative
    mgb = p.k_mgb * mgb_relative

    CSsea = mob_C / mpb_S

    # ---- P burial ----
    CNsea = 37.5
    mob_N = mob_C / CNsea

    # CPsea: Van Cappellen & Ingall mixing (oxic vs anoxic endmembers)
    CPsea_oxic   = p.CPsea0
    CPsea_anoxic = 4000.0
    CPsea = (CPsea_oxic * CPsea_anoxic) / ((1.0 - ANOX) * CPsea_anoxic + ANOX * CPsea_oxic)

    # Organic P burial (mopb)
    mob_P = mob_C / CPsea

    # Carbonate-associated P burial 
    capb_relative = (newp_relative ^ p.b) * (0.5 + 0.5 * OX_relative)
    capb = p.k_capb * capb_relative

    # Fe-sorbed P burial (pdep)
    fepb_relative = OX_relative * P_norm
    fepb = p.k_fepb * fepb_relative


    # ---- Nitrogen cycle ----
    nfix = 0.0
    if (N / 16.0) < P
        nfix = p.k_nfix * (((P - (N / 16.0)) / (p.P0 - (p.N0 / 16.0))) ^ 2)
    end
    denit = p.k_denit * (1.0 + (ANOX / (1.0 - p.k_oxfrac))) * N_norm

    #$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#
    # ---- Ca, Mg, Na, K cycles ----
    #$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#

    # ---- land weathering ----
    granw_CO2_Mg = granw_CO2 * p.molf_Mg_GRAN
    granw_CO2_Ca = granw_CO2 * p.molf_Ca_GRAN
    granw_CO2_Na = granw_CO2 * p.molf_Na_GRAN * 2.0
    granw_CO2_K  = granw_CO2 * p.molf_K_GRAN * 2.0

    basw_CO2_Mg = basw_CO2 * p.molf_Mg_BAS
    basw_CO2_Ca = basw_CO2 * p.molf_Ca_BAS
    basw_CO2_Na = basw_CO2 * p.molf_Na_BAS * 2.0
    basw_CO2_K  = basw_CO2 * p.molf_K_BAS * 2.0

    silw_CO2_Mg = granw_CO2_Mg + basw_CO2_Mg
    silw_CO2_Ca = granw_CO2_Ca + basw_CO2_Ca
    silw_CO2_Na = granw_CO2_Na + basw_CO2_Na
    silw_CO2_K  = granw_CO2_K  + basw_CO2_K

    carbw_CO2_Mg = carbw_CO2 * p.molf_Mg_CARB
    carbw_CO2_Ca = carbw_CO2 * p.molf_Ca_CARB

    NaClw_relative = UPLIFT * PG * (NaCl / p.NaCl0) * f_biota * NaClw_T_runoff
    KClw_relative = UPLIFT * PG * (KCl / p.KCl0) * f_biota * KClw_T_runoff

    NaClw = p.k_NaClw * NaClw_relative
    KClw  = p.k_KClw  * KClw_relative

    # ---- NaCl, KCl burial ----

    NaClb_relative = (Na / p.Na0) * (Cl / p.Cl0)
    KClb_relative = (K / p.K0) * (Cl / p.Cl0)

    NaClb = p.k_NaClb * NaClb_relative
    KClb  = p.k_KClb  * KClb_relative

    # ---- secendary dolomitization ----

    dolo_sec_relative = (Mg / p.Mg0) * (CARB_FLOODED_AREA^2.0)

    dolo_sec = p.k_dolo_sec * dolo_sec_relative

    # ---- high-temperature hydrothermal ----

    hyd_highT_Mg_relative = DEGASS * (Mg / p.Mg0)

    hyd_highT_Mg = p.k_hyd_highT_Mg * hyd_highT_Mg_relative

    hyd_highT_Ca = hyd_highT_Mg

    hyd_highT_Na_relative = DEGASS * (Na / p.Na0)

    hyd_highT_Na = p.k_hyd_highT_Na * hyd_highT_Na_relative

    hyd_highT_K_relative = DEGASS * (K / p.K0)
    hyd_highT_K = p.k_hyd_highT_K * hyd_highT_K_relative

    # ---- low-temperature hydrothermal ----

    hyd_lowT_Mg_relative = ((9.0 + GMST_K - 273.15) / (9.0 + 288.15 - 273.15)) * (Mg / p.Mg0)

    hyd_lowT_Mg = p.k_hyd_lowT_Mg * hyd_lowT_Mg_relative

    hyd_lowT_Ca = hyd_lowT_Mg

    # ---- Phosphorus hydrothermal removal  ----

    hyd_highT_P = p.k_hyd_highT_P * P_norm * DEGASS

    hyd_lowT_P = p.k_hyd_lowT_P * P_norm * ((9.0 + GMST_K - 273.15) / (9.0 + 288.15 - 273.15)) 

    # ---- seafloor weathering (now assume seafloor weathering ≠ low-temperature hydrothermal) ----

    sfwSimple_relative = exp(0.0608*(GMST_K - 288.15)) * DEGASS

    sfwMg_relative = exp(0.0608*(GMST_K - 288.15)) * DEGASS

    sfwSimple = p.k_sfwSimple * sfwSimple_relative

    sfwMg = p.k_sfwMg * sfwMg_relative

    sfwTotal_C = sfwSimple + sfwMg

    # ---- Na, K reverse weathering ----

    rw_Na_relative = Na_norm
    rw_K_relative = K_norm

    rw_Na = p.k_rw_Na * rw_Na_relative
    rw_K  = p.k_rw_K  * rw_K_relative

    # ---- Na cation exchange ----

    Exb_Na_relative = 1.0

    Exr_Na_relative = Na_norm * UPLIFT

    Exd_Na_relative = Na_norm

    Exb_Na = p.k_Exb_Na * Exb_Na_relative
    Exr_Na = p.k_Exr_Na * Exr_Na_relative
    Exd_Na = p.k_Exd_Na * Exd_Na_relative
    
    # ---- ocean chemistry ----

    #     mol * m^-3
    TAlk_major_molm3  =  (2.0 * Mg_conc_molm3) + (2.0 * Ca_conc_molm3) - (2.0 * S_conc_molm3) + (1.0 * Na_conc_molm3) + (1.0 * K_conc_molm3) - (1.0 * Cl_conc_molm3)

    #     mmol * kg^-1 H2O = (mol * m^-3) / (kg * m^-3) * 1000
    TAlk_conc_mmolkgH2O = 1000.0 * (TAlk_major_molm3 / p.rho_sw)

    #     mol * kg^-1 =  mol * m^-3   / (kg * m^-3)
    B_conc_molkgH2O  =  B_conc_molm3 / p.rho_sw
    B_conc_mmolkgH2O = 1000.0 * B_conc_molkgH2O

    # [H+] is defined via pH with mol/L; convert to mol/kg using 1000 L/m^3 and seawater density (kg/m^3)
    H_conc_molkgH2O   = 1000.0 * (10.0^(-pH) / p.rho_sw)
    H_conc_mmolkgH2O  = 1000.0 * H_conc_molkgH2O

    # Carbonate speciation in mol/kg
    CO2aq_conc_molkgH2O  = DIC_conc_molkgH2O / (1 + p.K_1 / H_conc_molkgH2O + (p.K_1 * p.K_2) / (H_conc_molkgH2O^2))
    HCO3_conc_molkgH2O   = DIC_conc_molkgH2O / (1 + H_conc_molkgH2O / p.K_1 + p.K_2 / H_conc_molkgH2O)
    CO3_conc_molkgH2O    = DIC_conc_molkgH2O / (1 + H_conc_molkgH2O / p.K_2 + (H_conc_molkgH2O^2) / (p.K_1 * p.K_2))

    BOH4_conc_molkgH2O   = B_conc_molkgH2O / (1 + H_conc_molkgH2O / p.K_B)
    BOH3_conc_molkgH2O   = B_conc_molkgH2O - BOH4_conc_molkgH2O

    OH_conc_molkgH2O     = p.K_W / H_conc_molkgH2O

    # Minor alkalinity (mol/kg), then convert to mol/m^3 for the DAE constraint
    TAlk_minor_molkgH2O  = HCO3_conc_molkgH2O + (2.0 * CO3_conc_molkgH2O) + BOH4_conc_molkgH2O + OH_conc_molkgH2O - H_conc_molkgH2O
    TAlk_minor_molm3     = TAlk_minor_molkgH2O * p.rho_sw

    TAlk_constraint      = TAlk_major_molm3 - TAlk_minor_molm3

    # Output concentrations (mmol/kg)
    CO2aq_conc_mmolkgH2O = 1000.0 * CO2aq_conc_molkgH2O
    HCO3_conc_mmolkgH2O  = 1000.0 * HCO3_conc_molkgH2O
    CO3_conc_mmolkgH2O   = 1000.0 * CO3_conc_molkgH2O
    BOH4_conc_mmolkgH2O  = 1000.0 * BOH4_conc_molkgH2O
    BOH3_conc_mmolkgH2O  = 1000.0 * BOH3_conc_molkgH2O
    OH_conc_mmolkgH2O    = 1000.0 * OH_conc_molkgH2O

    # ---- carbonate chemistry ----

    Omega = Ca_conc_molkgH2O * CO3_conc_molkgH2O / p.K_sp

    if Omega >= 1.0

        mcb_total = p.k_mcb_total * ( (Omega - 1.0)^p.Eta_carb / p.Omega0 )

        mcb_total_relative = mcb_total / p.mcb_total0

    else

        mcb_total = 0.0

        mcb_total_relative = mcb_total / p.mcb_total0

    end

    # ---- air sea exchange (CO2, O2) ----

    #  mol * m^-3   =  (mol * m^-3 * atm^-1) * atm 
    CO2aq_conc_eqb  =  p.K_0_CO2 * CO2atm

    #        mol      =    (mol * m^-3) * (m * yr^-1) * (m^2)             
    transfer_atm_CO2  =  CO2aq_conc_eqb * p.vpiston * p.area_1box

    #        mol        =           (mol * m^-3) * (m * yr^-1) * (m^2)
    # CO2aq_conc_molkgH2O 是 mol/kg，需要乘以海水密度 rho_sw 转为 mol/m^3。
    transfer_ocean_CO2  =  (CO2aq_conc_molkgH2O * p.rho_sw) * p.vpiston * p.area_1box

    #  mol * m^-3  =  (mol * m^-3 * atm^-1) * atm 
    O2aq_conc_eqb  =  p.K_0_O2 * AO2atm

    #  mol * m^-3    =  (mol * m^-3 * atm^-1) * atm 
    O2aq_conc_molm3  =  MO2 / p.vol_1box

    #        mol      =    (mol * m^-3) * (m * yr^-1) * (m^2)             
    transfer_atm_O2  =  O2aq_conc_eqb * p.vpiston * p.area_1box

    #        mol       =     (mol * m^-3) * (m * yr^-1) * (m^2)             
    transfer_ocean_O2  =  O2aq_conc_molm3 * p.vpiston * p.area_1box

    #        mol       =      mol
    f_airsea_CO2       =  transfer_atm_CO2 - transfer_ocean_CO2

    #        mol       =      mol
    f_airsea_O2       =  transfer_atm_O2 - transfer_ocean_O2

    # ---- Sr cycle ----

    granw_CO2_Sr  =  p.k_Sr_granw_CO2 * granw_CO2_relative

    basw_CO2_Sr   =  p.k_Sr_basw_CO2 * basw_CO2_relative

    silw_CO2_Sr   =  granw_CO2_Sr + basw_CO2_Sr

    carbw_CO2_Sr  =  p.k_Sr_carbw_CO2 * carbw_CO2_relative

    hyd_highT_Sr_relative = DEGASS

    hyd_highT_Sr  =  p.k_Sr_hyd_highT * hyd_highT_Sr_relative 

    hyd_lowT_Sr_relative = exp(0.125 * (GMST_C-15.0))

    hyd_lowT_Sr   =  p.k_Sr_hyd_lowT * hyd_lowT_Sr_relative

    metam_Sr      =  p.k_Sr_metam * (SSr / p.SSr0)

    mcb_Sr        =  p.mcb_Sr * (mcb_total / p.mcb_total0) * (OSr / p.OSr0)

    sfwSimple_Sr  =  p.k_sfwSimple_Sr * sfwSimple_relative * (OSr / p.OSr0)

    sfwMg_Sr      =  p.k_sfwMg_Sr * sfwMg_relative * (OSr / p.OSr0)

    sfwTotal_Sr   =  sfwSimple_Sr + sfwMg_Sr

    # ---- U cycle ----
    granw_CO2_U   =  p.k_U_granw_CO2 * granw_CO2_relative

    basw_CO2_U    =  p.k_U_basw_CO2 * basw_CO2_relative

    silw_CO2_U    =  granw_CO2_U + basw_CO2_U

    carbw_CO2_U   =  p.k_U_carbw_CO2 * carbw_CO2_relative

    anoxic_U      =  p.k_anoxic_U * (ANOX/p.k_ANOX0) * (U / p.U0)

    other_U       =  p.k_other_U * (U / p.U0) * ((1.0 - ANOX) / (1.0 - p.k_ANOX0))

    hyd_highT_U_relative = DEGASS * (U / p.U0)

    hyd_highT_U   =  p.k_U_hyd_highT * hyd_highT_U_relative

    hyd_lowT_U_relative = (U / p.U0)

    hyd_lowT_U    =  p.k_U_hyd_lowT * hyd_lowT_U_relative

    # inorganic carbon isotope dynamic fractionation (δ13/12C, V-CDB)
    D_mccb_DIC = 15.10 - (4232.0 / GMST_K)    

    pCO2PAL_min = 1e-3 
    D_B_mccb_mocb = 33.0 - 9.0/sqrt(max(pCO2PAL, pCO2PAL_min)) + 5*(pO2PAL-1.0)    

    D_P_CO2_locb = 19 + 5 * (pO2PAL-1)    

    D_eqbw_CO2 = 10.78 - 0.114 * (GMST_K - 273.15)    

    delta_13_riv = delta_13_CO2 + D_eqbw_CO2    

    delta_13_lob = delta_13_CO2 - D_P_CO2_locb

    delta_13_mcb = delta_13_DIC + D_mccb_DIC

    delta_13_mob = delta_13_mcb - D_B_mccb_mocb

    eps_k = -0.9    
    eps_eqb = 10.53 - 0.105 * (GMST_K - 273.15)   

    # sulfur isotope dynamic fractionation (δ34/32S, V-CDT)
    D_mpb_S = 40.0    
    delta_34_mpb = delta_34_S - D_mpb_S

    # magnesium isotope dynamic fractionation (δ26/24Mg, DSM-3)
    delta_26_granw = p.delta_26_granw_initial
    delta_26_basw  = p.delta_26_basw_initial
    delta_26_carbw = p.delta_26_carbw_initial
    riv_Mg = granw_CO2_Mg + basw_CO2_Mg + carbw_CO2_Mg
    delta_26_riv = ( (delta_26_granw * granw_CO2_Mg) + (delta_26_basw * basw_CO2_Mg) + (delta_26_carbw * carbw_CO2_Mg) ) / (riv_Mg)
    delta_26_sfw   = p.delta_26_sfw_initial
    D_26_hyd_highT = 0.0
    delta_26_hyd_highT = delta_26_Mg + D_26_hyd_highT
    D_26_hyd_lowT = ( (2.71 * 1.0e3) / (GMST_K + 9.0) - 7.81 )  
    delta_26_hyd_lowT = delta_26_Mg + D_26_hyd_lowT
    D_26_dolo_sec = ( (-0.1554) * (1.0e6) / (GMST_K^2.0) )
    delta_26_dolo_sec = delta_26_Mg + D_26_dolo_sec

    # calcium isotope dynamic fractionation (δ44/40Ca, NIST SRM-915a)
    delta_44_granw = p.delta_44_granw_initial
    delta_44_basw  = p.delta_44_basw_initial
    delta_44_carbw = p.delta_44_carbw_initial
    delta_44_gypw = p.delta_44_gypw_initial
    D_44_mgb = p.D_44_mgb_initial
    delta_44_mgb = delta_44_Ca + D_44_mgb
    D_44_dolo_sec = p.D_44_dolo_sec_initial
    delta_44_dolo_sec = delta_44_Ca + D_44_dolo_sec
    delta_44_hyd_highT = p.delta_44_hyd_highT_initial
    delta_44_hyd_lowT = p.delta_44_hyd_lowT_initial
    D_44_sfw = p.D_44_sfw_initial
    delta_44_sfw = delta_44_Ca + D_44_sfw

    f_pelagic_mcb_modern = 0.65
    f_pelagic_mcb = f_pelagic_mcb_modern * PELAGIC
    pelagic_mcb = mcb_total * f_pelagic_mcb

    f_shelf_mcb = 1.0 - f_pelagic_mcb
    shelf_mcb = mcb_total * f_shelf_mcb

    shelf_mcb_arag_relative = 1.0 / (1.0 + exp( -p.alpha_arag * (MgCa_ratio - 2.0)^(1.0) ) )
    shelf_mcb_calc_relative = 1.0 - shelf_mcb_arag_relative

    shelf_mcb_arag = shelf_mcb * shelf_mcb_arag_relative
    shelf_mcb_calc = shelf_mcb * shelf_mcb_calc_relative

    D_44_pelagic_mcb = p.D_44_pelagic_mcb_initial
    delta_44_pelagic_mcb = delta_44_Ca + D_44_pelagic_mcb

    D_44_shelf_mcb_arag = p.D_44_shelf_mcb_arag_initial
    D_44_shelf_mcb_calc = p.D_44_shelf_mcb_calc_initial

    delta_44_shelf_mcb_arag = delta_44_Ca + D_44_shelf_mcb_arag
    delta_44_shelf_mcb_calc = delta_44_Ca + D_44_shelf_mcb_calc

    # radioactive strontium isotope dynamic fractionation (87Sr/86Sr)
    tforwards = 4.5e9 + float(t)

    RbSr_gran      =    (p.delta_87_granw_initial - p.delta_87_Sr_0) / (1.0 - exp(-p.lambda * 4.5e9))
    RbSr_bas       =    (p.delta_87_basw_initial - p.delta_87_Sr_0) / (1.0 - exp(-p.lambda * 4.5e9))
    RbSr_mantle    =    (p.delta_87_mantle_initial - p.delta_87_Sr_0) / (1.0 - exp(-p.lambda * 4.5e9))

    delta_87_granw          =    p.delta_87_Sr_0 + RbSr_gran * (1.0 - exp(-p.lambda * tforwards))
    delta_87_basw           =    p.delta_87_Sr_0 + RbSr_bas * (1.0 - exp(-p.lambda * tforwards))
    delta_87_mantle         =    p.delta_87_Sr_0 + RbSr_mantle * (1.0 - exp(-p.lambda * tforwards))
    delta_87_SSr_Rb_decay   =    p.RbSr_carbonate * p.lambda * exp(p.lambda * (-float(t)))

    # uranium isotope dynamic fractionation (δ238/235U, )
    delta_238_granw = p.delta_238_granw_initial
    delta_238_basw = p.delta_238_basw_initial
    delta_238_anoxic = delta_238_U + p.D_238_anoxic_initial
    delta_238_other = delta_238_U + p.D_238_other_initial 
    delta_238_hyd_highT = delta_238_U + p.D_238_hyd_highT_initial 
    delta_238_hyd_lowT = delta_238_U + p.D_238_hyd_lowT_initial 

    alpha_arag = p.alpha_arag

    delta_13_CO2_pulse = 0.0


    # ---- Rate of change (roc) for different reservoirs ----

    P_roc = psea - mob_P - capb - fepb - hyd_highT_P - hyd_lowT_P

    AO2_roc = (lob_C - oxidw - ocdeg) -
              (15 / 8) * (pyrw + pyrdeg) -
              f_airsea_O2

    MO2_roc = mob_C +
              (15 / 8) * mpb_S +
              f_airsea_O2

    CO2_roc = (ccdeg - carbw_CO2 - 2.0 * silw_CO2) +
              (ocdeg + oxidw - lob_C) -
              f_airsea_CO2 + CO2_pulse

    DIC_roc = (2.0 * silw_CO2 + 2.0 * carbw_CO2 - mcb_total - sfwTotal_C - 0.5 * (hyd_highT_Na + hyd_highT_K)) -
              mob_C +
              f_airsea_CO2

    ORG_roc = lob_C + mob_C - ocdeg - oxidw

    CARB_roc = mcb_total + sfwTotal_C + 0.5 * (hyd_highT_Na + hyd_highT_K) -
               (ccdeg + carbw_CO2)

    S_roc = pyrw + pyrdeg - mpb_S +
            gypw + gypdeg - mgb

    PYR_roc = mpb_S - pyrw - pyrdeg

    GYP_roc = mgb - gypw - gypdeg

    N_roc = nfix - denit - mob_N

    Mg_roc = (silw_CO2_Mg + sfwMg - hyd_highT_Mg - hyd_lowT_Mg) +
             (carbw_CO2_Mg - dolo_sec)

    Ca_roc = silw_CO2_Ca + carbw_CO2_Ca + gypw +
             hyd_highT_Ca + hyd_lowT_Ca + dolo_sec -
             mgb - mcb_total - sfwMg

    Na_roc = (silw_CO2_Na - hyd_highT_Na - rw_Na) +
             (NaClw - NaClb) +
             (Exb_Na - Exr_Na - Exd_Na)

    K_roc = (silw_CO2_K - rw_K - hyd_highT_K) +
            (KClw - KClb)

    Cl_roc = (NaClw + KClw) - (NaClb + KClb)    

    NaCl_roc = NaClb - NaClw

    KCl_roc = KClb - KClw

    OSr_roc = granw_CO2_Sr + basw_CO2_Sr + carbw_CO2_Sr +
              hyd_highT_Sr + hyd_lowT_Sr - mcb_Sr - sfwTotal_Sr

    SSr_roc = mcb_Sr - carbw_CO2_Sr - metam_Sr

    U_roc = granw_CO2_U + basw_CO2_U -
            (anoxic_U + other_U) -
            (hyd_highT_U + hyd_lowT_U)

    delta_13_CO2_roc = (ccdeg * delta_13_CARB) -
                       ((carbw_CO2 + 2.0 * silw_CO2) * (delta_13_CO2 + D_eqbw_CO2)) +
                       (ocdeg * delta_13_ORG + oxidw * delta_13_ORG - lob_C * delta_13_lob) -
                       (transfer_atm_CO2 * (delta_13_CO2 + eps_k + eps_eqb) - transfer_ocean_CO2 * (delta_13_DIC + eps_k)) + CO2_pulse * delta_13_CO2_pulse

    delta_13_DIC_roc =
                       (2.0 * silw_CO2 + carbw_CO2) * (delta_13_CO2 + D_eqbw_CO2) +
                       (carbw_CO2 * delta_13_CARB) -
                       (mcb_total * delta_13_mcb) -
                       (sfwTotal_C * delta_13_mcb) -
                       (0.5 * (hyd_highT_Na + hyd_highT_K) * delta_13_mcb) -
                       (mob_C * delta_13_mob) +
                       (transfer_atm_CO2 * (delta_13_CO2 + eps_k + eps_eqb) - transfer_ocean_CO2 * (delta_13_DIC + eps_k))

    delta_13_ORG_roc = lob_C * delta_13_lob + mob_C * delta_13_mob -
                       oxidw * delta_13_ORG - ocdeg * delta_13_ORG

    delta_13_CARB_roc =
                        (mcb_total * delta_13_mcb) +
                        (sfwTotal_C * delta_13_mcb) +
                        (0.5 * (hyd_highT_Na + hyd_highT_K) * delta_13_mcb) -
                        (carbw_CO2 * delta_13_CARB) -
                        (ccdeg * delta_13_CARB)

    delta_34_S_roc = gypw * delta_34_GYP + pyrw * delta_34_PYR +
                     gypdeg * delta_34_GYP +  pyrdeg * delta_34_PYR -
                     mpb_S * delta_34_mpb - mgb * delta_34_S

    delta_34_PYR_roc = mpb_S * delta_34_mpb -
                       pyrw * delta_34_PYR - pyrdeg * delta_34_PYR

    delta_34_GYP_roc = mgb * delta_34_S -
                       gypw * delta_34_GYP - gypdeg * delta_34_GYP

    delta_26_Mg_roc = riv_Mg * delta_26_riv + 
                      sfwMg * delta_26_sfw - 
                      hyd_highT_Mg * delta_26_hyd_highT - 
                      hyd_lowT_Mg * delta_26_hyd_lowT - 
                      dolo_sec * delta_26_dolo_sec
    
    delta_44_Ca_roc =
                      granw_CO2_Ca * delta_44_granw +
                      basw_CO2_Ca * delta_44_basw +
                      carbw_CO2_Ca * delta_44_carbw +
                      gypw * delta_44_gypw +
                      hyd_highT_Ca * delta_44_hyd_highT +
                      hyd_lowT_Ca * delta_44_hyd_lowT +
                      dolo_sec * delta_44_dolo_sec -
                      mgb * delta_44_mgb -
                      sfwMg * delta_44_sfw -
                      pelagic_mcb * delta_44_pelagic_mcb -
                      shelf_mcb_arag * delta_44_shelf_mcb_arag -
                      shelf_mcb_calc * delta_44_shelf_mcb_calc

    delta_87_OSr_roc = granw_CO2_Sr * delta_87_granw + basw_CO2_Sr * delta_87_basw +
                       carbw_CO2_Sr * delta_87_SSr +
                       hyd_highT_Sr * delta_87_mantle +
                       hyd_lowT_Sr * delta_87_mantle -
                       mcb_Sr * delta_87_OSr - sfwTotal_Sr * delta_87_OSr

    delta_87_SSr_roc = mcb_Sr * delta_87_OSr -
                       carbw_CO2_Sr * delta_87_SSr - metam_Sr * delta_87_SSr +
                       SSr * delta_87_SSr_Rb_decay

    delta_238_U_roc = granw_CO2_U * delta_238_granw + basw_CO2_U * delta_238_basw -
                      hyd_highT_U * delta_238_hyd_highT - hyd_lowT_U * delta_238_hyd_lowT -
                      anoxic_U * delta_238_anoxic - other_U * delta_238_other

    return @registered_namedtuple REGISTERED_OUTPUTS

end


function DAE_algebraic_constraint()

    return Int[22]

end


function TAlkEaSy_DAE!(out, du, u, ctx::ModelContext, t)

    c = _core_calculations(t, u, ctx)

    @inbounds begin

        # ---- Reservoir equations ----
        out[1]  = du[1]  - c.P_roc
        out[2]  = du[2]  - c.AO2_roc
        out[3]  = du[3]  - c.MO2_roc
        out[4]  = du[4]  - c.CO2_roc
        out[5]  = du[5]  - c.DIC_roc
        out[6]  = du[6]  - c.ORG_roc
        out[7]  = du[7]  - c.CARB_roc
        out[8]  = du[8]  - c.S_roc
        out[9]  = du[9]  - c.PYR_roc
        out[10] = du[10] - c.GYP_roc
        out[11] = du[11] - c.N_roc
        out[12] = du[12] - c.Mg_roc
        out[13] = du[13] - c.Ca_roc
        out[14] = du[14] - c.Na_roc
        out[15] = du[15] - c.K_roc
        out[16] = du[16] - c.Cl_roc
        out[17] = du[17] - c.NaCl_roc
        out[18] = du[18] - c.KCl_roc
        out[19] = du[19] - c.OSr_roc
        out[20] = du[20] - c.SSr_roc
        out[21] = du[21] - c.U_roc
        out[22] = c.TAlk_constraint
        out[23] = du[23] - c.delta_13_CO2_roc
        out[24] = du[24] - c.delta_13_DIC_roc
        out[25] = du[25] - c.delta_13_ORG_roc
        out[26] = du[26] - c.delta_13_CARB_roc
        out[27] = du[27] - c.delta_34_S_roc
        out[28] = du[28] - c.delta_34_PYR_roc
        out[29] = du[29] - c.delta_34_GYP_roc
        out[30] = du[30] - c.delta_26_Mg_roc
        out[31] = du[31] - c.delta_44_Ca_roc
        out[32] = du[32] - c.delta_87_OSr_roc
        out[33] = du[33] - c.delta_87_SSr_roc
        out[34] = du[34] - c.delta_238_U_roc

    end

    return nothing

end


# -----------------------------
# output variables
# -----------------------------
function output_variables(t::Real, u::AbstractVector{<:Real}, ctx::ModelContext)

    c = _core_calculations(t, u, ctx)

    return materialize(c, register_variable())

end

const diagnostics = output_variables


end # module Equations
