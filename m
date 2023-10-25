Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586C97D6A0C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343573AbjJYL04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjJYL0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:26:49 -0400
Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com [115.124.28.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71D3116;
        Wed, 25 Oct 2023 04:26:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4519266|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0212848-0.000550225-0.978165;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=27;RT=27;SR=0;TI=SMTPD_---.V7r.p7O_1698233195;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.V7r.p7O_1698233195)
          by smtp.aliyun-inc.com;
          Wed, 25 Oct 2023 19:26:42 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, wangweidong.a@awinic.com,
        herve.codina@bootlin.com, shumingf@realtek.com,
        rf@opensource.cirrus.com, arnd@arndb.de, 13916275206@139.com,
        ryans.lee@analog.com, linus.walleij@linaro.org,
        ckeepax@opensource.cirrus.com,
        ajye_huang@compal.corp-partner.google.com, fido_max@inbox.ru,
        liweilei@awinic.com, yijiangtao@awinic.com, trix@redhat.com,
        colin.i.king@gmail.com, dan.carpenter@linaro.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V3 1/3] ASoC: dt-bindings: Add schema for "awinic,aw88399"
Date:   Wed, 25 Oct 2023 19:26:23 +0800
Message-ID: <20231025112625.959587-2-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025112625.959587-1-wangweidong.a@awinic.com>
References: <20231025112625.959587-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weidong Wang <wangweidong.a@awinic.com>

Add the awinic,aw88399 property to the awinic,aw88395.yaml file.

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/sound/awinic,aw88395.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml b/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
index 5d5ebc72b721..ac5f2e0f42cb 100644
--- a/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
+++ b/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
@@ -19,6 +19,7 @@ properties:
     enum:
       - awinic,aw88395
       - awinic,aw88261
+      - awinic,aw88399
 
   reg:
     maxItems: 1
-- 
2.41.0

