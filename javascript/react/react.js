const PubSub = {
  use() {
    Object.assign(this, { subscribers: [] });
    return this;
  },
  addSubscriber(s) {
    this.subscribers.push(s);
    return this;
  },

  notify() {
    this.subscribers.forEach(s => {
      s.markForUpdate();
    });
    this.subscribers.forEach(s => {
      s.update();
    });
  }
};

export class InputCell {
  constructor(value) {
    PubSub.use.call(this);
    Object.assign(this, { value });
  }

  setValue(value) {
    if (value !== this.value) {
      Object.assign(this, { value });
      this.notify();
    }
  }

  notify() {
    PubSub.notify.call(this);
  }

  addSubscriber(s) {
    PubSub.addSubscriber.call(this, s);
  }
}

export class ComputeCell {
  constructor(cells, mapper) {
    cells.forEach(cell => {
      cell.addSubscriber(this);
    });

    PubSub.use.call(this);

    const value = mapper(cells);
    Object.assign(this, {
      cells,
      mapper,
      isStale: false,
      value,
      lastValue: value,
      callbacks: []
    });
  }

  update() {
    const value = this.mapper(this.cells);
    if (value !== this.value) {
      Object.assign(this, { value, isStale: false });
      this.notify();
      this.runCallbacks();
    }
  }

  markForUpdate() {
    Object.assign(this, { isStale: true });
    this.notify();
  }

  notify() {
    PubSub.notify.call(this);
  }

  runCallbacks() {
    if (this.isStable && this.hasChanged) {
      this.lastValue = this.value;
      this.callbacks.forEach(cb => {
        cb.call(this);
      });
    }
  }

  addSubscriber(s) {
    PubSub.addSubscriber.call(this, s);
  }

  addCallback(cb) {
    this.callbacks.push(cb);
  }

  removeCallback(cb) {
    Object.assign(this, {
      callbacks: this.callbacks.filter(callback => callback !== cb)
    });
  }

  get isStable() {
    return this.cells.every(({ isStale }) => !isStale);
  }

  get hasChanged() {
    return this.lastValue !== this.value;
  }
}

export class CallbackCell {
  constructor(fn) {
    Object.assign(this, { fn, values: [] });
  }

  call(value) {
    return this.values.push(this.fn(value));
  }
}
