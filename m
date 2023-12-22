Return-Path: <linux-kernel+bounces-9199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C3381C238
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C2F2864A2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734E539F;
	Fri, 22 Dec 2023 00:12:14 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791FF18E;
	Fri, 22 Dec 2023 00:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b681e3.dsl.pool.telekom.hu [::ffff:81.182.129.227])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000071DC1.000000006584D45A.0013B197; Fri, 22 Dec 2023 01:12:09 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
  alsa-devel@alsa-project.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH] ALSA: hda/tas2781: fix typos in comment
Date: Fri, 22 Dec 2023 01:11:54 +0100
Message-ID: <ead5609d63e71e8e87c13e1767decca5b272d696.1703203812.git.soyer@irl.hu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Correct typos.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/pci/hda/tas2781_hda_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index fb802802939e..8f63e3099d3e 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -421,9 +421,9 @@ static void tas2781_apply_calib(struct tasdevice_priv *tas_priv)
 	}
 }
 
-/* Update the calibrate data, including speaker impedance, f0, etc, into algo.
+/* Update the calibration data, including speaker impedance, f0, etc, into algo.
  * Calibrate data is done by manufacturer in the factory. These data are used
- * by Algo for calucating the speaker temperature, speaker membrance excursion
+ * by Algo for calculating the speaker temperature, speaker membrane excursion
  * and f0 in real time during playback.
  */
 static int tas2781_save_calibration(struct tasdevice_priv *tas_priv)

base-commit: c7e37b07cc7564a07125ae48c11fd1ca2bcbeae2
-- 
2.43.0


