Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC2E80B3A2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 11:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjLIKhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 05:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLIKhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 05:37:51 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D384F9;
        Sat,  9 Dec 2023 02:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Rf3vs
        65ynLSbUzan0E9POY8SvySKXEyiB71xbKcoac0=; b=OTBghk1+BZU148oqFaH8/
        n7y+fBN891ivnhM5lFK3p1gB+OgmaBWrc0Shz7sxY18PjbvjXr5hwEd8zuKyV9IZ
        5tHdoeZRJ65PlYRSIZwu5vgrNaTWg9/bNyh4941Ln//lC1rkD8ywFo0qK79osR2G
        +e4q3Gj8meR/Pho6uxnwX4=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g1-2 (Coremail) with SMTP id _____wD3_0BUQ3RlqKYTAw--.5835S2;
        Sat, 09 Dec 2023 18:37:11 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Andy Yan <andyshrk@163.com>
Subject: [PATCH 1/5] dt-bindings: vendor-prefixes: Add Cool Pi
Date:   Sat,  9 Dec 2023 18:37:07 +0800
Message-Id: <20231209103707.1568381-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209103622.1568289-1-andyshrk@163.com>
References: <20231209103622.1568289-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3_0BUQ3RlqKYTAw--.5835S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF13Jr15JFWUAryxtw48tFb_yoW3ZrXEva
        1xAw1DuFW5tF4Fgw4vyF4xG345A3WxCr97u3W5tayDCF17ArZxGa97t345Cw1xuF47uasx
        Crs3WrWDJrnrGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRA4SrUUUUUU==
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEhpBXmVOA2tCFwAAsB
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

---

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

