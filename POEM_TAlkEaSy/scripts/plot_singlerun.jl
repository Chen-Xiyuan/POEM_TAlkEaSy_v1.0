using Plots
using Measures

default(framestyle=:box)



struct PlotPager

    nrows::Int

    ncols::Int

end

PlotPager() = PlotPager(3, 4)


function plot_TAlkEaSy_singlerun(output;
    pages::AbstractVector{Int} = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13],
    pager::PlotPager = PlotPager(),
    use_time_myr::Bool = false,
    xlim = nothing,
    xticks = nothing,
    show::Bool = true,
    save_pdf::Bool = false,
    pdf_dir::String = normpath(joinpath(@__DIR__, "..", "results")),
    pdf_prefix::String = "TAlkEaSy_singlerun",
)

    x = use_time_myr ? output.time_myr : output.time


    figs = Any[]  

    for page in pages
        
        fig = nothing

        # ---------------------------------------------------------------------
        # Page 01: forcings
        # ---------------------------------------------------------------------
        if page == 1

            p01 = plot(x, hcat(output.DEGASS);
                      xlim = xlim, 
                      ylim = (0.0, 3.0),
                      title = "DEGASS",
                      label = ["DEGASS"],
                      legend = :topleft,)

            p02 = plot(x, [output.CO2_pulse];
                      xlim = xlim, 
                      title = "CO2_pulse",
                      label = ["CO2_pulse"],
                      legend = :topleft,)

            fig = plot(
                p01, p02;
                layout = (pager.nrows, pager.ncols),
                size = (1800, 900),
                left_margin = 2mm,
                right_margin = 2mm,
                top_margin = 2mm,
                bottom_margin = 2mm,
                plot_spacing = 2.0,
            )

        end


        # ---------------------------------------------------------------------
        # Page 02：Isotopes
        # ---------------------------------------------------------------------
        if page == 2

            p01 = plot(x, hcat(output.delta_13_DIC,); 
                      xlim = xlim,
                      title = "delta_13_DIC", 
                      label = ["delta_13_DIC"],
                      legend = :topleft,)

            p02 = plot(x, hcat(output.delta_34_S,); 
                      xlim = xlim, 
                      title = "delta_34_S", 
                      label = ["delta_34_S"],
                      legend = :topleft,)
                      
            p03 = plot(x, hcat(output.delta_26_Mg,); 
                      xlim = xlim, 
                      title = "delta_26_Mg", 
                      label = ["delta_26_Mg"],
                      legend = :topleft,)

            p04 = plot(x, hcat(output.delta_44_Ca,); 
                      xlim = xlim,  
                      title = "delta_44_Ca", 
                      label = ["delta_44_Ca"],
                      legend = :topleft,)

            p05 = plot(x, hcat(output.delta_87_OSr,); 
                      xlim = xlim,  
                      title = "delta_87_OSr", 
                      label = ["delta_87_OSr"],
                      legend = :topleft,)

            p06 = plot(x, hcat(output.delta_238_U,); 
                      xlim = xlim,
                      title = "delta_238_U", 
                      label = ["delta_238_U"],
                      legend = :topleft,)

            fig = plot(
                p01, p02, p03, p04,
                p05, p06;
                layout = (pager.nrows, pager.ncols),
                size = (1800, 900),
                left_margin = 2mm,                             
                right_margin = 2mm,                            
                top_margin = 2mm,                               
                bottom_margin = 2mm,                            
                plot_spacing = 2.0,                              
            )

        end

        # ---------------------------------------------------------------------
        # Page 03：CO2, O2, carbonate chemistry
        # ---------------------------------------------------------------------
        if page == 3

            p01 = plot(x, hcat(output.pCO2PAL,); 
                      xlim = xlim,
                      title = "pCO2PAL", 
                      label = ["pCO2PAL"],
                      legend = :topleft,)

            p02 = plot(x, hcat(output.pO2PAL,); 
                      xlim = xlim,  
                      title = "pO2PAL", 
                      label = ["pO2PAL"],
                      legend = :topleft,)

            p03 = plot(x, hcat(output.AO2atm,); 
                      xlim = xlim,   
                      title = "AO2atm", 
                      label = ["AO2atm"],
                      legend = :topleft,)


            p04 = plot(x, hcat(output.GMST_C,); 
                      xlim = xlim, 
                      title = "GMST_C", 
                      label = ["GMST_C"],
                      legend = :topleft,)

            p05 = plot(x, hcat(output.ANOX,); 
                      xlim = xlim, 
                      title = "ANOX", 
                      label = ["ANOX"],
                      legend = :topleft,)

            p06 = plot(x, hcat(output.pH,); 
                      xlim = xlim,  
                      title = "pH", 
                      label = ["pH"],
                      legend = :topleft,)

            p07 = plot(x, hcat(output.Omega,); 
                      xlim = xlim,  
                      title = "Omega", 
                      label = ["Omega"],
                      legend = :topleft,)

            fig = plot(
                p01, p02, p03, p04,
                p05, p06, p07;
                layout = (pager.nrows, pager.ncols),
                size = (1800, 900),
                left_margin = 2mm,                             
                right_margin = 2mm,                            
                top_margin = 2mm,                               
                bottom_margin = 2mm,                            
                plot_spacing = 2.0,                              
            )

        end

        # ---------------------------------------------------------------------
        # Page 04：Ocean ion concentrations
        # ---------------------------------------------------------------------
        if page == 4

            # ---- 第 1 行（4 张） ----
            p01 = plot(x, hcat(output.Mg_conc_mmolkgH2O,); 
                      xlim = xlim,  
                      title = "Mg_conc_mmolkgH2O", 
                      label = ["Mg_conc_mmolkgH2O"],
                      legend = :topleft,)

            p02 = plot(x, hcat(output.Ca_conc_mmolkgH2O,); 
                      xlim = xlim,
                      title = "Ca_conc_mmolkgH2O", 
                      label = ["Ca_conc_mmolkgH2O"],
                      legend = :topleft,)

            p03 = plot(x, hcat(output.S_conc_mmolkgH2O,); 
                      xlim = xlim,  
                      title = "S_conc_mmolkgH2O", 
                      label = ["S_conc_mmolkgH2O"],
                      legend = :topleft,)

            p04 = plot(x, hcat(output.Na_conc_mmolkgH2O,); 
                      xlim = xlim, 
                      title = "Na_conc_mmolkgH2O", 
                      label = ["Na_conc_mmolkgH2O"],
                      legend = :topleft,)
                      
            p05 = plot(x, hcat(output.K_conc_mmolkgH2O,); 
                      xlim = xlim, 
                      title = "K_conc_mmolkgH2O", 
                      label = ["K_conc_mmolkgH2O"],
                      legend = :topleft,)

            p06 = plot(x, hcat(output.Cl_conc_mmolkgH2O,); 
                      xlim = xlim, 
                      title = "Cl_conc_mmolkgH2O", 
                      label = ["Cl_conc_mmolkgH2O"],
                      legend = :topleft,)

            p07 = plot(x, hcat(output.TAlk_conc_mmolkgH2O,); 
                      xlim = xlim, 
                      title = "TAlk_conc_mmolkgH2O", 
                      label = ["TAlk_conc_mmolkgH2O"],
                      legend = :topleft,)

            p08 = plot(x, hcat(output.DIC_conc_mmolkgH2O,); 
                      xlim = xlim,  
                      title = "DIC_conc_mmolkgH2O", 
                      label = ["DIC_conc_mmolkgH2O"],
                      legend = :topleft,)

            p09 = plot(x, hcat(output.HCO3_conc_mmolkgH2O,); 
                      xlim = xlim,  
                      title = "HCO3_conc_mmolkgH2O", 
                      label = ["HCO3_conc_mmolkgH2O"],
                      legend = :topleft,)

            p10 = plot(x, hcat(output.CO3_conc_mmolkgH2O,); 
                      xlim = xlim,  
                      title = "CO3_conc_mmolkgH2O", 
                      label = ["CO3_conc_mmolkgH2O"],
                      legend = :topleft,)

            p11 = plot(x, hcat(output.CO2aq_conc_mmolkgH2O,); 
                      xlim = xlim,  
                      title = "CO2aq_conc_mmolkgH2O", 
                      label = ["CO2aq_conc_mmolkgH2O"],
                      legend = :topleft,)

            fig = plot(
                p01, p02, p03, p04,
                p05, p06, p07, p08,
                p09, p10, p11;
                layout = (pager.nrows, pager.ncols),
                size = (1800, 900),
                left_margin = 2mm,                             
                right_margin = 2mm,                            
                top_margin = 2mm,                               
                bottom_margin = 2mm,                           
                plot_spacing = 2.0,                              
            )

        end


        # ---------------------------------------------------------------------
        # Page 05：Carbon cycle
        # ---------------------------------------------------------------------
        if page == 5

            p01 = plot(x, hcat(output.granw_CO2, output.basw_CO2, output.silw_CO2,); 
                      xlim = xlim,  
                      title = "silicate weathering", 
                      label = ["granw_CO2" "basw_CO2" "silw_CO2"],
                      legend = :topleft,)

            p02 = plot(x, hcat(output.carbw_CO2,); 
                      xlim = xlim,
                      title = "carbw_CO2", 
                      label = ["carbw_CO2"],
                      legend = :topleft,)

            p03 = plot(x, hcat(output.ccdeg,); 
                      xlim = xlim,  
                      title = "ccdeg", 
                      label = ["ccdeg"],
                      legend = :topleft,)

            p04 = plot(x, hcat(output.sfwTotal_C,); 
                      xlim = xlim, 
                      title = "seafloor weathering", 
                      label = ["sfwTotal_C"],
                      legend = :topleft,)

            p05 = plot(x, hcat(output.mcb_total,); 
                      xlim = xlim, 
                      title = "mcb_total", 
                      label = ["mcb_total"],
                      legend = :topleft,)

            p06 = plot(x, hcat(output.ocdeg,); 
                      xlim = xlim, 
                      title = "ocdeg", 
                      label = ["ocdeg"],
                      legend = :topleft,)

            p07 = plot(x, hcat(output.oxidw,); 
                      xlim = xlim,  
                      title = "oxidw", 
                      label = ["oxidw"],
                      legend = :topleft,)
                      
            p08 = plot(x, hcat(output.mob_C,); 
                      xlim = xlim, 
                      title = "mob_C", 
                      label = ["mob_C"],
                      legend = :topleft,)

            p09 = plot(x, hcat(output.lob_C,); 
                      xlim = xlim,  
                      title = "lob_C", 
                      label = ["lob_C"],
                      legend = :topleft,)


            p10 = plot(x, hcat(output.f_airsea_CO2,); 
                      xlim = xlim,  
                      title = "f_airsea_CO2", 
                      label = ["f_airsea_CO2"],
                      legend = :topleft,)

            fig = plot(
                p01, p02, p03, p04,
                p05, p06, p07, p08,
                p09, p10;
                layout = (pager.nrows, pager.ncols),
                size = (1800, 900),
                left_margin = 2mm,                             
                right_margin = 2mm,                            
                top_margin = 2mm,                               
                bottom_margin = 2mm,                            
                plot_spacing = 2.0,                              
            )

        end


        # ---------------------------------------------------------------------
        # Page 6：Magnesium cycle
        # ---------------------------------------------------------------------
        if page == 6

            p01 = plot(x, hcat(output.granw_CO2_Mg,); 
                      xlim = xlim,  
                      title = "granw_CO2_Mg", 
                      label = ["granw_CO2_Mg"],
                      legend = :topleft,)

            p02 = plot(x, hcat(output.basw_CO2_Mg,); 
                      xlim = xlim,
                      title = "basw_CO2_Mg", 
                      label = ["basw_CO2_Mg"],
                      legend = :topleft,)

            p03 = plot(x, hcat(output.sfwMg,); 
                      xlim = xlim, 
                      title = "sfwMg", 
                      label = ["sfwMg"],
                      legend = :topleft,)

            p04 = plot(x, hcat(output.hyd_highT_Mg,); 
                      xlim = xlim, 
                      title = "hyd_highT_Mg", 
                      label = ["hyd_highT_Mg"],
                      legend = :topleft,)

            p05 = plot(x, hcat(output.hyd_lowT_Mg,); 
                      xlim = xlim, 
                      title = "hyd_lowT_Mg", 
                      label = ["hyd_lowT_Mg"],
                      legend = :topleft,)

            p06 = plot(x, hcat(output.carbw_CO2_Mg,); 
                      xlim = xlim, 
                      title = "carbw_CO2_Mg", 
                      label = ["carbw_CO2_Mg"],
                      legend = :topleft,)

            p07 = plot(x, hcat(output.dolo_sec,); 
                      xlim = xlim,  
                      title = "dolo_sec", 
                      label = ["dolo_sec"],
                      legend = :topleft,)
                      
            p08 = plot(x, hcat(output.delta_26_riv,); 
                      xlim = xlim,  
                      title = "delta_26_riv", 
                      label = ["delta_26_riv"],
                      legend = :topleft,)

            fig = plot(
                p01, p02, p03, p04,
                p05, p06, p07, p08;
                layout = (pager.nrows, pager.ncols),
                size = (1800, 900),
                left_margin = 2mm,                             
                right_margin = 2mm,                            
                top_margin = 2mm,                               
                bottom_margin = 2mm,                            
                plot_spacing = 2.0,                              
            )

        end

        # ---------------------------------------------------------------------
        # Page 7：Calcium cycle
        # ---------------------------------------------------------------------
        if page == 7

            p01 = plot(x, hcat(output.granw_CO2_Ca,); 
                      xlim = xlim,  
                      title = "granw_CO2_Ca", 
                      label = ["granw_CO2_Ca"],
                      legend = :topleft,)

            p02 = plot(x, hcat(output.basw_CO2_Ca,); 
                      xlim = xlim,
                      title = "basw_CO2_Ca", 
                      label = ["basw_CO2_Ca"],
                      legend = :topleft,)

            p03 = plot(x, hcat(output.carbw_CO2_Ca,); 
                      xlim = xlim,  
                      title = "carbw_CO2_Ca", 
                      label = ["carbw_CO2_Ca"],
                      legend = :topleft,)

            p04 = plot(x, hcat(output.gypw,); 
                      xlim = xlim,  
                      title = "gypw_Ca", 
                      label = ["gypw_Ca"],
                      legend = :topleft,)

            p05 = plot(x, hcat(output.sfwMg,); 
                      xlim = xlim, 
                      title = "sfwCa", 
                      label = ["sfwCa"],
                      legend = :topleft,)

            p06 = plot(x, hcat(output.hyd_highT_Ca,); 
                      xlim = xlim, 
                      title = "hyd_highT_Ca", 
                      label = ["hyd_highT_Ca"],
                      legend = :topleft,)

            p07 = plot(x, hcat(output.hyd_lowT_Ca,); 
                      xlim = xlim, 
                      title = "hyd_lowT_Ca", 
                      label = ["hyd_lowT_Ca"],
                      legend = :topleft,)
                      
            p08 = plot(x, hcat(output.dolo_sec,); 
                      xlim = xlim,  
                      title = "dolo_sec", 
                      label = ["dolo_sec"],
                      legend = :topleft,)

            p09 = plot(x, hcat(output.mgb,); 
                      xlim = xlim,  
                      title = "mgb", 
                      label = ["mgb"],
                      legend = :topleft,)

            p10 = plot(x, hcat(output.mcb_total,); 
                      xlim = xlim,  
                      title = "mcb_total", 
                      label = ["mcb_total"],
                      legend = :topleft,)

            fig = plot(
                p01, p02, p03, p04,
                p05, p06, p07, p08,
                p09, p10;
                layout = (pager.nrows, pager.ncols),
                size = (1800, 900),
                left_margin = 2mm,                             
                right_margin = 2mm,                            
                top_margin = 2mm,                               
                bottom_margin = 2mm,                            
                plot_spacing = 2.0,                              
            )

        end

        # ---------------------------------------------------------------------
        # Page 8：Sulfur cycle
        # ---------------------------------------------------------------------
        if page == 8

            p01 = plot(x, hcat(output.pyrw,); 
                      xlim = xlim,  
                      title = "pyrw", 
                      label = ["pyrw"],
                      legend = :topleft,)

            p02 = plot(x, hcat(output.pyrdeg,); 
                      xlim = xlim,
                      title = "pyrdeg", 
                      label = ["pyrdeg"],
                      legend = :topleft,)

            p03 = plot(x, hcat(output.gypw,); 
                      xlim = xlim,  
                      title = "gypw", 
                      label = ["gypw"],
                      legend = :topleft,)

            p04 = plot(x, hcat(output.gypdeg,); 
                      xlim = xlim,  
                      title = "gypdeg", 
                      label = ["gypdeg"],
                      legend = :topleft,)

            p05 = plot(x, hcat(output.mpb_S,); 
                      xlim = xlim,  
                      title = "mpb_S", 
                      label = ["mpb_S"],
                      legend = :topleft,)

            p06 = plot(x, hcat(output.mgb,); 
                      xlim = xlim, 
                      title = "mgb", 
                      label = ["mgb"],
                      legend = :topleft,)
                      

            fig = plot(
                p01, p02, p03, p04,
                p05, p06;
                layout = (pager.nrows, pager.ncols),
                size = (1800, 900),
                left_margin = 2mm,                            
                right_margin = 2mm,                           
                top_margin = 2mm,                               
                bottom_margin = 2mm,                            
                plot_spacing = 2.0,                              
            )

        end

        # ---------------------------------------------------------------------
        # Page 9：Sodium cycle
        # ---------------------------------------------------------------------
        if page == 9


            p01 = plot(x, hcat(output.granw_CO2_Na,); 
                      xlim = xlim,  
                      title = "granw_CO2_Na", 
                      label = ["granw_CO2_Na"],
                      legend = :topleft,)

            p02 = plot(x, hcat(output.basw_CO2_Na,); 
                      xlim = xlim,
                      title = "basw_CO2_Na", 
                      label = ["basw_CO2_Na"],
                      legend = :topleft,)

            p03 = plot(x, hcat(output.rw_Na,); 
                      xlim = xlim,  
                      title = "rw_Na", 
                      label = ["rw_Na"],
                      legend = :topleft,)

            p04 = plot(x, hcat(output.hyd_highT_Na,); 
                      xlim = xlim, 
                      title = "hyd_highT_Na", 
                      label = ["hyd_highT_Na"],
                      legend = :topleft,)

            p05 = plot(x, hcat(output.NaClw,); 
                      xlim = xlim,  
                      title = "NaClw", 
                      label = ["NaClw"],
                      legend = :topleft,)

            p06 = plot(x, hcat(output.NaClb,); 
                      xlim = xlim, 
                      title = "NaClb", 
                      label = ["NaClb"],
                      legend = :topleft,)

            p07 = plot(x, hcat(output.Exb_Na,); 
                      xlim = xlim, 
                      title = "Exb_Na", 
                      label = ["Exb_Na"],
                      legend = :topleft,)

            p08 = plot(x, hcat(output.Exr_Na,); 
                      xlim = xlim, 
                      title = "Exr_Na", 
                      label = ["Exr_Na"],
                      legend = :topleft,)
                      
            p09 = plot(x, hcat(output.Exd_Na,); 
                      xlim = xlim,  
                      title = "Exd_Na", 
                      label = ["Exd_Na"],
                      legend = :topleft,)

            fig = plot(
                p01, p02, p03, p04,
                p05, p06, p07, p08,
                p09;
                layout = (pager.nrows, pager.ncols),
                size = (1800, 900),
                left_margin = 2mm,                             
                right_margin = 2mm,                            
                top_margin = 2mm,                               
                bottom_margin = 2mm,                            
                plot_spacing = 2.0,                              
            )

        end

        # ---------------------------------------------------------------------
        # Page 10：potassium cycle
        # ---------------------------------------------------------------------
        if page == 10


            p01 = plot(x, hcat(output.granw_CO2_K,); 
                      xlim = xlim,  
                      title = "granw_CO2_K", 
                      label = ["granw_CO2_K"],
                      legend = :topleft,)

            p02 = plot(x, hcat(output.basw_CO2_K,); 
                      xlim = xlim,
                      title = "basw_CO2_K", 
                      label = ["basw_CO2_K"],
                      legend = :topleft,)

            p03 = plot(x, hcat(output.rw_K,); 
                      xlim = xlim,  
                      title = "rw_K", 
                      label = ["rw_K"],
                      legend = :topleft,)

            p04 = plot(x, hcat(output.hyd_highT_K,); 
                      xlim = xlim,  
                      title = "hyd_highT_K", 
                      label = ["hyd_highT_K"],
                      legend = :topleft,)

            p05 = plot(x, hcat(output.KClw,); 
                      xlim = xlim,  
                      title = "KClw", 
                      label = ["KClw"],
                      legend = :topleft,)

            p06 = plot(x, hcat(output.KClb,); 
                      xlim = xlim, 
                      title = "KClb", 
                      label = ["KClb"],
                      legend = :topleft,)


            fig = plot(
                p01, p02, p03, p04,
                p05, p06;
                layout = (pager.nrows, pager.ncols),
                size = (1800, 900),
                left_margin = 2mm,                             
                right_margin = 2mm,                            
                top_margin = 2mm,                               
                bottom_margin = 2mm,                            
                plot_spacing = 2.0,                              
            )

        end

        # ---------------------------------------------------------------------
        # Page 11：Strontium cycle
        # ---------------------------------------------------------------------
        if page == 11

            p01 = plot(x, hcat(output.granw_CO2_Sr,); 
                      xlim = xlim,  
                      title = "granw_CO2_Sr", 
                      label = ["granw_CO2_Sr"],
                      legend = :topleft,)

            p02 = plot(x, hcat(output.basw_CO2_Sr,); 
                      xlim = xlim,
                      title = "basw_CO2_Sr", 
                      label = ["basw_CO2_Sr"],
                      legend = :topleft,)

            p03 = plot(x, hcat(output.carbw_CO2_Sr,); 
                      xlim = xlim,  
                      title = "carbw_CO2_Sr", 
                      label = ["carbw_CO2_Sr"],
                      legend = :topleft,)

            p04 = plot(x, hcat(output.hyd_highT_Sr,); 
                      xlim = xlim,  
                      title = "hyd_highT_Sr", 
                      label = ["hyd_highT_Sr"],
                      legend = :topleft,)

            p05 = plot(x, hcat(output.hyd_lowT_Sr,); 
                      xlim = xlim, 
                      title = "hyd_lowT_Sr", 
                      label = ["hyd_lowT_Sr"],
                      legend = :topleft,)

            p06 = plot(x, hcat(output.mcb_Sr,); 
                      xlim = xlim, 
                      title = "mcb_Sr", 
                      label = ["mcb_Sr"],
                      legend = :topleft,)

            p07 = plot(x, hcat(output.sfwTotal_Sr,); 
                      xlim = xlim, 
                      title = "sfwTotal_Sr", 
                      label = ["sfwTotal_Sr"],
                      legend = :topleft,)


            fig = plot(
                p01, p02, p03, p04,
                p05, p06, p07;
                layout = (pager.nrows, pager.ncols),
                size = (1800, 900),
                left_margin = 2mm,                            
                right_margin = 2mm,                            
                top_margin = 2mm,                               
                bottom_margin = 2mm,                            
                plot_spacing = 2.0,                              
            )

        end

        # ---------------------------------------------------------------------
        # Page 12：Uranium cycle
        # ---------------------------------------------------------------------
        if page == 12

            p01 = plot(x, hcat(output.granw_CO2_U,); 
                      xlim = xlim,  
                      title = "granw_CO2_U", 
                      label = ["granw_CO2_U"],
                      legend = :topleft,)

            p02 = plot(x, hcat(output.basw_CO2_U,); 
                      xlim = xlim,
                      title = "basw_CO2_U", 
                      label = ["basw_CO2_U"],
                      legend = :topleft,)

            p03 = plot(x, hcat(output.anoxic_U,); 
                      xlim = xlim,  
                      title = "anoxic_U", 
                      label = ["anoxic_U"],
                      legend = :topleft,)

            p04 = plot(x, hcat(output.other_U,); 
                      xlim = xlim,  
                      title = "other_U", 
                      label = ["other_U"],
                      legend = :topleft,)

            p05 = plot(x, hcat(output.hyd_highT_U,); 
                      xlim = xlim, 
                      title = "hyd_highT_U", 
                      label = ["hyd_highT_U"],
                      legend = :topleft,)

            p06 = plot(x, hcat(output.hyd_lowT_U,); 
                      xlim = xlim, 
                      title = "hyd_lowT_U", 
                      label = ["hyd_lowT_U"],
                      legend = :topleft,)


            fig = plot(
                p01, p02, p03, p04,
                p05, p06;
                layout = (pager.nrows, pager.ncols),
                size = (1800, 900),
                left_margin = 2mm,                             
                right_margin = 2mm,                            
                top_margin = 2mm,                               
                bottom_margin = 2mm,                            
                plot_spacing = 2.0,                              
            )

        end

        # ---------------------------------------------------------------------
        # Page 13：marine carbonate factory
        # ---------------------------------------------------------------------
        if page == 13

            p01 = plot(x, hcat(output.mcb_total,); 
                      xlim = xlim,  
                      title = "mcb_total", 
                      label = ["mcb_total"],
                      legend = :topleft,)

            p02 = plot(x, hcat(output.pelagic_mcb,); 
                      xlim = xlim,
                      title = "pelagic_mcb", 
                      label = ["pelagic_mcb"],
                      legend = :topleft,)

            p03 = plot(x, hcat(output.shelf_mcb_arag,); 
                      xlim = xlim,  
                      title = "shelf_mcb_arag", 
                      label = ["shelf_mcb_arag"],
                      legend = :topleft,)

            p04 = plot(x, hcat(output.shelf_mcb_calc,); 
                      xlim = xlim,  
                      title = "shelf_mcb_calc", 
                      label = ["shelf_mcb_calc"],
                      legend = :topleft,)

            fig = plot(
                p01, p02, p03, p04;
                layout = (pager.nrows, pager.ncols),
                size = (1800, 900),
                left_margin = 2mm,                             
                right_margin = 2mm,                            
                top_margin = 2mm,                               
                bottom_margin = 2mm,                            
                plot_spacing = 2.0,                              
            )

        end


        if fig === nothing

            @warn "No figure is defined for this page number in plot_singlerun.jl" page=page

            continue

        end

        push!(figs, fig)

        if save_pdf == true

            mkpath(pdf_dir)
            pdf_file = joinpath(pdf_dir, string(pdf_prefix, "_page_", page, ".pdf"))
            savefig(fig, pdf_file)

        end

        if show

            display(fig)

        end

    end

    return figs

end
