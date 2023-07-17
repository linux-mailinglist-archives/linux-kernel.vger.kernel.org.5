Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6F0755E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjGQIRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjGQIRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:17:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B123130
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:17:34 -0700 (PDT)
Received: from workpc.. (109-252-154-2.dynamic.spd-mgts.ru [109.252.154.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 33A456603203;
        Mon, 17 Jul 2023 09:17:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689581852;
        bh=cDQ2vNJdynhbZflqAFsbK6vZklSq9Zi8ClehMpPtBBs=;
        h=From:To:Cc:Subject:Date:From;
        b=gQcSPD210Nl413tX4EN9AKxAjl2Lu3jVl6iygQmOQ+d6udO7PTzMFmqu7SraPlMM4
         vX/IxYjmG1QqY7pZZegi5w3aSJyQgbDXthOZpem7w75Mtt7v5iUThLyQJsp+KFa6W7
         GWaLGifts77smDhMnNTGWKRC9WlWnlrdOEfhUrZe5rmVsQTKXh8/JG0MQoK2NoYJcS
         X9u9ZtbmfTkzOQDMg2J54xV1Sm8KyIaHEH8jQT/nr1WCaxT6SdVz8oWpN8oMUcSxWS
         40UfLI1qbcfVDyEEEaEbY54kV5xj3Z2QxGf/v/sSE0q6Fm/kLwnUX0NxT/U8by3OXv
         AgigAAND7l0sw==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v1] MAINTAINERS: Add Boris Brezillon as Panfrost driver maintainer
Date:   Mon, 17 Jul 2023 11:15:44 +0300
Message-ID: <20230717081544.1068254-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Boris Brezillon as Panfrost driver maintainer. Boris is a new lead
developer of the Panfrost Mesa driver and main developer behind the
upcoming Panthor kernel driver that will serve next-gen Mali GPUs.

Remove Tomeu and Alyssa, who left Collabora and stepped down from working
on Panfrost.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d6536fef2fc..08dc75916148 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1615,9 +1615,8 @@ F:	drivers/gpu/drm/arm/display/komeda/
 
 ARM MALI PANFROST DRM DRIVER
 M:	Rob Herring <robh@kernel.org>
-M:	Tomeu Vizoso <tomeu.vizoso@collabora.com>
+M:	Boris Brezillon <boris.brezillon@collabora.com>
 R:	Steven Price <steven.price@arm.com>
-R:	Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc
-- 
2.41.0

