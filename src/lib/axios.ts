import axios, {AxiosResponse} from 'axios';
import {createWriteStream} from 'fs';
import * as stream from 'stream';
import {promisify} from 'util';

export const download = async (url: string, to: string): Promise<void> => {
  await axios
    .request({
      method: 'get',
      url,
      responseType: 'stream',
    })
    .then((response: AxiosResponse) => {
      const writer = createWriteStream(to);
      response.data.pipe(writer);
      return promisify(stream.finished)(writer);
    });
};
