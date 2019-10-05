export interface ITest {
  test(): string
}

export class MyTest implements ITest {
  private t: string

  constructor(test: string) {
    this.t = test
  }

  public test(): string {
    return this.t
  }
}
