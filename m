Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F7780B245
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 06:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbjLIF4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 00:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjLIF4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 00:56:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171FE10CA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 21:56:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B29DC433C8;
        Sat,  9 Dec 2023 05:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702101372;
        bh=6PYTXwogHAUVenupi8BZQBLtsE/8OEo/sEyy3ePyUvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EesK6SYL3ARV9NdcmtjJmYCY8lpowh/xM4QqyisjpN/JEC5J6L7rbZ4lYJde3f99L
         h8x8hH0/D7aAf3bQtjYme8AlX38C5JEKvKGsWLc+ZYzjHm6b+cwH3FR+tPb5hbfMwz
         lfcHhJRgCigzA81/UESmt20S1ZO990eCbEcMBnLm1lW6tIRE6gSf0Qjofhmx4Xutzj
         tecV8eQOEBx/xBdejghRM9U2PLQzSj2wJKfmEtIIaw1phXYY5hJyQQGzEz+leDLyJf
         ssElXwPshHKfFkdGCg5NbZ1w/rZ4JspqlYliQ7VjdNqKxpZfbSMu84bP0nNk+hf5yw
         8Vhy6Lxo9UxIQ==
Received: by mercury (Postfix, from userid 1000)
        id A4346106CC75; Sat,  9 Dec 2023 00:19:49 +0100 (CET)
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
Subject: [PATCH v5 2/3] media: MAINTAINERS: Add GalaxyCore in camera sensor section
Date:   Sat,  9 Dec 2023 00:18:18 +0100
Message-ID: <20231208231933.284277-3-sre@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208231933.284277-1-sre@kernel.org>
References: <20231208231933.284277-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index b6c4c8e037bf..142225181316 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22833,6 +22833,7 @@ S:	Maintained
 F:	Documentation/driver-api/media/camera-sensor.rst
 F:	Documentation/driver-api/media/tx-rx.rst
 F:	drivers/media/i2c/ar*
+F:	drivers/media/i2c/gc*
 F:	drivers/media/i2c/hi*
 F:	drivers/media/i2c/imx*
 F:	drivers/media/i2c/mt*
-- 
2.42.0

