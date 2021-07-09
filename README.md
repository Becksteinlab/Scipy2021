# Scipy2021: MPI-parallel Molecular Dynamics Trajectory Analysis with the H5MD Format in the MDAnalysis Python Package
[![DOI](https://zenodo.org/badge/339555913.svg)](https://zenodo.org/badge/latestdoi/339555913)

Data and supplementary information for the paper

* Edis Jakupovic and Oliver Beckstein, “[MPI-parallel Molecular Dynamics Trajectory Analysis with the H5MD Format in the MDAnalysis Python Package](http://conference.scipy.org/proceedings/scipy2021/edis_jakupovic.html),” in Proceedings of the 20th Python in Science Con- ference (Meghann Agarwal, Chris Calloway, Dillon Niederhut, and David Shupe, eds.), pp. 18 – 26, 2021. DOI: To be added.


Short Summary
-------------

MDAnalysis is a Python library for the analysis of molecular dynamics simulations. As datafiles are now typically terabytes in size, file I/O has become a bottleneck in the workflow of analyzing simulation trajectories. We have implemented an HDF5-based file format trajectory reader into MDAnalysis that can perform parallel MPI IO and benchmarked it on various national HPC environments. Although speed-ups on the order of 20x for 48 cores are attainable, scaling up to achieve higher parallel data ingestion rates remains challenging. We developed several algorithmic optimizations in our analysis workflows that lead to improvements in IO times of up to 91x on 112 cores.


Abstract
--------

MDAnalysis is a widely used Python library that can read and write over 20 popular MD file formats while providing the same user-friendly interface [Gowers2016]. As HPC resources continue to increase, the size of molecular dynamics (MD) simulation files are now commonly terabytes in size, making serial analysis of these trajectory files impractical. Parallel analysis is a necessity for the efficient use of both HPC resources and a scientist’s time. Previous work that focused on developing a task-based approach to parallel analysis found that an IO bound task only scaled to 12 cores due to a file IO bottleneck [Fan2019]. Our previous feasibility study suggested that parallel reading via MPI-IO and HDF5 can lead to good scaling although it only used a reduced size custom HDF5 trajectory and did not provide a usable implementation of a true MD trajectory reader [Khoshlessan2020]. We have implemented a parallel MPI-IO capable HDF5-based file format trajectory reader into MDAnalysis, H5MDReader, that adheres to H5MD (HDF5 for Molecular Dynamics) specifications [Buyl2013]. We benchmarked its parallel file reading capabilities on three HPC clusters: ASU Agave, SDSC Comet, and PSC Bridges. The benchmark consisted of a simple split-apply-combine scheme of an IO bound task that split a 90k frame (113GB) trajectory into n chunks for n processes, where each process performed an RMSD calculation on their chunk of data, and then gathered the results back to the root process. We found maximum IO speedups at 2 full nodes, with Agave showing 20x, while Bridges and Comet capped out at 4-5x speedup. On the other hand, the computation time of the RMSD calculation scaled well on all three HPC resources, with a maximum speedup on Comet of 373x on 384 cores. Therefore, for a compute bound task, our implementation would likely scale very well, however the file IO still seems to impose a bottleneck on the total scaling for the IO bound task. This could be due to MPI ranks competing for file access, or filesystem bandwidth issues that a large scale HPC environment faces. To investigate MPI rank competition, we increased the stripe count on Bridge’s and Comet’s Lustre filesystem up to 96. We found marginal IO scaling improvements of 1.2x on up to 4 full nodes. To investigate how file size impacts IO scaling, we performed the same benchmark on a smaller version of the trajectory file which resulted in speedups on Agave of up to 95x on 6 nodes and 140 cores, which indicates that IO speedup is greatly impacted by file size. Following this result, we implemented a feature into the H5MDReader where only the necessary coordinates for the computation task are read from the file, which resulted in a fixed improvement of approximately 5x on all three HPCs. Furthermore, we investigated how frontloading all the file IO by loading the trajectory into memory prior to the computation, rather than iterating through each timestep, affected the IO performance. This resulted in an improvement on Agave of up to 10x on up to 112 cores. Using these optimizations, our best-case IO speedup with respect to baseline performance was 91x on 112 cores on Agave.  The addition of the HDF5 reader provides a foundation for the development of parallel trajectory analysis with MPI and the MDAnalysis package.


Keywords
--------
HDF5, H5MD, MPI I/O, MDAnalysis, High Performance Computing


References
----------

[Buyl2013] P. Buyl, P. Colberg, and Felix Höfling. "H5MD: A structured, efficient, and portable file format for molecular data," Computer Physics Communications, 185, 2013 doi:10.1016/j.cpc.2014.01.018.

[Gowers2016] R. J. Gowers, M. Linke, J. Barnoud, T. J. E. Reddy, M. N. Melo, S. L. Seyler, D. L. Dotson, J. Domański, S. Buchoux, I. M. Kenney, and O. Beckstein, “MDAnalysis: A Python package for the rapid analysis of molecular dynamics simulations,” in Proceedings of the 15th Python in Science Conference (S. Benthall and S. Rostrup, eds.), (Austin, TX), pp. 98–105, SciPy, 2016. doi:10.25080/Majora-629e541a-00e

[Fan2019] S. Fan, M. Linke, I. Paraskevakos, R. J. Gowers, M. Gecht, and O. Beckstein, “PMDA - Parallel Molecular Dynamics Analysis,” in Proceedings of the 18th Python in Science Conference (Chris Calloway, David Lippa, Dillon Niederhut, and David Shupe, eds.), (Austin, TX), pp. 134 – 142, SciPy, 2019. doi:10.25080/Majora-7ddc1dd1-013

[Khoshlessan2020] M. Khoshlessan, I. Paraskevakos, G. C. Fox, S. Jha, and O. Beckstein, “Parallel performance of molecular dynamics trajectory analysis,” Concurrency and Computation: Practice and Experience, vol. 32, p. e5789, 2020. doi:10.1002/cpe.5789

