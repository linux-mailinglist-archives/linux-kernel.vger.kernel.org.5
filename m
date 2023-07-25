Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF788760DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjGYI5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjGYI5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:57:20 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4D4B0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:57:18 -0700 (PDT)
Received: from toolbox.int.toradex.com ([213.66.31.70]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MCbo4-1qEuBg2vx4-009Ppb;
 Tue, 25 Jul 2023 10:56:39 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sherry Sun <sherry.sun@nxp.com>,
        Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
        linux-imx@nxp.com, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        John Garry <john.garry@huawei.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Peng Fan <peng.fan@nxp.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2] arm64: defconfig: enable driver for bluetooth nxp uart
Date:   Tue, 25 Jul 2023 10:56:30 +0200
Message-Id: <20230725085630.16179-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WfwggaFCGoF7Xs0C39lazmonXfniBsUW2PCAR+e1ArTurD8Glpc
 zYx+6+hV3N1hrbJqXKLANJiGL57sf12WXZc1gRHv9jc6hQnyUJWk0OTqYJ5bXiRAWsVIot4
 WR2249QAZRHB35E578KAX/+VU0Tj3Gqta2yTK07PIR4ei4Fw+PCSWfR3Q+op6WR+OZ5nY99
 /hLMfaDO8nXSVPuXks2HQ==
UI-OutboundReport: notjunk:1;M01:P0:1qzSuPprjg8=;JW4zgLPgCCWRCcspFxPr7wWDpdV
 FoeZSvL/68+ssvD7GPAuOhcIiA1iMZhpDjqX5B0lB3LgNIufg84PCuhV3cpC2RlsujEOCQS3s
 aXa9lV0y6pYt2M/dWFc/LbezOmCyOdRoEqukyYdm+YYsbcoIM+FKd6LufXg4ApSzHQgp8/CyJ
 M1QaKPcacW8GwticBsHlBbRBWqJCxQamlv/zWd4stbrzgpabrAKSNY6lo/O9Wts/LMlMxUZ7o
 PWXWPW4OuAVgaLNY5Zkl4baGns1Tcl4qcWKCNWM+p5HeU5Kgp/8Xd1Y7zExeQk7YhGGkoKqyv
 TgukbzHofpdwOQesZIIzlTvtmB4I9Sk7We1ypGbmPVSmkFSuOqwRqkf6X2DXhAoWuvn1aC9X8
 osCK+P1wklid5FwlOGAcYhyeEyEDlalQiOFp/hqO7kJGlrTG4M4INkRVIDcM89wRxbbsm9DT8
 Q7fvEtFANyAiKkDHtj+MJUW4nH6qD4iSzzkk8aGuF29zyJZimabfQCNWId+KnXZgpuwSpse6t
 W7PFmmvRv2ptfr9/ACNYWNtdyGs5ip2saahVyQwo9X1XlANg0m2GY+w34PfmyeLYI9R7Cdu9B
 JiHKDFDn8yd0W0rN25VRUc2fPwreknIXtzXiNjG27Ecu/8dK80w3Ja0brZ41kasByqj/kiAQP
 7IJTaZkklAvrahqVH6hFB8/WieyAJk0L5skv5wN0YQ==
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
- Add Krzysztof's reviewed-by tag. Thanks!
- Cc Shawn as this should go via IMX/NXP SoC tree.

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

