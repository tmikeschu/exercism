export default class Gigasecond {
  private input: Date;
  constructor(input: Date) {
    this.input = input;
  }

  public date(): Date {
    return new Date(this.input.getTime() + Math.pow(10, 9) * 1000);
  }
}
