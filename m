Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34ABE786379
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238700AbjHWWhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238737AbjHWWgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:36:51 -0400
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D4910E9;
        Wed, 23 Aug 2023 15:36:46 -0700 (PDT)
Received: from newone.lan (unknown [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 1DC9F160ADF;
        Thu, 24 Aug 2023 00:36:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1692830204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2K3T2tsGavfmgPfJ4flzoVVLERRqcAbSguOxWqKjpew=;
        b=mXsKOFcNpsTBOR8TMI0D5P5zQ4kgVyUjWmjSQQ87CsTc/9wFdThUNd2gaXZgMY0eJsSsbe
        Iw/+g2qj1q1d4wwYYJt52m9biEhNC9iyQRprGFudfoUAaMSOz1VVWhs+aF9ogPZEauDG9w
        fOMOf6FMApOdSZMO2SptsTKkjImPiqM=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     David Heidelberg <david@ixit.cz>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: thermal: lmh: update maintainer address
Date:   Thu, 24 Aug 2023 00:36:22 +0200
Message-Id: <20230823223622.91789-1-david@ixit.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old email is no longer functioning.

Fixes: 17b1362d4919 ("MAINTAINERS: Update email address")
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
index 92762efc2120..5ff72ce5c887 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
@@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Limits Management Hardware(LMh)
 
 maintainers:
-  - Thara Gopinath <thara.gopinath@linaro.org>
+  - Thara Gopinath <thara.gopinath@gmail.com>
 
 description:
   Limits Management Hardware(LMh) is a hardware infrastructure on some
-- 
2.40.1

