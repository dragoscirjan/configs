from setuptools import setup, find_packages

VERSION = (0, 0, 1, 'alpha', 0)

f = open('README.md', 'r')
LONG_DESCRIPTION = f.read()
f.close()

setup(
    name='python-template',
    version=VERSION,
    description='Template for Python Apps',
    long_description='',
    long_description_content_type='text/markdown',
    author='Dragos Cirjan',
    author_email='dragos.cirjan@gmail.com',
    url='https://github.com/dragoscirjan/configs/code-templates/python',
    license='MIT',
    packages=find_packages(exclude=['ez_setup', 'tests*']),
    package_data={'python-template': ['templates/*']},
    include_package_data=True,
    entry_points="""
        [console_scripts]
        python-template = python-template.main:main
    """,
)
