/*!
 * Copyright (c) 2018, Okta, Inc. and/or its affiliates. All rights reserved.
 * The Okta software accompanied by this notice is provided pursuant to the Apache License, Version 2.0 (the "License.")
 *
 * You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0.
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *
 * See the License for the specific language governing permissions and limitations under the License.
 */

<template>
  <div id="home">
    <div v-if="!authState.isAuthenticated">
      <b-card
      overlay
      img-src="/../ice-cream-bg.jpg"
      img-alt="Melty Ice Cream Image"
      text-variant="white"
      title="Welcome to Okta Ice!"
      class="text-center"
    >
      <b-card-text>
        If you're seeing this content, you're not authenticated yet. Click the button below to log into your Okta org.
      </b-card-text>
    </b-card>
    <div>
    <b-card
        border-variant="primary"
        header="Okta-Hosted Login with PKCE Flow"
        header-bg-variant="primary"
        header-text-variant="white"
        align="center"      
    >
      <b-card-text  >When you click the Login button below, you will be redirected to your Okta org. When you authenticate, 
        Okta will give you an access and ID token, then return you to this application. Okta will store your tokens in 
        local storage and retrieve them as needed.
      </b-card-text>
      <b-button
        id="login-button"
        class="ui primary button"
        role="button"
        v-on:click="login()"
      >
      Login
      </b-button>
    </b-card>
  </div>

    </div>

    <div v-if="authState.isAuthenticated">
      <p>Welcome back, {{claims && claims.name}}!</p>
      <p>
        You have successfully authenticated against your Okta org, and have been redirected back to this application.  You now have an ID token and access token in local storage.
        Visit the <a href="/profile">My Profile</a> page to take a look inside the ID token.
      </p>
      <p><h4>Now try some of these exciting new flavors...</h4><p>
      <hr />
      <b-container class="bv-example-row">
        <b-row>
          <b-col>
            <b-card
              title="Broccoli"
              img-src="/../broccoliIceCream.jpg"
              img-alt="Image"
              img-top
              img-width="100%"
              tag="article"
              style="max-width: 20rem;"
              class="mb-2"
            >
              <b-card-text>
                Can't you just taste the vitamins and nutrients of the world's most popular green vegetable?
              </b-card-text>
            <b-button href="#" variant="primary" @click="showMessage('Broccoli')">Choose Broccoli</b-button>
            </b-card>
          </b-col>
          <b-col>
            <b-card
              title="Squash"
              img-src="/../squashIceCream.jpg"
              img-alt="Image"
              img-top
              tag="article"
              style="max-width: 20rem;"
              class="mb-2"
            >
              <b-card-text>
                Channel your inner vegetable treat with this delectable, perrenial fall flavor...or not.
              </b-card-text>
            <b-button href="#" variant="primary" @click="showMessage('Squash')">Choose Squash</b-button>
            </b-card>
          </b-col>
          <b-col>
            <b-card
              title="Eggplant"
              img-src="/../eggplantIceCream.jpg"
              img-alt="Image"
              img-top
              tag="article"
              style="max-width: 20rem;"
              class="mb-2"
            >
              <b-card-text>
                If you thought it tasted good with parmasean cheese, wait till you try this!
              </b-card-text>
            <b-button href="#" variant="primary" @click="showMessage('Eggplant')" >Choose Eggplant</b-button>
            </b-card>
          </b-col>
        </b-row>
        <div id="flavorMessage">
        {{ message }}
        </div>
      </b-container>
      
    <div>
      
    </div>

      </div>
  </div>
</template>

<script>
export default {
  name: 'home',
  message : '',
  data: function () {
    return {
      claims: '',
      message: '',
      resourceServerExamples: [
        {
          label: 'Node/Express Resource Server Example',
          url: 'https://github.com/okta/samples-nodejs-express-4/tree/master/resource-server'
        },
        {
          label: 'Java/Spring MVC Resource Server Example',
          url: 'https://github.com/okta/samples-java-spring-mvc/tree/master/resource-server'
        },
        {
          label: 'ASP.NET Core Web API Resource Server Example',
          url: 'https://github.com/okta/samples-aspnetcore/tree/master/samples-aspnetcore-2x/resource-server'
        }
      ]
    }
  },
  created () { this.setup() },
  methods: {
    async setup () {
      if (this.authState.isAuthenticated) {
        this.claims = await this.$auth.getUser()
      }
    },
    login () {
      this.$auth.signInWithRedirect('/')
    },
    showMessage(flavor){
      this.message = "Yeah, can't wait to try " + flavor + "!";
    }
  }
}
</script>
