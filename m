Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED9180EC4A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjLLMms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjLLMmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:42:47 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9106194;
        Tue, 12 Dec 2023 04:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=nNmAy
        t5R/FqSzYRKUKMJgqk+9Njbt4i+66funeH8Iu4=; b=GalmYYAIamECCi0CEbJUG
        e/S4lOTB5L07QAHGXfCtkgPhWb0Pmg8sKIW7ntL8FBuvr9yGZG5hkDGM9bX/Irom
        BAX1Al7JhiPj8pcvjjJyxpTv9ufBMxgtREP/HSpOHoDPL/kexqlW1T14hNBILZIn
        B6l09uSXpZfEC1Vd1Ms1f4=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g0-4 (Coremail) with SMTP id _____wD3H6gwVXhloBDrBA--.14812S2;
        Tue, 12 Dec 2023 20:42:27 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, Andy Yan <andyshrk@163.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/5] dt-bindings: vendor-prefixes: Add Cool Pi
Date:   Tue, 12 Dec 2023 20:42:23 +0800
Message-Id: <20231212124223.1897314-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212124202.1897238-1-andyshrk@163.com>
References: <20231212124202.1897238-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3H6gwVXhloBDrBA--.14812S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF13Jr1Uuw4UWr1rWF15Jwb_yoWfArb_Xa
        1xAw1DZF43JF4Fgw4vyF4xG345Aw12kr9ru3WrtayDCF12yrZrGa97t345Zw1xCF43uas8
        Crs3GrWDGrnrGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRAcTQUUUUUU==
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBnAFEXlghl9curgAAs+
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Cool Pi(https://cool-pi.com/)

Signed-off-by: Andy Yan <andyshrk@163.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

(no changes since v1)

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 309b94c328c8..ddbba46fcbad 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -294,6 +294,8 @@ patternProperties:
     description: CompuLab Ltd.
   "^congatec,.*":
     description: congatec GmbH
+  "^coolpi,.*":
+    description: cool-pi.com
   "^coreriver,.*":
     description: CORERIVER Semiconductor Co.,Ltd.
   "^corpro,.*":
-- 
2.34.1

