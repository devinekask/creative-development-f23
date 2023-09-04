import { Pressable, StyleSheet } from 'react-native';

import { Text, View } from '../../../components/Themed';
import { FlashList } from '@shopify/flash-list';
import { Image } from 'expo-image';

import { coffees } from '../../../data/coffees';
import { Link, Stack } from 'expo-router';
import { FontAwesome } from '@expo/vector-icons';
import { useOrderStore } from '../../../store/useOrderStore';

export default function TabOneScreen() {

  const orderCoffee = useOrderStore(state => state.orderCoffee);

  return (
    <>
      <Stack.Screen options={{
        title: 'Coffees',
      }} />
      <View style={styles.container}>
        <FlashList
          data={coffees}
          renderItem={({ item }) => <View style={styles.item}>
            <Link href={`/(tabs)/(index)/${item.id}`} style={styles.link}>
              <View style={styles.left}>
                <Image
                  source={item.image}
                  style={{ width: 60, height: 60 }}
                />
                <View>
                  <Text style={styles.name}>{item.name}</Text>
                  <Text>EUR {item.price}</Text>
                </View>
              </View>
            </Link>
            <View>
              <Pressable
                onPress={() => orderCoffee(item)}
              >
                <FontAwesome name="plus-circle" size={24} />
              </Pressable>
            </View>
          </View>}
          estimatedItemSize={60}
        />
      </View>
    </>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  item: {
    flexDirection: 'row',
    gap: 10,
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingRight: 18,
  },
  left: {
    flexDirection: 'row',
    gap: 10,
    alignItems: 'center',
  },
  link: {
    display: 'flex',
    flexDirection: 'row',
    gap: 10,
    alignItems: 'center',
  },
  name: {
    fontSize: 14,
    fontWeight: 'bold',
  }
});
