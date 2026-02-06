library(readxl)
library(ivreg)

data <- read_excel("/USDT_hour_reg.xlsx")
names(data)

data$USDT_Crypto_share <- data$USDT_MktCap/data$crypto_MktCap
data$DAI_Crypto_share <- data$DAI_MktCap/data$crypto_MktCap
data$log_crypto_MktCap = log(data$crypto_MktCap)
data$US_treasury_

model_1std_high <- ivreg(`1std_high` ~ HHI + GL_month_diff + SOFR_ONRRP + VIX +
                         `Fear Greedy Index` + dxy + jpy + gold_return + `4w_bid_cover` +
                         `3m_bid_cover` + `3m_rate` + repo_share + bill_share + CorporateBond_PreciousMetal  | 
                          USDT_Crypto_share |  
                         log_crypto_MktCap + DAI_Crypto_share,  
                       data = data)

summary(model_1std_high)

model_2std_high <- ivreg(`2std_high` ~ HHI + GL_month_diff + SOFR_ONRRP + VIX +
                           `Fear Greedy Index` + dxy + jpy + gold_return + `4w_bid_cover` +
                           `3m_bid_cover` + `3m_rate` + repo_share + bill_share + CorporateBond_PreciousMetal  | 
                           USDT_Crypto_share |  # endo var
                           log_crypto_MktCap + DAI_Crypto_share,  # iv 
                         data = data)

summary(model_2std_high)

model_3std_high <- ivreg(`3std_high` ~ HHI + GL_month_diff + SOFR_ONRRP + VIX +
                           `Fear Greedy Index` + dxy + jpy + gold_return + `4w_bid_cover` +
                           `3m_bid_cover` + `3m_rate` + repo_share + bill_share + CorporateBond_PreciousMetal  | 
                           USDT_Crypto_share |  
                           log_crypto_MktCap + DAI_Crypto_share, 
                         data = data)

summary(model_3std_high)



model_1std_low <- ivreg(`1std_low` ~ HHI + GL_month_diff + SOFR_ONRRP + VIX +
                             `Fear Greedy Index` + dxy + jpy + gold_return + `4w_bid_cover` +
                             `3m_bid_cover` + `3m_rate` + repo_share + bill_share + CorporateBond_PreciousMetal  | 
                             USDT_Crypto_share |  
                             log_crypto_MktCap + DAI_Crypto_share,  
                           data = data)

summary(model_1std_low)

model_2std_low <- ivreg(`2std_low` ~ HHI + GL_month_diff + SOFR_ONRRP + VIX +
                           `Fear Greedy Index` + dxy + jpy + gold_return + `4w_bid_cover` +
                           `3m_bid_cover` + `3m_rate` + repo_share + bill_share + CorporateBond_PreciousMetal  | 
                           USDT_Crypto_share |  
                           log_crypto_MktCap + DAI_Crypto_share,  
                         data = data)

summary(model_2std_low)

model_3std_low <- ivreg(`3std_low` ~ HHI + GL_month_diff + SOFR_ONRRP + VIX +
                           `Fear Greedy Index` + dxy + jpy + gold_return + `4w_bid_cover` +
                           `3m_bid_cover` + `3m_rate` + repo_share + bill_share + CorporateBond_PreciousMetal  | 
                           USDT_Crypto_share |  
                           log_crypto_MktCap + DAI_Crypto_share,  
                         data = data)

summary(model_3std_low)

