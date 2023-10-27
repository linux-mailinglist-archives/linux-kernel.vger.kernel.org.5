Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC657D8CBF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 03:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345134AbjJ0BOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 21:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345072AbjJ0BOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 21:14:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EEC1BF;
        Thu, 26 Oct 2023 18:14:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0D9C433B8;
        Fri, 27 Oct 2023 01:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698369262;
        bh=So2KlXhUCikU8X/BCxDXuE+mxqgiy0lZILYQ1AcKJwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TXwpwCwCg5chBKG53rOTjIIc97vMY8OKGqO9g1zv9PjuCVS1NeO6plcZukUkYO4oX
         HkxALLwtKYfi1LzcF6aFqCmGOBUpwyyst38WFDCPtHLKsEWhQJZuGriLMLVSJMU00T
         UAy+ne3S+1Q/F22VYfMscqRMEyyAKDhRQd+y9qOKXsKMJtxwme9sQVqmV1H1pW0M40
         tHY2tMd2ioQryR2o0QyW4j2LN8xYNHVlJIohvjtgWMHXU3fus1daoDFAZaxbp7WIzj
         eIkqoSazf/iJJYs2R0SpC4W38C8PPySxiytJWyQ4G84KEGSLzIWPqATe/jZQsmpBnN
         dQp/ffzkeu0lw==
Received: by mercury (Postfix, from userid 1000)
        id 47EC0106057E; Fri, 27 Oct 2023 03:14:18 +0200 (CEST)
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
Subject: [PATCH v3 3/4] media: MAINTAINERS: Add GalaxyCore in camera sensor section
Date:   Fri, 27 Oct 2023 03:12:03 +0200
Message-ID: <20231027011417.2174658-4-sre@kernel.org>
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

