export interface ITest {
    test(): string;
}
export declare class MyTest implements ITest {
    private t;
    constructor(test: string);
    test(): string;
}
