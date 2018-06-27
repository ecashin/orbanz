FROM ecashin/gpytorch

COPY . /context

RUN pip install --upgrade pip && \
  pip install \
  git+git://github.com/probtorch/probtorch

EXPOSE 8000