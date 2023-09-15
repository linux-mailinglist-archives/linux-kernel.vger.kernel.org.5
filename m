Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA2F7A1964
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjIOIym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbjIOIyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:54:25 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA852728
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:54:16 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:7135:da8b:ba1d:1a7c])
        by albert.telenet-ops.be with bizsmtp
        id m8uE2A00K3q21w7068uEY6; Fri, 15 Sep 2023 10:54:14 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qh4aJ-003lFt-3P;
        Fri, 15 Sep 2023 10:54:14 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qh4ac-00Gdaj-4I;
        Fri, 15 Sep 2023 10:54:14 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 01/41] MAINTAINER: Create entry for Renesas SH-Mobile DRM drivers
Date:   Fri, 15 Sep 2023 10:53:16 +0200
Message-Id: <7cbcec72214886b67afa8d724a9245661d8cd675.1694767208.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694767208.git.geert+renesas@glider.be>
References: <cover.1694767208.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split off DRM drivers for Renesas SH-Mobile into its own entry, and add
Geert Uytterhoeven as a maintainer.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Kieran: do you want to join the club, too? ;-)

v4:
  - No changes,

v3:
  - No changes,

v2:
  - New.
---
 MAINTAINERS | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ceab03332d749fc..70535048b6a96d55 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7015,7 +7015,7 @@ F:	drivers/gpu/host1x/
 F:	include/linux/host1x.h
 F:	include/uapi/drm/tegra_drm.h
 
-DRM DRIVERS FOR RENESAS
+DRM DRIVERS FOR RENESAS R-CAR
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 M:	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
 L:	dri-devel@lists.freedesktop.org
@@ -7026,7 +7026,15 @@ F:	Documentation/devicetree/bindings/display/bridge/renesas,dsi-csi2-tx.yaml
 F:	Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.yaml
 F:	Documentation/devicetree/bindings/display/bridge/renesas,lvds.yaml
 F:	Documentation/devicetree/bindings/display/renesas,du.yaml
-F:	drivers/gpu/drm/renesas/
+F:	drivers/gpu/drm/renesas/rcar-du/
+
+DRM DRIVERS FOR RENESAS SHMOBILE
+M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+M:	Geert Uytterhoeven <geert+renesas@glider.be>
+L:	dri-devel@lists.freedesktop.org
+L:	linux-renesas-soc@vger.kernel.org
+S:	Supported
+F:	drivers/gpu/drm/renesas/shmobile/
 F:	include/linux/platform_data/shmob_drm.h
 
 DRM DRIVERS FOR ROCKCHIP
-- 
2.34.1

