Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350397D8CB4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 03:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345018AbjJ0BOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 21:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0BOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 21:14:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EBB1AD;
        Thu, 26 Oct 2023 18:14:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EE6C433C7;
        Fri, 27 Oct 2023 01:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698369261;
        bh=Y1NK/POahZrLvSXLrd6NlTxLMpaZrRLCzwnjhAM21xE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kSpnv+XPb0jGS+g/RzxQl+DtG8FwmkXgRMgwr1xmPWIc4vkUcFG8gVV6yOnY4Rgy+
         A8o9Pp0yd5BqtUFJwfZjGfpCTjcQoG17q1S/+qcPmfY3GuJNmASZ1AQ5TWBNeTAKkD
         ixKoVTyO3HAN5Q+ZTEoJeeG89alc6+0QUPkZoVdCWdY4/ik/fbrfT2VpUqBG/xcTyK
         WommjbjXZCQWQzfgQtUvcwitZ9ZDGNImf9KJs2R9t3VJTpgQqhdlaYIzGKbnWC600l
         BWxI8oOSBVg1YybEIjzRJUZsG7o7DvAUXrEjSs6biZ6KpLc58YsyK51skfy/70x21y
         eXybWISvl2KPg==
Received: by mercury (Postfix, from userid 1000)
        id 4140F106052D; Fri, 27 Oct 2023 03:14:18 +0200 (CEST)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] dt-bindings: vendor-prefixes: add GalaxyCore
Date:   Fri, 27 Oct 2023 03:12:01 +0200
Message-ID: <20231027011417.2174658-2-sre@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231027011417.2174658-1-sre@kernel.org>
References: <20231027011417.2174658-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GalaxyCore Shanghai Limited Corporation manufacturers
CMOS Image Sensor and Display Driver IC.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 573578db9509..8cb49a2e4afa 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -494,6 +494,8 @@ patternProperties:
     description: Fujitsu Ltd.
   "^fxtec,.*":
     description: FX Technology Ltd.
+  "^galaxycore,.*":
+    description: GalaxyCore Shanghai Limited Corporation
   "^gardena,.*":
     description: GARDENA GmbH
   "^gateworks,.*":
-- 
2.42.0

