# Sortify - Turn Trash into Treasure! ♻️

Sortify is a Flutter-based mobile application designed to connects users with recyclers, making waste collection quick and hassle-free. It provides an easy-to-use platform for users to schedule pickups for their recyclable waste and earn reward points, which can be redeemed for real money via UPI.

---

## 🎯 The Problem It Solves

In many urban areas, improper waste segregation and the lack of incentives for recycling lead to overflowing landfills and environmental pollution. Sortify addresses this by:
* **Incentivizing Recycling:** By offering tangible rewards (points redeemable for cash), the app motivates users to segregate and recycle their waste properly.
* **Organizing Waste Collection:** It provides a structured system for users to list their recyclable items and schedule pickups, making the process efficient for both users and collectors.
* **Promoting a Circular Economy:** By ensuring that recyclable materials are collected and processed, Sortify contributes to a more sustainable, circular economy.

---

## ✨ Key Features

* **User Authentication:** Secure signup and login functionality using Firebase.
* **Waste Item Listing:** Users can easily list items for pickup by uploading an image, specifying the quantity, and setting a pickup location.
* **Points & Rewards System:** Users are credited with points upon successful verification of their waste items by an admin.
* **Admin Verification System:** A dedicated admin panel to approve or reject waste collection and redemption requests.
* **UPI Redemption:** A seamless process for users to redeem their earned points directly to their bank account via UPI.

---

## 📱 App Screens & Flow

### User Flow

The user journey is designed to be simple and rewarding.

| Onboarding | Signup / Login | Home |
| :---: | :---: | :---: |
| *Your Screenshot Here*<br>![Onboarding Screen](https://via.placeholder.com/300x600.png?text=Onboarding+Screen) | *Your Screenshot Here*<br>![Login Screen](https://via.placeholder.com/300x600.png?text=Login+Screen) | *Your Screenshot Here*<br>![Home Screen](https://via.placeholder.com/300x600.png?text=Home+Screen) |
| **Upload Items** | **Rewards Corner** | **Profile Page** |
| *Your Screenshot Here*<br>![Upload Item Screen](https://via.placeholder.com/300x600.png?text=Upload+Item+Screen) | *Your Screenshot Here*<br>![Rewards Screen](https://via.placeholder.com/300x600.png?text=Rewards+Screen) | *Your Screenshot Here*<br>![Profile Screen](https://via.placeholder.com/300x600.png?text=Profile+Screen) |

### Admin Flow

The admin panel is straightforward, allowing for quick verification and approval of user requests.

| Item Approval | Redeem Request Approval |
| :---: | :---: |
| *Your Screenshot Here*<br>![Item Approval Screen](https://via.placeholder.com/300x600.png?text=Item+Approval+Screen) | *Your Screenshot Here*<br>![Redeem Approval Screen](https://via.placeholder.com/300x600.png?text=Redeem+Approval+Screen) |

---

## 🛠️ Tech Stack & Architecture

* **Framework:** Flutter
* **Backend & Database:** Firebase
    * **Firestore:** Used as the primary database for storing user data, pickup requests, and transaction history.
    * **Firebase Storage:** Used for uploading and storing images of waste items submitted by users.
    * **Firebase Authentication:** Handles user signup and login.
* **State Management:** `setState` / Provider (or your chosen method)

---

## 📂 Project Structure

The project follows a standard Flutter application structure to maintain a clean and scalable codebase.
