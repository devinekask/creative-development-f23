import { Stack, useLocalSearchParams } from "expo-router";
import { View, Text } from "../../../components/Themed";
import { coffees } from "../../../data/coffees";
import { Image } from 'expo-image';
import { ScrollView } from "react-native-gesture-handler";

export default function CoffeeDetailScreen() {

  const { id } = useLocalSearchParams<{ id: string }>();
  const coffee = coffees.find(coffee => coffee.id === parseInt(id));
  if(!coffee) throw new Error(`No coffee found with id ${id}`);

  return <>
    <Stack.Screen options={{
      title: coffee.name,
    }} />
    <View style={{
      flex: 1,
      overflow: 'hidden',
    }}>
      <Image source={coffee.image} style={{
        width: '100%',
        height: 300,
      }} />
      <ScrollView>
        <View style={{ padding: 18 }}>
          <Text>{coffee.description}</Text>
        </View>
      </ScrollView>
    </View>
  </>;
}