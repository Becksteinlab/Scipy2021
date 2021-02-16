# Scipy2021


Short Summary
-------------

MDAnalysis is a widely used Python library for the analysis of molecular dynamics simulations. As the size of the data files from these simulations is now commonly on the order of terabytes, file I/O has become a bottleneck in the workflow of analyzing simulation trajectories. We have implemented an HDF5-based file format trajectory reader into MDAnalysis that can perform parallel MPI I/O and benchmarked it on various national HPC environments. While we have not yet achieved strong scaling I/O performance, we have found several I/O optimization techniques that lead to fixed improvements in performance.


Abstract
--------

MDAnalysis is a widely used Python library that streamlines the analysis of MD trajectories in that it can read and write over 20 popular MD file formats, but provides the same user-friendly interface no matter the file format [citation]. As HPC resources continue to increase, the size of molecular dynamics (MD) simulation files are now commonly on the order of terabytes. Serial analysis of these trajectory files is becoming impractical, as it can take up to a week to perform a single analysis, making parallel analysis a necessity for the efficient use of both HPC resources and a scientist’s time. Previous work has focused on developing a task-based approach to parallel analysis using the Dask library, however IO-bound tasks such as an RMSD calculation did not scale well in an HPC environment due to a file IO bottleneck [citation]. A previous feasibility study showed that parallel IO via MPI-IO and HDF5 led to near ideal scaling on SDSC’s Comet on up to 384 cores, however it did not provide a usable implementation of a true MD trajectory format. We have implemented a parallel MPI-IO capable HDF5-based file format trajectory reader into MDAnalysis, H5MDReader, that adheres to H5MD (HDF5 for Molecular Dynamics) specifications [citation]. Our initial benchmarks showed that, in serial, our H5MDReader performed equally well to the reference reader, pyh5md, and was comparable to the XTC format [citation]. We benchmarked our reader on three HPC clusters: ASU’s Agave, SDSC’s Comet, and PSC’s Bridges. The benchmark consisted of a simple split-apply-combine scheme that split a 90k frame (113GB) trajectory into n chunks for n processes, where each process individually performed an RMSD calculation on their chunk of data, and then gathered the results back to the root process. The results show poor IO scaling on all three HPC resources. To assess whether the poor scaling was a function of MDAnalysis overhead, we also performed the same benchmark with h5py directly accessing the HDF5 file, which resulted in the same poor IO scaling. This indicates that, for any improvements to be made to the IO scaling, it must occur at the h5py level or lower. We are currently investigating how MPI optimizations done at the filesystem level affect the IO performance. Additionally, we have used three optimization techniques to improve the analysis time: file striping, loading the entire trajectory into memory prior to analysis, and only reading the subset of data required for the RMSD calculation rather than the entire trajectory via NumPy masked arrays. All three methods resulted in substantial fixed improvements in analysis times, however the IO scaling showed similar performance. Loading the trajectory into memory resulted in the added benefit of eliminating the “straggler” problem, in that all processes performed their block analysis is approximately the same time. While strong scaling performance has not yet been achieved, the addition of the HDF5 reader provides a foundation for the development of parallel trajectory analysis with MPI and the MDAnalysis package.


Keywords
--------
HDF5, H5MD, MPI I/O, MDAnalysis, High Performance Computing


References
----------
