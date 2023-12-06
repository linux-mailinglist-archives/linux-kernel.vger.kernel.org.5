Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEFA807CE8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441876AbjLGAAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjLGAAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:00:00 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDED3137
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 16:00:06 -0800 (PST)
Received: from fedori.lan (51b690cd.dsl.pool.telekom.hu [::ffff:81.182.144.205])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000716ED.0000000065710B04.00119052; Thu, 07 Dec 2023 01:00:04 +0100
From:   Gergo Koteles <soyer@irl.hu>
To:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 05/16] ALSA: hda/tas2781: fix typos in comment
Date:   Thu,  7 Dec 2023 00:59:46 +0100
Message-ID: <b97a869c029a9bd62482262e2aa4139bdb6589c0.1701906455.git.soyer@irl.hu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701906455.git.soyer@irl.hu>
References: <cover.1701906455.git.soyer@irl.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct typos.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/pci/hda/tas2781_hda_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 7c286802b273..70085177230e 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -421,9 +421,9 @@ static void tas2781_apply_calib(struct tasdevice_priv *tas_priv)
 	}
 }
 
-/* Update the calibrate data, including speaker impedance, f0, etc, into algo.
+/* Update the calibration data, including speaker impedance, f0, etc, into algo.
  * Calibrate data is done by manufacturer in the factory. These data are used
- * by Algo for calucating the speaker temperature, speaker membrance excursion
+ * by Algo for calcucating the speaker temperature, speaker membrane excursion
  * and f0 in real time during playback.
  */
 static int tas2781_save_calibration(struct tasdevice_priv *tas_priv)
-- 
2.43.0

