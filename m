Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E5878178B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 07:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245066AbjHSFww convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 19 Aug 2023 01:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244611AbjHSFwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 01:52:19 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489F24206
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 22:52:17 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37J5q4eJ010022;
        Sat, 19 Aug 2023 13:52:04 +0800 (+08)
        (envelope-from Yanxin.Huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RSSW02xrcz2PbwF0;
        Sat, 19 Aug 2023 13:49:48 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Sat, 19 Aug
 2023 13:52:02 +0800
From:   Yanxin Huang <yanxin.huang@unisoc.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        huang yanxin <yanxin.huang07@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
Subject: [PATCH 2/7] dt-bindings: nvmem: Add compatible for sharkl3, ums512, qogirl6, qogirn6pro, qogirn6lite
Date:   Sat, 19 Aug 2023 13:51:36 +0800
Message-ID: <20230819055141.29455-2-yanxin.huang@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230819055141.29455-1-yanxin.huang@unisoc.com>
References: <20230819055141.29455-1-yanxin.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
Content-Transfer-Encoding: 8BIT
X-MAIL: SHSQR01.spreadtrum.com 37J5q4eJ010022
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added unisoc sharkl3, ums512, qogirl6, qogirn6pro, qogirn6lite platform
compatible information.

Signed-off-by: Yanxin Huang <yanxin.huang@unisoc.com>
---
 Documentation/devicetree/bindings/nvmem/sprd-efuse.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/sprd-efuse.yaml b/Documentation/devicetree/bindings/nvmem/sprd-efuse.yaml
index 77106aca52c2..5c5063c89734 100644
--- a/Documentation/devicetree/bindings/nvmem/sprd-efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/sprd-efuse.yaml
@@ -17,7 +17,12 @@ allOf:
 properties:
   compatible:
     enum:
+      - sprd,sharkl3-efuse
       - sprd,ums312-efuse
+      - sprd,ums512-efuse
+      - sprd,qogirl6-efuse
+      - sprd,qogirn6pro-efuse
+      - sprd,qogirn6lite-efuse

   reg:
     description:
--
2.17.1

________________________________
 This email (including its attachments) is intended only for the person or entity to which it is addressed and may contain information that is privileged, confidential or otherwise protected from disclosure. Unauthorized use, dissemination, distribution or copying of this email or the information herein or taking any action in reliance on the contents of this email or the information herein, by anyone other than the intended recipient, or an employee or agent responsible for delivering the message to the intended recipient, is strictly prohibited. If you are not the intended recipient, please do not read, copy, use or disclose any part of this e-mail to others. Please notify the sender immediately and permanently delete this e-mail and any attachments if you received it in error. Internet communications cannot be guaranteed to be timely, secure, error-free or virus-free. The sender does not accept liability for any errors or omissions.
本邮件及其附件具有保密性质，受法律保护不得泄露，仅发送给本邮件所指特定收件人。严禁非经授权使用、宣传、发布或复制本邮件或其内容。若非该特定收件人，请勿阅读、复制、 使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件的方式即刻告知发件人。无法保证互联网通信及时、安全、无误或防毒。发件人对任何错漏均不承担责任。
