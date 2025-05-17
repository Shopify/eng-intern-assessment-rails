docker build -t hungnguyen3-shopify-assessment:dev .
docker run -d -p 3000:3000 --name shopify-assessment hungnguyen3-shopify-assessment:dev
echo "-----------------------------------------------------------------"
echo "Hooray! The app is running, please view the application at http://127.0.0.1:3000"
echo "To stop the application, run: docker stop shopify-assessment"
