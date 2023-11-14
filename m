Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EE07EAEE4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjKNL2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbjKNL2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:28:32 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18F9193;
        Tue, 14 Nov 2023 03:28:27 -0800 (PST)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:7e5d:5300::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 3D309DF7;
        Tue, 14 Nov 2023 03:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1699961307;
        bh=YIUwD19GsEb/8HLWFg6AbrC1OrzehA0dIwV7by3EZgk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eSfRi4iY/zk6E+XpFmu25tbxXf0BG2WR4fB/lUNpQJGuOMSYT4dlJL5UWPhinqmMH
         HSjk0MREJb9bSTilW3+HAtdDzT/u3Jxcm/Huly+9hfWsvvzaWMqzVau85/SP8FNd0T
         ce41dsVChyaiykUBamv7WlV96fyp+OoFvQXzEWNI=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>
Cc:     Zev Weiss <zev@bewilderbeest.net>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: document ASRock SPC621D8HM3
Date:   Tue, 14 Nov 2023 03:28:21 -0800
Message-ID: <20231114112819.28572-5-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231114112819.28572-4-zev@bewilderbeest.net>
References: <20231114112819.28572-4-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document ASRock SPC621D8HM3 board compatible.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 749ee54a3ff8..f8f66821cb5f 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -36,6 +36,7 @@ properties:
               - aspeed,ast2500-evb
               - asrock,e3c246d4i-bmc
               - asrock,romed8hm3-bmc
+              - asrock,spc621d8hm3-bmc
               - bytedance,g220a-bmc
               - facebook,cmm-bmc
               - facebook,minipack-bmc
-- 
2.42.0

