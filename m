Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7207B1393
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjI1HG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjI1HG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:06:58 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5BABF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:06:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll6s-0002KB-Tg; Thu, 28 Sep 2023 09:06:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll6s-009WBC-2G; Thu, 28 Sep 2023 09:06:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll6r-005ZWp-PD; Thu, 28 Sep 2023 09:06:53 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        soc@kernel.org, kernel@pengutronix.de
Subject: [PATCH] MAINTAINERS: Fix Florian Fainelli's email address
Date:   Thu, 28 Sep 2023 09:06:52 +0200
Message-Id: <20230928070652.2290946-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1021; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=mP0/FGYn2AOosIPkgXqiG/FEG70hcrXCbfdqnRWs4fM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFSYLZAzrRcAGfwC0vs8fzcYDKjRzt8+EhNXs9 W8HhJCWD3GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRUmCwAKCRCPgPtYfRL+ TtyEB/4sL1CoVb5esC0KKKOQOEV5ruSR8/YdDSZZBS8al0S4N6IEBi1hzDoI4Tjf57iE4v8u6ea f9oZbFWY/efb0Pq5WtPOIxlK4eeH2f/mmV9bxWpbMtME4mlXrQaITLWB2YSXdfr4biKQDieze7d fqJIchwqvWDtOqsypQkuQ8iAtbyIzJ/j7M43hDfSJ4IZK5nRiEmA0yneB4fAnYTgNaWNtxwUYW4 IDSDyFtWJeARSpOEu+AiaGIRl/uyJslAIQM5k6Gy9lJdZtO0ZMlY9F9LVt5jkHLYtorB6DkZF0Z +4SLETlAiob+9RcvlWkl1gWUQMWcLuJ/q98AiXB+YGjqmAVU
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 31345a0f5901 ("MAINTAINERS: Replace my email address") added 13
instances of ...@broadcom.com and one of only ...@broadcom. I didn't
double check if Broadcom really owns that TLD, but git send-email
doesn't accept it, so add ".com" to that one bogous(?) instance.

Fixes: 31345a0f5901 ("MAINTAINERS: Replace my email address")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 861a16b4586c..eee99edf3140 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4099,7 +4099,7 @@ F:	drivers/net/wireless/broadcom/brcm80211/
 
 BROADCOM BRCMSTB GPIO DRIVER
 M:	Doug Berger <opendmb@gmail.com>
-M:	Florian Fainelli <florian.fainelli@broadcom>
+M:	Florian Fainelli <florian.fainelli@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
-- 
2.40.1

