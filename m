Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D45C7D6571
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbjJYImP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjJYImK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:42:10 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [IPv6:2a01:4f8:a0:821d::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A920312D;
        Wed, 25 Oct 2023 01:42:08 -0700 (PDT)
From:   Stefan Hansson <newbyte@postmarketos.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1698223327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nCEfQhvJFpQP4wGwWs4rZwAtN4BGZznylrcgbwf2GdY=;
        b=G+JFbdvGIZWkFTVpd+9UD14aXMcg9FtKCnfk6mmgF4mjC76jZZ2pubd441hcz36it1eQoy
        kl+6vX+5S4C/Wzy3UWz4pjjZi58l/b5SlWeDhWTP+gD6eisJV758j/kv3mVBlZEe0uhh5O
        1Jc4WUcva3rqls31oN512pDDfvkt8tA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Stefan Hansson <newbyte@postmarketos.org>
Subject: [PATCH v3 2/4] dt-bindings: arm: qcom: Add Samsung Galaxy Tab 4 10.1 LTE
Date:   Wed, 25 Oct 2023 10:37:50 +0200
Message-ID: <20231025083952.12367-3-newbyte@postmarketos.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025083952.12367-1-newbyte@postmarketos.org>
References: <20231025083952.12367-1-newbyte@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This documents Samsung Galaxy Tab 4 10.1 LTE (samsung,matisselte)
which is a tablet by Samsung based on the MSM8926 SoC.

Signed-off-by: Stefan Hansson <newbyte@postmarketos.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 88b84035e7b1..242ffe89c6c6 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -196,6 +196,7 @@ properties:
           - enum:
               - microsoft,superman-lte
               - microsoft,tesla
+              - samsung,matisselte
           - const: qcom,msm8926
           - const: qcom,msm8226
 
-- 
2.41.0

