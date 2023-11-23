Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4E77F6093
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345574AbjKWNmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345536AbjKWNmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:42:40 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078ABD47;
        Thu, 23 Nov 2023 05:42:45 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 30AF420002;
        Thu, 23 Nov 2023 13:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700746964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u6N8cnAeiMvZjIuo8ykO3zJAvNmqAkrErQjox7ErLGQ=;
        b=XuvypAzC1a43x1R+l83J3ZoAq77pyeAHTs4Reoh7X7+XzON+8pcMHGcmvBQvovn+JQJrgZ
        LWWvkN5db6wylY8N8d6YD0SKC1vwIvptKHFjtAFD90bjspFTBlyECI3U87PxN3A7mpWbUY
        Ljzk1RpXSwEcwnUnIwH47axka8kdMCdXBHZQZck6DReYphlHhwgo9+bjmByIcp9AqGdoGd
        cCIgVgW35Pb3CNJDIT6gGZqx30JZeGySpfvftYdY9Btc0UMHx1kVhIuD4WnA3ssiPS9eCX
        uMFe4CZSJ2wRy4liJFoNRXSqFlYi79jgHzjuC7Kk8XYN8neK9jwzVNNG8WwXsA==
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date:   Thu, 23 Nov 2023 14:42:39 +0100
Subject: [PATCH v4 1/6] tty: serial: amba: cleanup whitespace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231123-mbly-uart-v4-1-7f913a74ff89@bootlin.com>
References: <20231123-mbly-uart-v4-0-7f913a74ff89@bootlin.com>
In-Reply-To: <20231123-mbly-uart-v4-0-7f913a74ff89@bootlin.com>
To:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix whitespace in include/linux/amba/serial.h to match current kernel
coding standards. Fixes about:

 - CHECK: spaces preferred around that '|' (ctx:VxV)
 - ERROR: code indent should use tabs where possible
 - WARNING: Unnecessary space before function pointer arguments
 - WARNING: please, no spaces at the start of a line

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 include/linux/amba/serial.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/amba/serial.h b/include/linux/amba/serial.h
index a1307b58cc2c..27003ec52114 100644
--- a/include/linux/amba/serial.h
+++ b/include/linux/amba/serial.h
@@ -75,10 +75,10 @@
 #define UART011_DR_PE		(1 << 9)
 #define UART011_DR_FE		(1 << 8)
 
-#define UART01x_RSR_OE 		0x08
-#define UART01x_RSR_BE 		0x04
-#define UART01x_RSR_PE 		0x02
-#define UART01x_RSR_FE 		0x01
+#define UART01x_RSR_OE		0x08
+#define UART01x_RSR_BE		0x04
+#define UART01x_RSR_PE		0x02
+#define UART01x_RSR_FE		0x01
 
 #define UART011_FR_RI		0x100
 #define UART011_FR_TXFE		0x080
@@ -86,9 +86,9 @@
 #define UART01x_FR_TXFF		0x020
 #define UART01x_FR_RXFE		0x010
 #define UART01x_FR_BUSY		0x008
-#define UART01x_FR_DCD 		0x004
-#define UART01x_FR_DSR 		0x002
-#define UART01x_FR_CTS 		0x001
+#define UART01x_FR_DCD		0x004
+#define UART01x_FR_DSR		0x002
+#define UART01x_FR_CTS		0x001
 #define UART01x_FR_TMSK		(UART01x_FR_TXFF + UART01x_FR_BUSY)
 
 /*
@@ -110,14 +110,14 @@
 #define UART011_CR_TXE		0x0100	/* transmit enable */
 #define UART011_CR_LBE		0x0080	/* loopback enable */
 #define UART010_CR_RTIE		0x0040
-#define UART010_CR_TIE 		0x0020
-#define UART010_CR_RIE 		0x0010
+#define UART010_CR_TIE		0x0020
+#define UART010_CR_RIE		0x0010
 #define UART010_CR_MSIE		0x0008
 #define ST_UART011_CR_OVSFACT	0x0008	/* Oversampling factor */
 #define UART01x_CR_IIRLP	0x0004	/* SIR low power mode */
 #define UART01x_CR_SIREN	0x0002	/* SIR enable */
 #define UART01x_CR_UARTEN	0x0001	/* UART enable */
- 
+
 #define UART011_LCRH_SPS	0x80
 #define UART01x_LCRH_WLEN_8	0x60
 #define UART01x_LCRH_WLEN_7	0x40
@@ -203,8 +203,8 @@
 #define UART011_TXDMAE		(1 << 1)	/* enable transmit dma */
 #define UART011_RXDMAE		(1 << 0)	/* enable receive dma */
 
-#define UART01x_RSR_ANY		(UART01x_RSR_OE|UART01x_RSR_BE|UART01x_RSR_PE|UART01x_RSR_FE)
-#define UART01x_FR_MODEM_ANY	(UART01x_FR_DCD|UART01x_FR_DSR|UART01x_FR_CTS)
+#define UART01x_RSR_ANY		(UART01x_RSR_OE | UART01x_RSR_BE | UART01x_RSR_PE | UART01x_RSR_FE)
+#define UART01x_FR_MODEM_ANY	(UART01x_FR_DCD | UART01x_FR_DSR | UART01x_FR_CTS)
 
 #ifndef __ASSEMBLY__
 struct amba_device; /* in uncompress this is included but amba/bus.h is not */
@@ -220,8 +220,8 @@ struct amba_pl011_data {
 	bool dma_rx_poll_enable;
 	unsigned int dma_rx_poll_rate;
 	unsigned int dma_rx_poll_timeout;
-        void (*init) (void);
-	void (*exit) (void);
+	void (*init)(void);
+	void (*exit)(void);
 };
 #endif
 

-- 
2.42.0

