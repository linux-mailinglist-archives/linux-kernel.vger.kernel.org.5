Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3544180B3A4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 11:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjLIKif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 05:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjLIKie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 05:38:34 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E54A10E0;
        Sat,  9 Dec 2023 02:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=UJTxz
        ULlo1PSHuzPI7aSyCkSWzQgmoVbwP2iESWvZng=; b=WxH7/13UvQqwMZMkOoIuC
        Vt5+8nXtO1B587jQnF7qZg5LUR+RZa+j5BsE0Wd8PnIdi5NgiVsvwE/l3Rv4y+or
        eg2gUx0iBxtq306VHbJAqokoLgq6UO2rnFsXV5rs61UbKfSvcL6HbHeNDr/GDnIT
        3u4ColCi981iV0gGPqWgv8=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g0-2 (Coremail) with SMTP id _____wB3n+J9Q3Rlp3CvDQ--.60130S2;
        Sat, 09 Dec 2023 18:37:52 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Andy Yan <andyshrk@163.com>
Subject: [PATCH 2/5] dt-bindings: arm: rockchip: Add Cool Pi 4B
Date:   Sat,  9 Dec 2023 18:37:48 +0800
Message-Id: <20231209103748.1568462-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209103622.1568289-1-andyshrk@163.com>
References: <20231209103622.1568289-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB3n+J9Q3Rlp3CvDQ--.60130S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrWkAF4UArWDGF4rAryUtrb_yoWfWrcEka
        4xZF15WFWFvFyY9w4qkF4kGryjkw47KF9ru3Z8AF1kA3yDt393tFWkt34akFy7ur43urn3
        CF1rtr9xuFnxGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRAl19UUUUUU==
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEgVBXmVOA2tDlgAAse
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

Add Cool Pi 4B, a SBC powered by RK3588S

Signed-off-by: Andy Yan <andyshrk@163.com>
---

 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 5deb66a5c7d9..5de9f3090be1 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -95,6 +95,11 @@ properties:
           - const: chipspark,rayeager-px2
           - const: rockchip,rk3066a
 
+      - description: Cool Pi 4 Model B
+        items:
+          - const: CoolPi 4 Model B
+          - const: rockchip,rk3588s
+
       - description: Edgeble Neural Compute Module 2(Neu2) SoM based boards
         items:
           - const: edgeble,neural-compute-module-2-io   # Edgeble Neural Compute Module 2 IO Board
-- 
2.34.1

