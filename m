Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB277F60B8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345595AbjKWNrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345529AbjKWNrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:47:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7902CBA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:47:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38256C433C7;
        Thu, 23 Nov 2023 13:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700747246;
        bh=Tksu6lTu40j+EZN0tFMOSHhEBbN9nqr7FRPKCBhoTj0=;
        h=From:To:Cc:Subject:Date:From;
        b=u0bpNOGXh6wXoJmvu24UNoROEX9mo2lQ36OS/28yua3mXZAToDDRW8BhBouOCoj22
         UMf/7Vxo660dRPGFXxXoJgOi7I8c6JAObRyyvcHTOAXlsKPScykxdVUHTPR2XNYxmc
         vWWSjHrVho+3H1Dx88FGv62CG8v58BSJPgSwIrEYtQerczlHW1DZFdzZyBSWgYLz1V
         nqaqo25N3JbrdJGTV8mZCNdl0CtfN40RCcJYZYPJrSUs+M6P9pEnRLFU+mFHs1ZFOp
         ch0Y6FHDldK0+6mehsABWKFoVUpnN8mEEc3QMOT8XEFR4OXHua61aOK0RNYQRl4ESV
         k0PZfbakWzw0A==
From:   Michael Walle <mwalle@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Michael Walle <mwalle@kernel.org>
Subject: [PATCH] dt-bindings: pwm: remove Xinlei's mail
Date:   Thu, 23 Nov 2023 14:47:16 +0100
Message-Id: <20231123134716.2033769-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xinlei Lee's mail is bouncing:

<xinlei.lee@mediatek.com>: host mailgw02.mediatek.com[216.200.240.185] said:
    550 Relaying mail to xinlei.lee@mediatek.com is not allowed (in reply to
    RCPT TO command)

Remove it.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
index 153e146df7d4..afcdeed4e88a 100644
--- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
+++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
@@ -8,7 +8,6 @@ title: MediaTek DISP_PWM Controller
 
 maintainers:
   - Jitao Shi <jitao.shi@mediatek.com>
-  - Xinlei Lee <xinlei.lee@mediatek.com>
 
 allOf:
   - $ref: pwm.yaml#
-- 
2.39.2

