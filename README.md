# vu-datenkrake v1.2. Alpha (partly untested) by SmR.b
vu-datenkrake is a mod for venice unleshead, created to log rounds, connections, kills and other server events.

## Working / Tested Events:
* Round start / End logging
* Connection Start / End logging
* Weapon Changes 
* Suppressions and Kills

Other stuff like Linking Connections to Rounds is not yet working and needs debugging.

## Installing the mod ...
### Requirements
* Webserver with PHP 7 and mysql/mariadb
* Venice unleashed

### How to install
#### on your web server ... datenkrake.php
* create db and import datenkrake-db.sql
* copy datenkrake.php to your website
* modify DB credentials in datenkrake.php

#### on your gameserver server ... folder ./datenkrake/
* edit ./datenkrake/ext/server/\_\_init\_\_.lua to point to your datenkrake.php
* move the datenkrake subfolder into ./Mods/ and add to ModList ( https://docs.veniceunleashed.net/hosting/mods/ )
* restart your server


## At the moment the project consists of:
* vu-datenkrake (Mod loaded on your venice unleshead server)
* datenkrake.php (Endpoint that receives game data and saves it into your db)

## Planned Features / Roadmap:
* WebUI to see collected data
* JSON-API to allow consumption of the collected data


##### Licenced under 2-clause BSD licence
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
