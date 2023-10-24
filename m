Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662FA7D4475
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 03:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjJXBEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 21:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjJXBEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 21:04:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BC8E8;
        Mon, 23 Oct 2023 18:04:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66050C433CA;
        Tue, 24 Oct 2023 01:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698109442;
        bh=z5zD73CuDLZzR3kACF7pI8WVgaRXLYeaHoxvXa90vx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T3pXl0foZ1CKiRgvmsO9n0qohBQbTW64EBG3sAJDTAAIfOdDzaPWavetHwis5SBlU
         Let6/U27DKsUJVGc5t5GYnOFvZBUaDFm+/wkzlMokHQAXzaB4/RO/E4U6k1C7b+Bcl
         kFIzkQJGCQV4sHDBO52kiQWdKK1r3erIimjsr9LCvNQrYCU2DoB1K7KjBPDYmN7hIG
         zQecdt4IBCuGBHvIGBD0F181DUGvSBN4vdIflruyt7Q8CnzBpQfCmzQle2nxhZBc/N
         SYDCBa8y3fQ1gSP193K1hP4U8Uo152AsZAURuJXgEC+kZ/WBvdmMvqeeTHPFsz5ZcB
         jg87dYCRA/cEw==
Received: by mercury (Postfix, from userid 1000)
        id A96951060516; Tue, 24 Oct 2023 03:03:59 +0200 (CEST)
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
Subject: [PATCH v2 1/4] dt-bindings: vendor-prefixes: add GalaxyCore
Date:   Tue, 24 Oct 2023 02:59:50 +0200
Message-ID: <20231024010355.1877523-2-sre@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024010355.1877523-1-sre@kernel.org>
References: <20231024010355.1877523-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

