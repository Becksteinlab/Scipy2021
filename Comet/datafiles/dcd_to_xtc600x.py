import MDAnalysis as mda


top = '/oasis/projects/nsf/azs119/edisj/Comet/datafiles/adk4AKE.psf'
traj = '/oasis/projects/nsf/azs119/edisj/Comet/datafiles/1ake_007-nowater-core-dt240ps.dcd'

u = mda.Universe(top, 600*[traj])

with mda.Writer("xtc600x.xtc", u.trajectory.ts.n_atoms) as W:
    for ts in u.trajectory:
        W.write(u)
