library(readxl)
library(ivreg)

data <- read_excel("/USDC_reg.xlsx")
names(data)

data$USDC_dev = abs(data$USDC - 1)*100
data$USDC_Crypto_share <- data$USDC_MktCap/data$crypto_MktCap
data$DAI_Crypto_share <- data$DAI_MktCap/data$crypto_MktCap
data$log_crypto_MktCap = log(data$crypto_MktCap)

iv_model_USDC <- ivreg(USDC_dev ~ HHI + GL_month_diff + SOFR_ONRRP + VIX +
                         `Fear Greedy Index` + dxy + jpy + gold_return + `4w_bid_cover` +
                         `3m_bid_cover` + `3m_rate` + repo_share + bill_share| 
                          USDC_Crypto_share |  
                         log_crypto_MktCap + DAI_Crypto_share,  
                       data = data)

summary(iv_model_USDC)

iv_model_USDC2 <- ivreg(USDC_dev ~ HHI + `BloomBerg Financial Condition` + SOFR_ONRRP + VIX +
                         `Fear Greedy Index` + dxy + jpy + gold_return + `4w_bid_cover` +
                         `3m_bid_cover` + `3m_rate` + repo_share + bill_share| 
                         USDC_Crypto_share |  
                         log_crypto_MktCap + DAI_Crypto_share,  
                       data = data)

summary(iv_model_USDC2)

