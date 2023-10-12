Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589EB7C6BDE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378176AbjJLLDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378064AbjJLLDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:03:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E92C0;
        Thu, 12 Oct 2023 04:03:22 -0700 (PDT)
Received: from localhost (dynamic-002-247-255-251.2.247.pool.telefonica.de [2.247.255.251])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 73FDE6607346;
        Thu, 12 Oct 2023 12:03:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697108600;
        bh=bYLYR835uDXMEL/Pj2+98z3BbfLx3uwnjanJiXP0eRY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=M8WRKIrufoPuA0y2o8KAD5lOLXp05K4TcCT6D/YBvTqW9SZspyuSb+BChdOUijhC6
         Y3lyeDLigzcesQrD9uds1POB4CtM+ww9rQCVmc3sPMv/StP7Jl7VAhTFtrOTpuDF7p
         o1C54t8LY/rbNGYBpqUIgbd0/00Gd/2D4R8NrOGvkKr3qy+oi0Imbvw7kEu9/oxCyk
         w3ntuhiNH3M1RYMI8ufPP7CnQCYxwBJl6v3zT3cYXsvdQ00/ulul2Wye7jGzmXkJ4X
         hwnnJfFq8t1drMltjl/Weq1CtEhUUGQrySHIzjQtakKI/aL1YZGGGbNkRV3BO/E3GD
         fl7kPUxjsRmsQ==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
Date:   Thu, 12 Oct 2023 13:01:05 +0200
Subject: [PATCH v13 7/8] media: chips-media: wave5: Add wave5 driver to
 maintainers file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-wave5_v13_media_master-v13-7-5ac60ccbf2ce@collabora.com>
References: <20230929-wave5_v13_media_master-v13-0-5ac60ccbf2ce@collabora.com>
In-Reply-To: <20230929-wave5_v13_media_master-v13-0-5ac60ccbf2ce@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-media@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        linux-kernel@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        kernel@collabora.com, Robert Beckett <bob.beckett@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Darren Etheridge <detheridge@ti.com>
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697108536; l=1012;
 i=sebastian.fricke@collabora.com; s=linux-media; h=from:subject:message-id;
 bh=oe7G1BPYvCGvF+TquXvdzFGyRHh7qNc/vt2UNcQusZA=;
 b=9duOpEAhif/UVjAG2dgZBqmNq3DsLKTrP7CF8XCh8Pp5cvauU6HcgE32d/ykPeZf52bcWtZUpgDh
 fc8Vcb2IDi8SMDbxZc+S8YyKhMVYbu/AyuXS+Mf3b7FeTM+B/nN+
X-Developer-Key: i=sebastian.fricke@collabora.com; a=ed25519;
 pk=pYXedPwrTtErcj7ERYeo/IpTrpe4QbJuEzSB52fslBg=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Beckett <bob.beckett@collabora.com>

Add the Chips&Media wave5 encoder/decoder driver to the maintainers file

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 063a11791bbf..b6a592c14caa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23206,6 +23206,14 @@ F:	include/linux/watchdog.h
 F:	include/trace/events/watchdog.h
 F:	include/uapi/linux/watchdog.h
 
+WAVE5 VPU CODEC DRIVER
+M:	Nas Chung <nas.chung@chipsnmedia.com>
+M:	Jackson Lee <jackson.lee@chipsnmedia.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/media/cnm,wave5.yaml
+F:	drivers/media/platform/chips-media/wave5/
+
 WHISKEYCOVE PMIC GPIO DRIVER
 M:	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
 L:	linux-gpio@vger.kernel.org

-- 
2.25.1
