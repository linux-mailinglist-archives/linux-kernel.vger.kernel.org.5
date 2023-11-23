Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C0C7F62F5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346177AbjKWP1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346156AbjKWP1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:27:08 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9953B10FF;
        Thu, 23 Nov 2023 07:27:07 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9DFCF240005;
        Thu, 23 Nov 2023 15:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700753226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gZ7oKcw0eqw6lprpX+dDIOb31hPprI1Sem1ITgrbMiU=;
        b=Jrz6PfG7ALhbkNRvrnNXxKuMXm1EwTpWSQK30WW9tHI5lyF6uA4aut7SngQeWB2840WMcU
        axLkjHXfRMURkF5oDhbUwvIiCN+LC+aszKHOwp2yI1zvFvlrDOIcJQMM+AjhofxUNUFwu2
        oa7NnTTq2iI7BfbP66VO0FvYVodsSmrZBKV5pu+h44BjVTUbsYuwBoJdzkscO3bKj5OBRm
        phCE7wpA21o4EUMKWNu48Q/Ax+G6RM1MkNmEkf2Sco1pUED4RD2gpfZtNz0SDLjm4bBBDb
        wetMtTStyAXYjmQmkuWH/DU8N6OxcThiiciOdmYyt+mRX/hMvWSoRFhMdWjIBQ==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 14/21] dt-bindings: Add vendor prefix for Mobileye Vision Technologies Ltd.
Date:   Thu, 23 Nov 2023 16:26:31 +0100
Message-ID: <20231123152639.561231-15-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123152639.561231-1-gregory.clement@bootlin.com>
References: <20231123152639.561231-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mobileye Vision Technologies Ltd. is a company developing autonomous
driving technologies and advanced driver-assistance systems (ADAS)
including cameras, computer chips and software.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 309b94c328c84..b45279bc97c14 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -897,6 +897,8 @@ patternProperties:
     description: Miyoo
   "^mntre,.*":
     description: MNT Research GmbH
+  "^mobileye,.*":
+    description: Mobileye Vision Technologies Ltd.
   "^modtronix,.*":
     description: Modtronix Engineering
   "^moortec,.*":
-- 
2.42.0

