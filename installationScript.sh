sudo apt-get update
sudo apt-get install apache2 -y
sudo apt-get install openjdk-8-jdk -y
sudo apt-get install wget -y
sudo apt-get install tomcat8
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
echo 'Start downloading tomcat..!!'
if [ ! -f /etc/apache-tomcat-8*tar.gz ]
then
 sudo wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.0.46/bin/apache-tomcat-8.0.46.tar.gz -P /etc
fi
sudo ls -l /etc | grep 'tomcat'
echo 'Tomcat downloaded..!!'
echo 'create tomcat installation directory'
sudo mkdir -p '/opt/tomcat8/'
sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat8 tomcat
echo 'extract tomcat binaries in installation directory'
echo $PWD
sudo tar -xvf /etc/apache-tomcat-8*tar.gz -C "/opt/tomcat8" --strip-components=1
sudo ls -l /opt/tomcat8
sudo chmod -R 777 /opt/tomcat8
sudo chmod +x /opt/tomcat8/bin/*.bat
sudo su
cd /opt/tomcat8
sudo chmod -R 777 webapp
sudo chmod -R 777 work
echo "export CATALINA_HOME='/opt/tomcat8/'" >> ~/.bashrc
cd /opt/tomcat8/bin
./startup.sh