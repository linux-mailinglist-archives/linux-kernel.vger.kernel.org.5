Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3488018FA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441975AbjLBAjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441967AbjLBAjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:39:36 -0500
Received: from mail.rnplus.nl (mail.rnplus.nl [178.251.25.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C351B3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:39:34 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.rnplus.nl (Postfix) with ESMTP id 75ED0379441
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 00:41:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at rnplus.nl
Received: from mail.rnplus.nl ([127.0.0.1])
        by localhost (mail.rnplus.nl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YG4FYt3Hpnpm for <linux-kernel@vger.kernel.org>;
        Sat,  2 Dec 2023 01:41:10 +0100 (CET)
Received: from werkpc.lan (87-101-2-254.dsl.cambrium.nl [87.101.2.254])
        by mail.rnplus.nl (Postfix) with ESMTPSA id 173ED3793FF;
        Sat,  2 Dec 2023 01:41:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rnplus.nl; s=dkim;
        t=1701477663; bh=CwGWvJCzddL6gm7YQA+F+nkM3tpx9C2kBUx10w36QJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=T6BoGNs88njtLz//MLdZdnVxyMDruJVgf2iNmGHbjjS1FY1+bD4byHH5NiqPq0wep
         DiDQF4Xz7vo2Ekzn8VWlbfkEqG8pnIRVa6gzWAA0jEFtBvv3g1j+Pc8yVDaZxNm7CY
         MTbt/VPdW4YgNWIPmH6ScQ1LYuzGKmo5cHdI0EA0=
From:   Renze Nicolai <renze@rnplus.nl>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        renze@rnplus.nl
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: arm: aspeed: add Asrock X570D4U board
Date:   Sat,  2 Dec 2023 01:38:44 +0100
Message-ID: <20231202003908.3635695-2-renze@rnplus.nl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231202003908.3635695-1-renze@rnplus.nl>
References: <20231202003908.3635695-1-renze@rnplus.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Asrock X570D4U compatible.

Signed-off-by: Renze Nicolai <renze@rnplus.nl>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 749ee54a3ff8..81ed678905fa 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -36,6 +36,7 @@ properties:
               - aspeed,ast2500-evb
               - asrock,e3c246d4i-bmc
               - asrock,romed8hm3-bmc
+              - asrock,x570d4u-bmc
               - bytedance,g220a-bmc
               - facebook,cmm-bmc
               - facebook,minipack-bmc
-- 
2.43.0

