Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14CD80B9C0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 09:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjLJIEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 03:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjLJIEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 03:04:22 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49241EA;
        Sun, 10 Dec 2023 00:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=nNmAy
        t5R/FqSzYRKUKMJgqk+9Njbt4i+66funeH8Iu4=; b=EtwC/wOo3g4Kbx45XPgXE
        Xusic8o/MFyugcESvAJHLC4dA6f8fR47r2SvVsmN8ir5E4J3cpfwP/auXeiWSLN/
        tMUQba1yT9m5qG1mmlCRb7Xw0zF2Yk5V/jzi6jkGkXMJo067ccQSeXhFN7/M2Khv
        BUbrWc0UEmP10z9hxRX7t4=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g1-0 (Coremail) with SMTP id _____wDnL0zjcHVlYuF4Aw--.22945S2;
        Sun, 10 Dec 2023 16:03:50 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Andy Yan <andyshrk@163.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/5] dt-bindings: vendor-prefixes: Add Cool Pi
Date:   Sun, 10 Dec 2023 16:03:45 +0800
Message-Id: <20231210080345.1667161-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231210080313.1667013-1-andyshrk@163.com>
References: <20231210080313.1667013-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnL0zjcHVlYuF4Aw--.22945S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF13Jr1Uuw4UWr1rWF15Jwb_yoWfArb_Xa
        1xAw1DZF43JF4Fgw4vyF4xG345Aw12kr9ru3WrtayDCF12yrZrGa97t345Zw1xCF43uas8
        Crs3GrWDGrnrGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRA4SrUUUUUU==
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEA9CXmVOA3chbAADsS
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

