Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6651E7FC87C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbjK1VsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbjK1VsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:48:11 -0500
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225EE18E;
        Tue, 28 Nov 2023 13:48:17 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-58d98188dc0so1223281eaf.3;
        Tue, 28 Nov 2023 13:48:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701208096; x=1701812896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7VeCqj7xAWGgdqeCPC+zBx1L4TjliSLt+8rEsZfECMc=;
        b=FLyp43fWJayG/Am1OkrLiRDjP+7ADeThTpIfogdHjRRUQwcDMiDxq3ow2qlTAqDgkh
         xnU1bxHVumx42l5I0+HeU32t1Xj2DCPEKKCW2EqwV3batXCEmlKVDg7DJ/y2ztROte1N
         3IrVctQ5LtHiIYVnzLZZbOOkEtTUAfpbaOJx+7Nz/7GryXquZ6wt7zUCr7C1+hOr+tio
         6VZE4SkOLQLyvQMtv8Avf0NoY6BSlAm2Ma/61b6sEorZlpNyE60ZTz6++o/cRuBFrVTq
         CKimgjM8BxLANkzpayZf15XSihd4ZzTFwyyZN+yrnss76a0CXSsvcm5VrMFc9U76zrrv
         YPRg==
X-Gm-Message-State: AOJu0YyTVZfMu+LciDWDv8EsB8mCEYCLr8EK+h6xa4o0EWHFwDpcshvH
        RiAAXjOSC3WQFhoCDghBPiFcwiftvg==
X-Google-Smtp-Source: AGHT+IEj1G9Dh/0hwnl1115jTQx3rIQfJdyMFm1+p5JJqV7h1qobUaiEGtlUOkF/vjtYMTxo8erufA==
X-Received: by 2002:a05:6820:81f:b0:58d:72cb:2232 with SMTP id bg31-20020a056820081f00b0058d72cb2232mr9431652oob.6.1701208096203;
        Tue, 28 Nov 2023 13:48:16 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bl13-20020a056820194d00b00581fedcb06csm1987026oob.19.2023.11.28.13.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 13:48:15 -0800 (PST)
Received: (nullmailer pid 3975858 invoked by uid 1000);
        Tue, 28 Nov 2023 21:48:13 -0000
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: input: sprd,sc27xx-vibrator: Drop incomplete example
Date:   Tue, 28 Nov 2023 15:48:09 -0600
Message-ID: <20231128214809.3975719-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The example for the Spreadtrum SC27xx PMIC vibrator is incomplete as the
binding is the full PMIC, not just the sub-functions. It is preferred
for MFD examples to be complete in the top-level MFD device binding
rather than piecemeal in each sub-function binding.

This also fixes an undocumented (by schema) compatible warning for
"sprd,sc2731".

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/input/sprd,sc27xx-vibrator.yaml  | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/sprd,sc27xx-vibrator.yaml b/Documentation/devicetree/bindings/input/sprd,sc27xx-vibrator.yaml
index a401a0bfcbec..4c8d303ff93c 100644
--- a/Documentation/devicetree/bindings/input/sprd,sc27xx-vibrator.yaml
+++ b/Documentation/devicetree/bindings/input/sprd,sc27xx-vibrator.yaml
@@ -28,21 +28,4 @@ required:
 
 additionalProperties: false
 
-examples:
-  - |
-    #include <dt-bindings/interrupt-controller/arm-gic.h>
-    sc2731_pmic: pmic@0 {
-      compatible = "sprd,sc2731";
-      reg = <0 0>;
-      spi-max-frequency = <26000000>;
-      interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-      interrupt-controller;
-      #interrupt-cells = <2>;
-      #address-cells = <1>;
-      #size-cells = <0>;
-
-      vibrator@eb4 {
-        compatible = "sprd,sc2731-vibrator";
-        reg = <0xeb4>;
-      };
-    };
+...
-- 
2.42.0

