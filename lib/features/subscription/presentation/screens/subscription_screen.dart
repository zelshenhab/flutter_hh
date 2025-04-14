import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/subscription_provider.dart';
import '../widgets/plan_card.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SubscriptionProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Subscription")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("Choose a plan:", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            PlanCard(
              title: "Weekly Plan",
              price: "\$4.99",
              selected: provider.selectedPlan == "Weekly",
              onTap: () => provider.selectPlan("Weekly"),
            ),
            PlanCard(
              title: "Monthly Plan",
              price: "\$9.99",
              selected: provider.selectedPlan == "Monthly",
              onTap: () => provider.selectPlan("Monthly"),
            ),
            PlanCard(
              title: "Yearly Plan",
              price: "\$49.99",
              selected: provider.selectedPlan == "Yearly",
              onTap: () => provider.selectPlan("Yearly"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: provider.isSubscribed ? null : provider.subscribe,
              child: Text(provider.isSubscribed ? "Subscribed" : "Subscribe Now"),
            ),
            if (provider.isSubscribed)
              TextButton(
                onPressed: provider.cancelSubscription,
                child: const Text("Cancel Subscription", style: TextStyle(color: Colors.red)),
              ),
            const SizedBox(height: 20),
            const Text("Benefits:", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            const Text("• Unlimited messages"),
            const Text("• Extended hunting time"),
            const Text("• Location change support"),
          ],
        ),
      ),
    );
  }
}
