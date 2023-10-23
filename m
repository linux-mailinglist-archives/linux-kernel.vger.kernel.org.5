Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608487D2780
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 02:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjJWA0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 20:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjJWAZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 20:25:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65FCDE;
        Sun, 22 Oct 2023 17:25:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E951EC433C9;
        Mon, 23 Oct 2023 00:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698020757;
        bh=z5zD73CuDLZzR3kACF7pI8WVgaRXLYeaHoxvXa90vx4=;
        h=From:To:Cc:Subject:Date:From;
        b=fbwCKXch6RSXnhgZ2BkSYRqAS7EsoJ9hfKfS72WWw4dBfWI5AIyhBY703BMfWHiZj
         30uVv5kxUkUzI5Uw5tQedAdDkynmw8zQGDCGE3oyJ4anZLFnXx38jmzeq32LS2Kidr
         0RgX5U+bkiea/zSfYVTLV4s9TVxR4no6ZWSG9carQFU93RydixPa7/IpF3HhLC2cY2
         lyWIf9iIwPCdcYe7bvNkCXBz5ZXxWe4YOiPLcBtek+KpyGK7knIC9g/O4dsQgg7E9E
         GbTMzTW2v4CsyakJQrm7kvSEfsHRbqQ7yb2TWIAlX6myfZZlfub7ec2ObdS8Gw+R/O
         J8FSJ/zEN8wqA==
Received: by mercury (Postfix, from userid 1000)
        id C5378106050E; Mon, 23 Oct 2023 02:25:53 +0200 (CEST)
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
Subject: [PATCH v1 1/3] dt-bindings: vendor-prefixes: add GalaxyCore
Date:   Mon, 23 Oct 2023 02:22:07 +0200
Message-ID: <20231023002547.1754190-1-sre@kernel.org>
X-Mailer: git-send-email 2.42.0
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
Just included for completion, I expect this to be merged:
https://lore.kernel.org/all/20231011175735.1824782-2-alain.volmat@foss.st.com/
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

