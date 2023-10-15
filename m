Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FBD7C9B75
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 22:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjJOU0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 16:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjJOU0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 16:26:11 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAC0E5;
        Sun, 15 Oct 2023 13:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1697401566; bh=CRuF/liPUhNN5c5DuAg2ZYTNkQ2T6KZbPNHUyMEfqNY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=Yt/teconabEkOeHd+bDc4D60MsiL75ISlJ9BYz7poEM9pe9qw44pKEiwo+KklCaq2
         sdWYgwzeUedoe5GBIq/u/lXykQTh41/ZEPyMRhuKPj8OqZ0xvH1dVbaeMYDVtmQxe4
         CSPHb/7ZNcy2wAOoEDCtzKPHS9Cc1o8dHNrdCTZs=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 15 Oct 2023 22:26:02 +0200
Subject: [PATCH 2/2] arm64: dts: qcom: msm8953: Use non-deprecated
 qcom,domain in LPASS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231015-msm8953-misc-fixes-v1-2-b800deca9e46@z3ntu.xyz>
References: <20231015-msm8953-misc-fixes-v1-0-b800deca9e46@z3ntu.xyz>
In-Reply-To: <20231015-msm8953-misc-fixes-v1-0-b800deca9e46@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=785; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=CRuF/liPUhNN5c5DuAg2ZYTNkQ2T6KZbPNHUyMEfqNY=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlLErcZNnGQ3cULk1wyRP00UnGnFyYR/G1qKmDW
 c2vbm2K23mJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZSxK3AAKCRBy2EO4nU3X
 Vo+sEACNhUz/14Pa00iSt33hmZzCXyHRnTgbYeMXkruc7oovQ6qPExI2XPM7zXAaFS+VPWG1hWy
 T7SWA8629CTNh1wLW9sHPt0k+drDENYzO1Dwhv2gE3CbosprkqIo3ZPZHKaDbUGW1P+YC+iFGtZ
 qN3C+FUc5XlIJh4NHBIExEp8lLsb58AGrNbSkX3PQiuQ4DEbweiiWphcdZap5HLchlnpcuMNC12
 RH7xY8/HDMrTk4TrVC+2fyqKvQJw75vdSOD+XdGo68Og/x5NApDzwLSp6y54plhqIsTt4ToBT94
 4L+OPI2ZNPLqH7m6Lm7qsTyfGfzooBRNDr2kjUfLjBzxuJFcwQusVGd6FfjbeEAvGoQxXgK2d/q
 ZV03XCCj/yybchX+hY8UZ9YLA6knZAYlP2uvAgzsawihitsFlWb3CovcUyzdeAcFihgraMa2DM2
 hHo9qcwIKQXDay60DFmzN1AShwFtWWpenRmT/hUqA/1G1TLxpwZ/qlWN46k4sklM3XDw/TX6hFD
 OGp10RQQWfY0gj7bl/EaGnTkwjGN8DOKQ8JHb7O01R7r3YU1t6sOD+eXr4giNhz8UAwkK/6Ayva
 fp2pKrpWIH6IpaOdNPRxAaoMB7oo2rgerLKhDvYr+uH9cQNtTXG3V/mrvE5uNjmW0i/fiV7m5Cr
 tbd0tBb8FwUOziw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the qcom,domain property instead of the deprecated qcom,apr-domain,
which in turn also fixes a bunch of dtbs_checks warnings.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index a3ba24ca599b..8374f9af8273 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -1645,7 +1645,7 @@ smd-edge {
 				apr {
 					compatible = "qcom,apr-v2";
 					qcom,smd-channels = "apr_audio_svc";
-					qcom,apr-domain = <APR_DOMAIN_ADSP>;
+					qcom,domain = <APR_DOMAIN_ADSP>;
 					#address-cells = <1>;
 					#size-cells = <0>;
 

-- 
2.42.0

