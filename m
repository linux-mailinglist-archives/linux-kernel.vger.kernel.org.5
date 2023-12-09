Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D33D80B3A9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 11:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjLIKiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 05:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjLIKiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 05:38:52 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70E3F1738;
        Sat,  9 Dec 2023 02:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=HGd4c
        FTAiQEuNSI2aid0XiqDdvTFEBHEKRBU7n7UoEQ=; b=im0hwOoE1HK1LcfxceqcW
        /l2CnEbQE6K1P6UIG1BrGMzTLSTJHrYjG5gMHCeml+xrYtV/F0NRdn0D6KbAIcOS
        NI2DiJHO/6Ahz2lRSJmblgGYOwikteJOKvrSc2FDBg1NfH+YfjL8vtUp4e+AN+Cd
        3qLl8cY5XtlgoRFnVal1P4=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g1-2 (Coremail) with SMTP id _____wD3X0WYQ3RljL4TAw--.5892S2;
        Sat, 09 Dec 2023 18:38:19 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Andy Yan <andyshrk@163.com>
Subject: [PATCH 4/5] dt-bindings: arm: rockchip: Add Cool Pi CM5 EVB
Date:   Sat,  9 Dec 2023 18:38:15 +0800
Message-Id: <20231209103815.1568614-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209103622.1568289-1-andyshrk@163.com>
References: <20231209103622.1568289-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3X0WYQ3RljL4TAw--.5892S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrykXF1rGw1rJrWrtFyDtrb_yoW3CwcEka
        yxZrn5CF4rtFyY9w4j9a1xGFy5Jw47KF9ru3WUtF1DA34Dt393taykt34SkFyxur47urn3
        CF4fXryDuFnxGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRAuc_UUUUUU==
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBnABBXlghl5vSzwAAsr
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

Add Cool Pi CM5 EVB, a board powered by RK3588

Signed-off-by: Andy Yan <andyshrk@163.com>
---

 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 5de9f3090be1..24dc6dfb8285 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -95,6 +95,11 @@ properties:
           - const: chipspark,rayeager-px2
           - const: rockchip,rk3066a
 
+      - description: Cool Pi Compute Module 5(CM5) EVB
+        items:
+          - const: CoolPi CM5 EVB
+          - const: rockchip,rk3588
+
       - description: Cool Pi 4 Model B
         items:
           - const: CoolPi 4 Model B
-- 
2.34.1

