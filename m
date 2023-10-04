Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A027B84A0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243240AbjJDQLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243247AbjJDQK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:10:57 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A14A6;
        Wed,  4 Oct 2023 09:10:53 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 78E3CE0009;
        Wed,  4 Oct 2023 16:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696435852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jnyUTLwehVTtlgEUKBboKjzUzWzf0QX897nmrudhojE=;
        b=XQn9Zepg+l7OWf8lbe+kp6cCBOb7ZTPXRsJrUDCtXSOIscOIotgCfPqHblOzi98DohPz2i
        n8dqH0Tu3GnLEwJtiC8+a/dpQcJBysao6weyK1w98Bj1SDkVTJ96kIcQ6sbURdQIZo8bFM
        9WB01KKpHJ7U/qzbYjM49TZaGzqcc8+q6UARwUcmKvPbvuLS3Cxbwl2Chx/y2IysUdoYoU
        fl26Uiscvh1d06p/Xgj+R/iubguDnX6YH4OBQ7ZMHuGD6Xqj0myPf8uoF2ywdJmBevCVPT
        3IDLGHAv42JJrBzo18atNNZ0aOl+RDiHaevcsAzXtmKjY6sa82JxThi2lbEKuw==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 04/11] dt-bindings: Add vendor prefix for Mobileye Vision Technologies Ltd.
Date:   Wed,  4 Oct 2023 18:10:31 +0200
Message-Id: <20231004161038.2818327-5-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004161038.2818327-1-gregory.clement@bootlin.com>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mobileye Vision Technologies Ltd. is a company developing autonomous
driving technologies and advanced driver-assistance systems (ADAS)
including cameras, computer chips and software.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 573578db9509..510c6c03f6d5 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -877,6 +877,8 @@ patternProperties:
     description: Miyoo
   "^mntre,.*":
     description: MNT Research GmbH
+  "^mobileye,.*":
+    description: Mobileye Vision Technologies Ltd.
   "^modtronix,.*":
     description: Modtronix Engineering
   "^moortec,.*":
-- 
2.40.1

