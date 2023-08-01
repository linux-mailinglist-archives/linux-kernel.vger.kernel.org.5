Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2103176B737
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbjHAOVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjHAOVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:21:22 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06F01B1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 07:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=D/tnD
        hhtLKuYANELtN6YERyXJ7QVSlBim2KcElYcYng=; b=KWfE4OH3C92BlkD6a54Ib
        FYCeBlSrcf9beeHBCkjXqQMXfAq3KGyNeHuE2w/Xhs4LeS9Dl9iS4dwWAJqujvht
        SCuisXctUQbC98MXB4ebu0V0KxMnkB14hpCEdQh0pjtBADvFToPPj72t4AWDaidX
        UKTqfZg7PLqCZusIgvaYYU=
Received: from lml-Birman-PHX.. (unknown [112.96.224.101])
        by zwqz-smtp-mta-g5-0 (Coremail) with SMTP id _____wB3f0OKFMlkldd6Bw--.12472S3;
        Tue, 01 Aug 2023 22:19:58 +0800 (CST)
From:   "Baojun.Xu" <jim_monkey@163.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc:     shenghao-ding@ti.com, kevin-lu@ti.com,
        krzysztof.kozlowski@linaro.org, rf@opensource.cirrus.com,
        shumingf@realtek.com, herve.codina@bootlin.com,
        povik+lin@cutebit.org, ryans.lee@analog.com,
        ckeepax@opensource.cirrus.com, sebastian.reichel@collabora.com,
        fido_max@inbox.ru, wangweidong.a@awinic.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        peeyush@ti.com, navada@ti.com, tiwai@suse.de,
        mengdong.lin@intel.com, Baojun Xu <baojun.xu@ti.com>
Subject: [PATCH v1 2/2] MAINTAINERS: Add the MAINTAINERS entries for TEXAS INSTRUMENTS AUDIO DRIVERS
Date:   Tue,  1 Aug 2023 22:18:58 +0800
Message-Id: <20230801141858.130745-2-jim_monkey@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801141858.130745-1-jim_monkey@163.com>
References: <20230801141858.130745-1-jim_monkey@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB3f0OKFMlkldd6Bw--.12472S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4UXr1ftw15Ar4kGr4DJwb_yoW8uw1rpa
        1kCFZ5tFy7JF12k3yfK3W8Gw1rWry8uF42kasFqw1DtF1DJFsY9w13tr1DXFWvvFWUGFZx
        Jry3uw4rGrZxZwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ja_M-UUUUU=
X-Originating-IP: [112.96.224.101]
X-CM-SenderInfo: 5mlpsz5rqnv5i6rwjhhfrp/1tbiMRC+82NfshHiVgAAsH
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baojun Xu <baojun.xu@ti.com>

Add the MAINTAINERS entries for TEXAS INSTRUMENTS AUDIO DRIVERS.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>

---
Change in v1:
 - Add the MAINTAINERS entries for TI.
---
 MAINTAINERS | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 53b7ca804465..2c16168167e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21063,6 +21063,38 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
 F:	sound/soc/ti/
 
+TEXAS INSTRUMENTS AUDIO (ASoC/HDA) DRIVERS
+M:	Shenghao Ding <shenghao-ding@ti.com>
+M:	Kevin Lu <kevin-lu@ti.com>
+M:	Baojun Xu <baojun.xu@ti.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/tas2552.txt
+F:	Documentation/devicetree/bindings/sound/tas2562.yaml
+F:	Documentation/devicetree/bindings/sound/tas2770.yaml
+F:	Documentation/devicetree/bindings/sound/tas27xx.yaml
+F:	Documentation/devicetree/bindings/sound/ti,pcm1681.txt
+F:	Documentation/devicetree/bindings/sound/ti,pcm3168a.yaml
+F:	Documentation/devicetree/bindings/sound/ti,tlv320*.yaml
+F:	Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
+F:	Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
+F:	Documentation/devicetree/bindings/sound/tpa6130a2.txt
+F:	include/sound/tas2*.h
+F:	include/sound/tlv320*.h
+F:	include/sound/tpa6130a2-plat.h
+F:	sound/soc/codecs/pcm1681.c
+F:	sound/soc/codecs/pcm1789*.*
+F:	sound/soc/codecs/pcm179x*.*
+F:	sound/soc/codecs/pcm186x*.*
+F:	sound/soc/codecs/pcm3008.*
+F:	sound/soc/codecs/pcm3060*.*
+F:	sound/soc/codecs/pcm3168a*.*
+F:	sound/soc/codecs/pcm5102a.c
+F:	sound/soc/codecs/pcm512x*.*
+F:	sound/soc/codecs/tas2*.*
+F:	sound/soc/codecs/tlv320*.*
+F:	sound/soc/codecs/tpa6130a2.*
+
 TEXAS INSTRUMENTS DMA DRIVERS
 M:	Peter Ujfalusi <peter.ujfalusi@gmail.com>
 L:	dmaengine@vger.kernel.org
-- 
2.34.1

