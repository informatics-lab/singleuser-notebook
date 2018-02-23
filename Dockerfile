FROM jupyter/scipy-notebook:92fe05d1e7e5

#####################################################################
# Root                                                              #
#####################################################################

USER root

# Install system packages
RUN apt-get update -y && apt-get install -y libfuse-dev graphviz

# Install jupyter server extentions
RUN pip install git+https://github.com/jupyterhub/nbserverproxy
RUN jupyter serverextension enable --py nbserverproxy --sys-prefix --system
RUN jupyter labextension install @jupyterlab/hub-extension


#####################################################################
# User                                                              #
#####################################################################

USER jovyan

# Install extra Python 3 packages
RUN conda install -y -c conda-forge -c scitools -c bioconda iris cartopy dask distributed jupyter_contrib_nbextensions jupyter_dashboards nbpresent fusepy boto3 && conda clean --tarballs -y
RUN pip install --upgrade git+https://github.com/met-office-lab/jade_utils daskernetes

# Install R
RUN conda install -y -c r r-essentials && conda clean --tarballs -y
