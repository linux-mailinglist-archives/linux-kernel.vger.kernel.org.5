Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9CC760D75
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjGYIpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjGYIoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:44:02 -0400
X-Greylist: delayed 337 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Jul 2023 01:43:47 PDT
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D922E19A1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:43:47 -0700 (PDT)
Received: from toolbox.int.toradex.com ([213.66.31.70]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Ld00U-1pg7HO2E64-00iCbK;
 Tue, 25 Jul 2023 10:37:06 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        John Garry <john.garry@huawei.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Peng Fan <peng.fan@nxp.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v1] arm64: defconfig: enable driver for bluetooth nxp uart
Date:   Tue, 25 Jul 2023 10:37:00 +0200
Message-Id: <20230725083700.14881-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:09LlqSIt4wUzMDhYK3aVSUxbIhyhjCDLvViCp6KaZXSbug1w9cE
 EwbgQpqadOLJO679+H5l+KQg8m5YPWk3w2ZYq0JeK9+dshjUALx9HSBAEoOJerC5N9NcrUv
 isZ/VGTpJBT8ixw1L7V/OL8kuHtJ/dQ4DDdWjYH/jgcood1FquQGkVnU7n2mgro3qeoSalD
 7rwYZ6mNt0X1StwNJ5xhg==
UI-OutboundReport: notjunk:1;M01:P0:GuJ41oxgTmc=;ig4ScgaGc8F0Lk3nUuHEjBpl48t
 mQpfd1VxD2Si9aW+97jIiu/oen3/B6isU7xz8LfkXfAlZPT1JZbNo0XHmRha/7dMAPjNJf9nD
 YZt2JThXtYrAIZbMdBfPAQVA6pD28X9srZLJyK5LgBgR69dP/6kzh+YunCtqtLhGquEdcBIR+
 8tcc1ur0iENw3UnoqTShi7MDB5i7nAsZJmt9gZtdjGgZvxgQyMzWue1xpSdIeExonorNdaEKL
 wwnI/MsnoS/rKJZlH8Ssy3avLbtbGn7neUKua0t7fTdwg3MJliVOCEJnYbBO56d8tkmmYZxQu
 qnSYRotBFH4+M/4M4cGP6szmnV73WK1WuQg3hmV6dVQI02bQ4WhnRZhrlfTRHQKF0eqvP9Hr7
 2N6b96gREXZJquGDyAho3cukp3POEfdEXKEePxQt7iDCrIzDH3MVTspVi0KMCazWpTmi/d3xh
 pOXXPHR7blycX7LP8ShKxxs4yEKIRQ0CS51Hlf39FmUoRJKLPmhv94OwNLivp6IdX6QbyjfYT
 7PEDqQKjh2f24cny8DKaPBq2SFsIM19nmW08HvsCJSy3W0wLJ10W/uQdhkvWR1kcGIhYOdmWQ
 t837PMWrtv2M6s8p5ZVUHB0ELAdQC7rwA4PXd634eQnc+simhW3Q8BRWEaX2EIClokNAuzLA9
 HkJvD5NDKJoet5L8g9TFf0UW8rNnYnjnDJMuOU//HQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Enable driver for Bluetooth NXP UART applicable amongst others for NXP
88W8997 and IW416 as found on multiple Toradex SoMs.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0777bcae9104..4641d08ef048 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -195,6 +195,7 @@ CONFIG_BT_HCIUART_MRVL=y
 CONFIG_BT_MRVL=m
 CONFIG_BT_MRVL_SDIO=m
 CONFIG_BT_QCOMSMD=m
+CONFIG_BT_NXPUART=m
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
 CONFIG_MAC80211_LEDS=y
-- 
2.36.1

