Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6457EA6A1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 00:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjKMXEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 18:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjKMXEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 18:04:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB247D55
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 15:04:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7E3C433CD;
        Mon, 13 Nov 2023 23:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699916667;
        bh=/TpGTUwxaehUdu0Xa2c9g+Ihph9wNk+OMb8HMuH20Hs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mnScn8PSevZ1lI7KkR77gTZSq1qTSaJpD+zZjLYk6dKBz/Y1UKi/+JyS0R9JmS7GH
         f21xPlXpmf2owJhZ9tz8QHDMS+e5om+ooU2rKIu+dWg//hkoNOIXBtriftIHR6rGH8
         tVdZcdX/wl/FvxnpC+rOXnnRBR/LfSjMDO9LF0DYpq9ZQ1YiW88ZPrMRk/oi+syD+K
         CvKzpeUZf5q2bS061G7QGftaGZJ4NK87uTBFTQGmXWFGDH5NSea6RfaiHoOvICpLRw
         aRwESMBxDEhdX2lg4/EGD61t96ANUDsk+pyr3hi65Ep7LshPp20FGzJ+Grrz/WLrE8
         XywJiBYCEwy8A==
Received: by mercury (Postfix, from userid 1000)
        id 279751060547; Tue, 14 Nov 2023 00:04:22 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     Alain Volmat <alain.volmat@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/6] dt-bindings: vendor-prefixes: add GalaxyCore
Date:   Mon, 13 Nov 2023 23:57:20 +0100
Message-ID: <20231113230421.226808-2-sre@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231113230421.226808-1-sre@kernel.org>
References: <20231113230421.226808-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alain Volmat <alain.volmat@foss.st.com>

GalaxyCore Shanghai Limited Corporation (https://www.gcoreinc.com)
manufacturers CMOS Image Sensor and Display Driver IC.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 309b94c328c8..b3d751b42927 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -502,6 +502,8 @@ patternProperties:
     description: Fujitsu Ltd.
   "^fxtec,.*":
     description: FX Technology Ltd.
+  "^galaxycore,.*":
+    description: GalaxyCore Inc.
   "^gardena,.*":
     description: GARDENA GmbH
   "^gateway,.*":
-- 
2.42.0

