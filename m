Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F309752E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 03:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbjGNBiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 21:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjGNBiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:38:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153012D60;
        Thu, 13 Jul 2023 18:38:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C1AD61BA2;
        Fri, 14 Jul 2023 01:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59EBC433C9;
        Fri, 14 Jul 2023 01:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689298681;
        bh=LPOwEiLDba7WqkS5e6PMVWcf9bxL4V+UFMcte4xKN7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ENVvj5nN3emsfKqKyx1iWqHLTmxPBlBu+UBlk0CVbM6eJB/AHK4ulqq1AzPz8MdzK
         uaG9auED1JyG44KGnoZ6PwzjBU5bhT7wEnGxyzqy3mm0eH1y/sEdtVTervd51DMX+C
         uUKloTsfhMRbg56oFkfgCIO6cbtDj/Bg/EsDQxp/JavFzFKXqbbN2zyV+qZzclTz5t
         XusvMJVYrSr8P09hBrOAwGVbaArjdEeGiri2m2oEkgrEA0HzOKGkjAQFtr44HLiaOQ
         7Z14321ihJoc6BmI6UFH9OVI5Oi19HRB2dScVTqP7ByUhvUVoW26YyiaxYhfwBb4Z5
         SJBtmL7mSEzbA==
Received: by mercury (Postfix, from userid 1000)
        id CAE161067666; Fri, 14 Jul 2023 03:37:58 +0200 (CEST)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 01/19] dt-bindings: vendor-prefixes: add Inanbo
Date:   Fri, 14 Jul 2023 03:37:38 +0200
Message-Id: <20230714013756.1546769-2-sre@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230714013756.1546769-1-sre@kernel.org>
References: <20230714013756.1546769-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shenzhen INANBO Electronic Technology Co., Ltd. manufacturers TFT/OLED
LCD panels.

Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index af60bf1a6664..1e2e51401dc5 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -617,6 +617,8 @@ patternProperties:
     description: Imagination Technologies Ltd.
   "^imi,.*":
     description: Integrated Micro-Electronics Inc.
+  "^inanbo,.*":
+    description: Shenzhen INANBO Electronic Technology Co., Ltd.
   "^incircuit,.*":
     description: In-Circuit GmbH
   "^indiedroid,.*":
-- 
2.40.1

