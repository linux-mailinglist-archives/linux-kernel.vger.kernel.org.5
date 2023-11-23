Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDF77F5C3A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344568AbjKWKYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKWKYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:24:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82DC1BF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:24:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C94AC433C8;
        Thu, 23 Nov 2023 10:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700735062;
        bh=Pcax73EaGd+1XlewYRlZvBtaVgqAdBc/HhyX2fk61bs=;
        h=From:To:Cc:Subject:Date:From;
        b=mQoxao9KDEU2xlG69GtUB5FQ27rfjbeUSZiXlTH+vc8xRvawtsZV5F2y2NpvTq58Z
         jAHtd2DJVpL+9W9AjqOIpGr/XAKJQ6hglnuCmMZukCdA4LAXQx7ERuukpyo+WIOdmf
         E5+2UFFbzA+WYEDI0d9HmmNmWK3sTwwLCsL1+HBy9bsNcDYxPa0N2YNG5XnAZOLC+g
         wka8i4rETXrJ6RzBYuRhpSUEAig9wQR5UQRRO+8arj3SPDIedc3gamNg2KS7fXRm2+
         /mdPowISrR6pGlfXKbVmZNCzsCR31krIB586njosrmg2Kp2Q2Q/FMoQuDYrKTr6vaT
         beeDTn45k1lkQ==
From:   Michael Walle <mwalle@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Walle <mwalle@kernel.org>
Subject: [PATCH 1/2] dt-bindings: display: simple: add Evervision VGG644804 panel
Date:   Thu, 23 Nov 2023 11:24:03 +0100
Message-Id: <20231123102404.2022201-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Evervision VGG644804 5.7" 640x480 LVDS panel compatible string.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 3ec9ee95045f..2471c99a0c96 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -144,6 +144,8 @@ properties:
       - edt,etmv570g2dhu
         # E Ink VB3300-KCA
       - eink,vb3300-kca
+        # Evervision Electronics Co. Ltd. VGG644804 5.7" VGA TFT LCD Panel
+      - evervision,vgg644804
         # Evervision Electronics Co. Ltd. VGG804821 5.0" WVGA TFT LCD Panel
       - evervision,vgg804821
         # Foxlink Group 5" WVGA TFT LCD panel
-- 
2.39.2

