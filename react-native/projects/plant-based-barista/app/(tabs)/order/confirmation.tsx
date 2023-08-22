import { Stack } from "expo-router";
import { Text, View } from "../../../components/Themed";

export default function Confirmation() {
  return <>
    <Stack.Screen options={{
      title: 'Order Confirmed',
    }} />
    <View style={{
      flex: 1,
      justifyContent: 'center',
      alignItems: 'center',
    }}>
      <Text>Order Confirmed</Text>
      <Text>Thank you for ordering with us</Text>
    </View>
  </>;
}