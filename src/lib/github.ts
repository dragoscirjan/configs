import axios from 'axios';
import {logger} from './logger';

export type GithubRelease = {
  tag_name: string;
};

export const githubListReleases = async (
  project: string,
  {filter, latest}: {filter?: string; latest?: boolean},
): Promise<string[]> => {
  try {
    // GitHub API endpoint to list releases
    const url = `https://api.github.com/repos/${project}/releases`;

    // Make GET request to GitHub API
    let filteredReleases = await axios.get(url).then((response) => response.data);

    // Filter releases based on the filter string
    if (filter) {
      filteredReleases = filteredReleases.filter((release: GithubRelease) => release.tag_name.includes(filter));
    }

    // If latest is true, get only the latest release
    if (latest) {
      filteredReleases = [filteredReleases[0]];
    }

    // Extract version from each release and return as an array
    return filteredReleases
      .map((release: GithubRelease) => release.tag_name)
      .map((version: string) => /\d*\.\d*\.\d*/.exec(version)?.[0]);
  } catch (error: any) {
    logger.error(`Error fetching GitHub releases: ${error}`, error.stack ? error.stack : []);
    process.exit(1);
  }
};
