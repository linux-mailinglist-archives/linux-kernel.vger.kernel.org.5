Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0F37EA69B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 00:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjKMXEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 18:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjKMXE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 18:04:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412861B5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 15:04:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36E1C433B7;
        Mon, 13 Nov 2023 23:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699916665;
        bh=g9kp4dOAahcHHLMDbHOEBKbPO3MW2nPc6tdcUYzD1BI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UtHllQV2DEGG4gjGNxlYk2yAdeOzMS6DMXjzETa1STBlZqnbux9m9yudu3ah2pYrt
         OJ1AFnPM0qGUjMYyDKrvpgrH7WLX8/wKWhhe+BVxN2HXJR5tqPwSmGqR7c9sFUW/OJ
         lhdjjr818o7ZOb/KG4mQ6pjGRa963YO2Lbc4rgbThBZ2HA9/MWj1hHT7seM8tyxUFk
         E+SbPnVy9049Q/SnxABVkRMnmZc1BedLE/P23kbvH6qOX0FBpeO3utCnzG/y+gkKL1
         Hy4zo9qJRvikvoUs5cqXun7v3D/R1/QHy3oF0zMLkzB6PaVt6UhpP/LtvzHPRHmuWE
         4KJOBr+ummFwg==
Received: by mercury (Postfix, from userid 1000)
        id 2DF41106323E; Tue, 14 Nov 2023 00:04:22 +0100 (CET)
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
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/6] media: MAINTAINERS: Add GalaxyCore in camera sensor section
Date:   Mon, 13 Nov 2023 23:57:22 +0100
Message-ID: <20231113230421.226808-4-sre@kernel.org>
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

"gc" prefixed i2c media drivers are most likely GalaxyCore camera
sensor drivers, so add it to the list.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97f51d5ec1cf..c41fcf10e356 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22792,6 +22792,7 @@ S:	Maintained
 F:	Documentation/driver-api/media/camera-sensor.rst
 F:	Documentation/driver-api/media/tx-rx.rst
 F:	drivers/media/i2c/ar*
+F:	drivers/media/i2c/gc*
 F:	drivers/media/i2c/hi*
 F:	drivers/media/i2c/imx*
 F:	drivers/media/i2c/mt*
-- 
2.42.0

