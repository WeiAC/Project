
function calculate_translational_control_array(t::Float64,x::Array{Float64,1}, problem::Dict{String,Any})::Float64

    # initialize -
    u_variable = 0.0
    
    # alias elements of the species vector -
    protein = x[1]
    G = x[2]
    ribosome = x[3]

    # get stuff from the problem dictionary -
    E1 = problem["E1"]
    #E2 = problem["E2"]
    R = problem["ideal_gas_constant_R"]
    T_K = problem["temperature_K"]
    #KD = problem["inducer_dissociation_constant"]
    #n = problem["inducer_cooperativity_parameter"]
    W1 = exp(-E1/(R*T_K))
    #W2 = exp(-E2/(R*T_K))
    # TODO: write u-varible function here 
    u_variable = (W1)/(1+W1)

    # return -
    return u_variable
end