Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB1F7D447B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 03:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjJXBEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 21:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjJXBEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 21:04:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DACEE;
        Mon, 23 Oct 2023 18:04:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B423C433CC;
        Tue, 24 Oct 2023 01:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698109442;
        bh=So2KlXhUCikU8X/BCxDXuE+mxqgiy0lZILYQ1AcKJwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eijedFgUlWc5TZaHc3Dt6uhcA9LAK4wzsPN1l7EqGtp2BB1q2FD0rI4/goioLtUTB
         jSfjL9ToLgeh4jH/znKsIUuo5RDYYsGwX7UnANDgg+6JGsEbWdodce6QaBPXR18Y1e
         AX44nw4+oBJYSb0cybkZ5oanmBh2jBIUIMNRs8Zy3f8dpJoTY/1HwLuiAVNCU6TjZ9
         xzwMfDSaQBTAm7jvYtDRQA7zPqilVSD/pXCJdjLslAMs9hpHcQ4v++oo8rU2ps9nBK
         DkwGBZKPC7V4elnsNdUBjt3SNIpNnE8WcZ/lRgw7mBCIonbLIHQzHGFo77jTCYGVjC
         OcEhFk77YwWLg==
Received: by mercury (Postfix, from userid 1000)
        id B05AD106057D; Tue, 24 Oct 2023 03:03:59 +0200 (CEST)
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
Subject: [PATCH v2 3/4] media: MAINTAINERS: Add GalaxyCore in camera sensor section
Date:   Tue, 24 Oct 2023 02:59:52 +0200
Message-ID: <20231024010355.1877523-4-sre@kernel.org>
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

"gc" prefixed i2c media drivers are most likely GalaxyCore camera
sensor drivers, so add it to the list.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2894f0777537..5f64cd42ff37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22553,6 +22553,7 @@ S:	Maintained
 F:	Documentation/driver-api/media/camera-sensor.rst
 F:	Documentation/driver-api/media/tx-rx.rst
 F:	drivers/media/i2c/ar*
+F:	drivers/media/i2c/gc*
 F:	drivers/media/i2c/hi*
 F:	drivers/media/i2c/imx*
 F:	drivers/media/i2c/mt*
-- 
2.42.0

