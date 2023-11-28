Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A5F7FCACB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 00:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376547AbjK1XZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 18:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjK1XZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 18:25:06 -0500
Received: from mail.rnplus.nl (mail.rnplus.nl [178.251.25.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE55719A6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 15:25:10 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.rnplus.nl (Postfix) with ESMTP id EBB0C379446
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 23:26:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at rnplus.nl
Received: from mail.rnplus.nl ([127.0.0.1])
        by localhost (mail.rnplus.nl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 67Bl5vHspR63 for <linux-kernel@vger.kernel.org>;
        Wed, 29 Nov 2023 00:26:46 +0100 (CET)
Received: from werkpc.lan (87-101-2-254.dsl.cambrium.nl [87.101.2.254])
        by mail.rnplus.nl (Postfix) with ESMTPSA id EA6B0379434;
        Wed, 29 Nov 2023 00:26:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rnplus.nl; s=dkim;
        t=1701214002; bh=oZJLJBZAx0MsbUik85ITPZJyjd007ov2TZPI2l716ic=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=t+chuYK0s23tsOzFeP86CZqe/UWh7fxBn61MmxnM8NQSgv7FlQyD7XplKDja2CRWq
         pwxBuwRREswGTpsG3ZSFDxZYebtsCIGzoMIvXnhKAVYG436dN4UOcEIMFQAnLqa5uY
         D/4Zl+DH1DMnYd33gZZ2yWPHJogmjPqNyDAXZeDw=
From:   Renze Nicolai <renze@rnplus.nl>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        renze@rnplus.nl
Subject: [PATCH v2 1/2] dt-bindings: arm: aspeed: add Asrock X570D4U board
Date:   Wed, 29 Nov 2023 00:23:16 +0100
Message-ID: <20231128232456.2932350-2-renze@rnplus.nl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231128232456.2932350-1-renze@rnplus.nl>
References: <20231128232456.2932350-1-renze@rnplus.nl>
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

