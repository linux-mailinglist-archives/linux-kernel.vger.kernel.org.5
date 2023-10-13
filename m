Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C21B7C8367
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjJMKmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjJMKmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:42:43 -0400
Received: from out28-172.mail.aliyun.com (out28-172.mail.aliyun.com [115.124.28.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6261DE;
        Fri, 13 Oct 2023 03:42:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4424414|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0223272-0.000603026-0.97707;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=25;RT=25;SR=0;TI=SMTPD_---.V-L318f_1697193750;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.V-L318f_1697193750)
          by smtp.aliyun-inc.com;
          Fri, 13 Oct 2023 18:42:37 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, wangweidong.a@awinic.com,
        herve.codina@bootlin.com, shumingf@realtek.com,
        rf@opensource.cirrus.com, arnd@arndb.de, 13916275206@139.com,
        ryans.lee@analog.com, linus.walleij@linaro.org,
        ckeepax@opensource.cirrus.com, fido_max@inbox.ru,
        sebastian.reichel@collabora.com, colin.i.king@gmail.com,
        liweilei@awinic.com, trix@redhat.com, dan.carpenter@linaro.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V1 1/3] ASoC: dt-bindings: Add schema for "awinic,aw88399"
Date:   Fri, 13 Oct 2023 18:42:18 +0800
Message-ID: <20231013104220.279953-2-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013104220.279953-1-wangweidong.a@awinic.com>
References: <20231013104220.279953-1-wangweidong.a@awinic.com>
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
---
 Documentation/devicetree/bindings/sound/awinic,aw88395.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml b/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
index 4051c2538caf..db36b01206b7 100644
--- a/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
+++ b/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
@@ -22,6 +22,7 @@ properties:
     enum:
       - awinic,aw88395
       - awinic,aw88261
+      - awinic,aw88399
 
   reg:
     maxItems: 1
-- 
2.41.0

