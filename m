Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A95A7ACE98
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 05:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjIYDHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 23:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjIYDHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 23:07:12 -0400
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF5BA4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 20:07:04 -0700 (PDT)
Received: from localhost.localdomain (ppp118-210-175-231.adl-adc-lon-bras34.tpg.internode.on.net [118.210.175.231])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 71CB420172;
        Mon, 25 Sep 2023 11:06:58 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1695611219;
        bh=hSW2jDWPujgtEV8cEoru33vgnmkR7CY+fa5+NBEC1Nk=;
        h=From:To:Cc:Subject:Date;
        b=f8WhEEgjV/kX+2QkmOwA8DmSGzO0Yw/NczkDPL3N4ZbRC7fWrJkh1JMQeL33TqAab
         pvm+q0+TA+kOhf6y5ZPAqGPPV6j+nFYGjah3sLs8fH0fRpYQNFaxs0w/1h4IV0JI5y
         YxBkYAJ3QisHi4G+x0g7yMqeSRzPZB3bN0FfaJLBQZ+4ATQOJb760AL6ZpnI047EdK
         e6gd3AoJgHcF+NLya3sM/dj5vsamoUm4ixMfw78jD9DOJPqEJ+lRk9eJeQU3X2oBmS
         eKVaSjKBEtaGvf3aXXOhYm0NcJzhubp9pZram9hl3odv3ln6j+ExF0HZla4QfHrcGw
         gOGSUfkvdww6Q==
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     joel@jms.id.au, andrew@aj.id.au
Cc:     Andrew Jeffery <andrew@codeconstruct.com.au>,
        linux-aspeed@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: [PATCH] MAINTAINERS: aspeed: Update Andrew's email address
Date:   Mon, 25 Sep 2023 12:36:47 +0930
Message-Id: <20230925030647.40283-1-andrew@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've changed employers, have company email that deals with patch-based
workflows without too much of a headache, and am trying to steer some
content out of my personal mail.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b19995690904..1965cee433b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1963,7 +1963,7 @@ F:	drivers/irqchip/irq-aspeed-i2c-ic.c
 
 ARM/ASPEED MACHINE SUPPORT
 M:	Joel Stanley <joel@jms.id.au>
-R:	Andrew Jeffery <andrew@aj.id.au>
+R:	Andrew Jeffery <andrew@codeconstruct.com.au>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
@@ -3058,7 +3058,7 @@ F:	Documentation/devicetree/bindings/peci/peci-aspeed.yaml
 F:	drivers/peci/controller/peci-aspeed.c
 
 ASPEED PINCTRL DRIVERS
-M:	Andrew Jeffery <andrew@aj.id.au>
+M:	Andrew Jeffery <andrew@codeconstruct.com.au>
 L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
 L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 L:	linux-gpio@vger.kernel.org
@@ -3075,7 +3075,7 @@ F:	drivers/irqchip/irq-aspeed-scu-ic.c
 F:	include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
 
 ASPEED SD/MMC DRIVER
-M:	Andrew Jeffery <andrew@aj.id.au>
+M:	Andrew Jeffery <andrew@codeconstruct.com.au>
 L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
 L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 L:	linux-mmc@vger.kernel.org
-- 
2.39.2

