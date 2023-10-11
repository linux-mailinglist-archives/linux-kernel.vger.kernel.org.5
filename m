Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3311F7C59D4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346937AbjJKRCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjJKRCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:02:38 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4D0A4;
        Wed, 11 Oct 2023 10:02:36 -0700 (PDT)
Received: from [192.168.178.23] (k10064.upc-k.chello.nl [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 91595C8910;
        Wed, 11 Oct 2023 17:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1697043754; bh=wWDTX8e5KM6wfhYspOStX6JRz8pBMYK5n8PtCv39+Zs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=OPNovH839seUgQerLIWX/NZpue8kvK1fpcfBSTpgAKwYu0rw7ZLiXYgJ8ABEPmcqW
         395bANmZiTcwIZQmC5VOvCDcDShFcdch476LEtIjDaXK++QJw/kcTZQUX1Wcx7zOsX
         W40W4jGGMvCJGBXZ7RYCALT8jWA5o8j+hnrTgH2g=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Wed, 11 Oct 2023 19:02:25 +0200
Subject: [PATCH 2/3] dt-bindings: arm: qcom: Add HTC One Mini 2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231011-htc-memul-v1-2-76e57873190c@z3ntu.xyz>
References: <20231011-htc-memul-v1-0-76e57873190c@z3ntu.xyz>
In-Reply-To: <20231011-htc-memul-v1-0-76e57873190c@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=704; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=wWDTX8e5KM6wfhYspOStX6JRz8pBMYK5n8PtCv39+Zs=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlJtUo3djfUJ6BEARFA7A2JwBWfbjGRITMqnUwq
 50KZiTr/HuJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZSbVKAAKCRBy2EO4nU3X
 Vp+mEACQymouEeaIUKbTt99esZu0tiqcqo5hQAfQEP2dzVez/IVZzQ4YrkVVISyq1LZIWh8YfSI
 A5duv0jGxPR+VG4zSpJftvOaJF0/n1ANQQRHEDjRKvp00dIz8H01Nmmw6cukMnfShP5NHTzqO+0
 e4mUeRcXk4Bnm1p1TThDgAD99XWzzMxb9QlnLFs5Uno8HJZCxnUGbLr3mnB79Rnd0Xva5tB78XM
 BgbjHzoQSzTA7dSkY9RvLojtkR605C9PqE3Ld2J0miuvz6sCf81q+cTW9mrhdoXAGhRhieZffS/
 LHwQfJ8IeZdszbBaK77q6DGOWeiGYFkB9thOZ0ml0m9gYcaogj3p4euL6/25gBGUdAPgNLuNtZ5
 qpjO7pMGi7Gw/Vv0S3WRJ76cQ4G9e0jenjr2apsyNl2FXhA8ppUtYBB6I4dR7BE9fAKPGcNrRD7
 SD8IpeCRmgDRpaoXAvX/sI7q7sMeGV3DuKzJI6kvlV1yBsNUiMAMkJWknrb0xosrOp9pI898iYF
 HtGj4zGEuolwOP56dytisM9Y5FNRGhkxPsj038SoAb6TAZrfH7dzncrSTtnRAggJN2xojXqN/Ok
 0Dj3pleFU3ptMcdyPEha508rE9okPpVRjl681dps1YR71wbjTyUxIQSNsGcvFnzRNm7Ocfx5M95
 +dCaUM+lxO1OFzQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for the MSM8926-based HTC One Mini 2 smartphone.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 2a607b1595c9..1b7f094aa100 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -192,6 +192,7 @@ properties:
 
       - items:
           - enum:
+              - htc,memul
               - microsoft,superman-lte
               - microsoft,tesla
           - const: qcom,msm8926

-- 
2.42.0

