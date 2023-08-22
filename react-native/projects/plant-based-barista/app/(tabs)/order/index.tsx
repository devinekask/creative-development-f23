import { Stack, router } from "expo-router";
import { Text, View } from "../../../components/Themed";
import { useOrderStore } from "../../../store/useOrderStore";
import { FlashList } from "@shopify/flash-list";
import { Button } from "react-native";

export default function OrderScreen() {

  const orders = useOrderStore(state => state.orders);
  const resetOrders = useOrderStore(state => state.resetOrders);
  const totalPrice = orders.reduce((total, order) => total + order.amount * order.coffee.price, 0);

  return <>
    <Stack.Screen options={{
      title: 'Order',
    }} />
    <View style={{
      flex: 1,
    }}>
      <FlashList
        data={orders}
        renderItem={({ item }) => <View style={{
          flexDirection: 'row',
          gap: 10,
          justifyContent: 'space-between',
          paddingHorizontal: 18,
          paddingVertical: 10,
        }}>
          <Text>{item.coffee.name} x {item.amount}</Text>
          <Text>EUR {(item.amount * item.coffee.price).toFixed(2)}</Text>
        </View>}
        estimatedItemSize={50}
      />
      <View style={{
        flexDirection: 'row',
        gap: 10,
        justifyContent: 'space-between',
        paddingHorizontal: 18,
        paddingVertical: 10,
      }}>
        <Text>Total</Text>
        <Text>EUR {totalPrice.toFixed(2)}</Text>
      </View>
      <View style={{
        paddingHorizontal: 18,
        paddingVertical: 18,
      }}>
        <Button title="Confirm Order" onPress={() => {
          resetOrders();
          router.push('/(tabs)/order/confirmation');
        }} />
      </View>
    </View>
  </>
}