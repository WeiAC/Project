function Balances(dx,x,problem,t)

    # alias -
    protein = x[1]
    G = x[2]
    ribosome = x[3]

    # calculate kinetics -
    translation_kinetics = calculate_translation_kinetics(t,x,problem)
    degradation_kinetics = calculate_protein_degradation_kinetics(t,x,problem)

    # compute the control -
    u_variable = calculate_translational_control_array(t,x,problem)

    # compute the material balances -
    dx[1] = translation_kinetics*u_variable - degradation_kinetics    # protein balances
    dx[2] = 0   # G
    dx[3] = 0   # ribosome
end