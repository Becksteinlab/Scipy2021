import MDAnalysis as mda
import pyh5md


def create_test_trj(uni, filename):
    """uses pyh5md library to write h5md file"""

    with pyh5md.File(filename, 'w', creator='dcd_to_h5md.py') as f:
        trajectory = f.particles_group('trajectory')
        obsv = f.require_group('observables')

        ag = uni.select_atoms("(resid 1:29 or resid 60:121 or resid 160:214) and name CA")
        indices = ag.indices

        positions = pyh5md.element(trajectory, 'position', store='time',
                                   data=uni.trajectory.ts.positions[indices],
                                   time=True)
        f['particles/trajectory/position/value'].attrs['unit'] = 'Angstrom'
        f['particles/trajectory/position/time'].attrs['unit'] = 'ps'

        data_step = pyh5md.element(obsv, 'step',
                                   data=uni.trajectory.ts.data['step'],
                                   step_from=positions,
                                   store='time', time=True)
        data_dt = pyh5md.element(obsv, 'dt',
                                   data=uni.trajectory.ts.data['dt'],
                                   step_from=positions,
                                   store='time', time=True)

        trajectory.create_box(dimension=3,
                              boundary=['periodic', 'periodic', 'periodic'],
                              store='time',
                              data=uni.trajectory.ts.triclinic_dimensions,
                              step_from=positions)
        f['particles/trajectory/box/edges/value'].attrs['unit'] = 'Angstrom'

        for ts in uni.trajectory:
            trajectory.box.edges.append(ts.triclinic_dimensions,
                                        ts.frame, time=ts.time)
            positions.append(ts.positions[indices],
                             ts.frame, time=ts.time)
            data_step.append(ts.data['step'],
                             ts.frame, time=ts.time)
            data_dt.append(ts.data['dt'],
                             ts.frame, time=ts.time)



def main():
    top = '/oasis/projects/nsf/azs119/edisj/Comet/datafiles/adk4AKE.psf'
    traj = '/oasis/projects/nsf/azs119/edisj/Comet/datafiles/xtc600x.xtc'

    u = mda.Universe(top, traj)
    create_test_trj(u, '/oasis/projects/nsf/azs119/edisj/Comet/datafiles/small_traj.h5md')


if __name__ == '__main__':
    main()
