function calculate_translation_kinetics(t::Float64, x::Array{Float64,1}, problem::Dict{String,Any})::Float64

    # initailzie -
    translation_rate = 0.0
    
    # alias -
    protein = x[1]
    G = x[2]
    ribosome = x[3]

    # get parameters from problem dictionary -
    KL = problem["translation_saturation_constant"]
    tau_L = problem["translation_time_constant"]
    Vmax_L = problem["maximum_translation_velocity"]
    COVIDssRNA_conc = problem["COVIDssRNA_conc"]

    # TODO: compute the transcription rate -
    translation_rate = Vmax_L*(COVIDssRNA_conc/(tau_L*KL)+(tau_L+1)*COVIDssRNA_conc)

    
    # return -
    return translation_rate
end

function calculate_protein_degradation_kinetics(t::Float64, x::Array{Float64,1}, problem::Dict{String,Any})::Float64

    # alias -
    protein = x[1]
    G = x[2]
    ribosome = x[3]
    
    # get the mRNA degradation constant -
    protein_degradation_constant = problem["protein_degradation_constant"]

    # return -
    return (protein_degradation_constant*protein)
end