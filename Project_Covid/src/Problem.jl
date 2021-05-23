function generate_problem_dictionary(path_to_parameters_file::String)::Dict{String,Any}

    # initialize -
    problem_dictionary = Dict{String,Any}()

    try

        # load the TOML parameters file -
        toml_dictionary = TOML.parsefile(path_to_parameters_file)["biophysical_constants"]
        COVIDssRNA_conc = toml_dictionary["COVIDssRNA_conc"]
        # setup the initial condition array -
        initial_condition_array = [
            0.0 ;   # 1 protein
            COVIDssRNA_conc ;   # TODO: gene concentration goes here -
    0.0 ;   # 3 I = we'll fill this in the execute script 
        ]


        # TODO: calculate the mRNA_degradation_constant (Garamella et al (2016) ACS Synth Biol 15:344-55)
        protein_degradation_constant = log(2)/toml_dictionary["protein_half_life_in_sec"]

        # TODO: VMAX for transcription (Adhikari et al (2020) Front. Bioeng. Biotechnol.)
        #RNAPII_concentration = toml_dictionary["RNAPII_concentration"]
        #transcription_elongation_rate = toml_dictionary["transcription_elongation_rate"]
        #gene_length_in_nt = toml_dictionary["gene_length_in_nt"]
        #VMAX = RNAPII_concentration*(transcription_elongation_rate/gene_length_in_nt)
        #RdRP_genelength = toml_dictionary["RdRP_genelength"]
        
        Ribosome_conc = toml_dictionary["Ribosome_conc"]
        translation_elongation_rate = toml_dictionary["translation_elongation_rate"]
        RdRP_proteinlength = toml_dictionary["RdRP_proteinlength"]
        polysome_amplification_constant = toml_dictionary["polysome_amplification_constant"]
        VMAX = polysome_amplification_constant*Ribosome_conc*(translation_elongation_rate/RdRP_proteinlength)
        # TODO: Stuff that I'm forgetting?
        # ...

        # --- PUT STUFF INTO problem_dictionary ---- 
        problem_dictionary["translation_time_constant"] = toml_dictionary["translation_time_constant"]
        problem_dictionary["translation_saturation_constant"] = toml_dictionary["translation_saturation_constant"]
        problem_dictionary["E1"] = toml_dictionary["energy_promoter_state_1"]
        #problem_dictionary["E2"] = toml_dictionary["energy_promoter_state_2"]
        #problem_dictionary["inducer_dissociation_constant"] = toml_dictionary["inducer_dissociation_constant"]
        #problem_dictionary["inducer_cooperativity_parameter"] = toml_dictionary["inducer_cooperativity_parameter"]
        problem_dictionary["ideal_gas_constant_R"] = 0.008314 # kJ/mol-K
        problem_dictionary["temperature_K"] = (273.15+37)
        problem_dictionary["initial_condition_array"] = initial_condition_array

        # TODO: If we want to use a value later e.g., VMAX or mRNA_degradation_constant you need to put them in the Dictionary
        problem_dictionary["protein_degradation_constant"] = protein_degradation_constant
        problem_dictionary["maximum_translation_velocity"] = VMAX
        problem_dictionary["translation_elongation_rate"] = toml_dictionary["translation_elongation_rate"]
        problem_dictionary["RdRP_genelength"] = toml_dictionary["RdRP_genelength"]
        problem_dictionary["Ribosome_conc"] = toml_dictionary["Ribosome_conc"]
        problem_dictionary["translation_time_constant"] = toml_dictionary["translation_time_constant"]
        problem_dictionary["COVIDssRNA_conc"] = toml_dictionary["COVIDssRNA_conc"]

        # return -
        return problem_dictionary
    catch error
        throw(error)
    end
end