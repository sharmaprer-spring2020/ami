echo "region is ${region}"
sudo apt-get update
sudo apt-get install apache2 -y
sudo apt-get install maven -y
sudo apt-get install unzip -y
sudo apt-get install openjdk-8-jdk -y
sudo apt-get install wget -y
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
echo "export JAVA_HOME='/usr/lib/jvm/java-8-openjdk-amd64/'" >> ~/.bashrc
echo 'Start downloading tomcat..!!'
if [ ! -f /etc/apache-tomcat-8*tar.gz ]
then
 sudo wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.0.46/bin/apache-tomcat-8.0.46.tar.gz -P /etc
fi
echo 'Tomcat downloaded..!!'
echo 'create tomcat installation directory'
sudo mkdir -p '/opt/tomcat8/'
sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat8 tomcat
echo 'extract tomcat binaries in installation directory'
sudo tar -xvf /etc/apache-tomcat-8*tar.gz -C "/opt/tomcat8" --strip-components=1
sudo chmod -R 777 /opt/tomcat8
sudo chmod +x /opt/tomcat8/bin/*.bat
sudo su
cd /opt/tomcat8
sudo chmod -R 777 webapps
sudo chmod -R 777 work
cd ..
sudo chown -R tomcat tomcat8/
sudo touch tomcat.service
sudo chmod 777 tomcat.service
echo '[Unit]' > tomcat.service
echo 'Description=Apache Tomcat Web Application Container' >> tomcat.service
echo 'After=network.target' >> tomcat.service
echo '[Service]' >> tomcat.service
echo 'Type=forking' >> tomcat.service
echo 'Environment=JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' >> tomcat.service
echo 'Environment=CATALINA_PID=/opt/tomcat8/temp/tomcat.pid' >> tomcat.service
echo 'Environment=CATALINA_HOME=/opt/tomcat8' >> tomcat.service
echo 'Environment=CATALINA_BASE=/opt/tomcat8' >> tomcat.service
echo 'Environment=CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC' >> tomcat.service
echo 'Environment=JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom' >> tomcat.service
echo 'ExecStart=/opt/tomcat8/bin/startup.sh' >> tomcat.service
echo 'ExecStop=/opt/tomcat/8/bin/shutdown.sh' >> tomcat.service
echo 'User=tomcat' >> tomcat.service
echo 'Group=tomcat' >> tomcat.service
echo "UMask=0007" >> tomcat.service
echo 'RestartSec=10' >> tomcat.service
echo 'Restart=always' >> tomcat.service
echo '[Install]' >> tomcat.service
echo 'WantedBy=multi-user.target' >> tomcat.service
sudo mv /opt/tomcat.service /etc/systemd/system/tomcat.service
sudo chmod 755 /etc/systemd/system/tomcat.service
sudo systemctl daemon-reload
sudo systemctl enable tomcat.service
sudo systemctl start tomcat.service
echo "export CATALINA_HOME='/opt/tomcat8/'" >> ~/.bashrc

#start aws code deploy installation
cd ~
sudo apt-get update
sudo apt-get install ruby -y
cd /home/ubuntu
wget https://aws-codedeploy-${region}.s3.${region}.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
#Check codedeploy service is running
sudo service codedeploy-agent status
#Start codedeploy service 
sudo service codedeploy-agent start
#Check codedeploy service status should be running
sudo service codedeploy-agent status