import { create } from 'zustand'
import { Coffee } from '../data/coffees'

type Order = {
  coffee: Coffee,
  amount: number,
}

interface OrderState {
  orders: Order[],
  orderCoffee: (coffee: Coffee) => void,
  resetOrders: () => void,
}

export const useOrderStore = create<OrderState>()((set) => ({
  orders: [],
  orderCoffee: (coffee) => set((state) => {
    const coffeeIndex = state.orders.findIndex((order) => order.coffee.id === coffee.id);
    const coffeeHasAlreadyBeenOrdered = coffeeIndex !== -1;
    if (coffeeHasAlreadyBeenOrdered) {
      return {
        orders: state.orders.map((order, index) => {
          if (index === coffeeIndex) {
            return {
              ...order,
              amount: order.amount + 1,
            }
          }
          return order;
        })
      };
    }
    return {
      orders: [
        ...state.orders,
        {
          coffee,
          amount: 1,
        }
      ]
    };
  }),
  resetOrders: () => set(() => ({
    orders: [],
  })),
}))