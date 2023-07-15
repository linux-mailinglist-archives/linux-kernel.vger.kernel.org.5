Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2980754CB4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 00:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjGOWK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 18:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjGOWKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 18:10:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788452D65;
        Sat, 15 Jul 2023 15:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 158B260C53;
        Sat, 15 Jul 2023 22:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94981C433CB;
        Sat, 15 Jul 2023 22:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689459014;
        bh=Kp7ZUz+S/CWGM+xZ0FcxUOs6QTGVRlEY1dapmQoLuLo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RIr96HdlE0Y0e5FQ8nRcEnvZU1NA8907TXeZWdgMacMnvioz/LJQgkD6Dl+xz9eOw
         zbgLi9MIWytGReFUG4iS6CEUWpOIy6MglOMTK1Kcth3AJTnb9mYVcyccThsAoaObKS
         g7Oy7A7GQjEm3GLfHyRfgoUdKjfWksWCvuHcy/NA7noOSKTKnplwyq745QGnEG9Gr1
         151KrYJfN3ljm6qtIO1xzefV+2/3yejvyJiqZ7Bc6m6G04ZHYE5c31ZQ09ka96erna
         AMo8PZ/jiMim4ZN918zwsYiLBpVfFtloXAZ/VXvlLuyxlFDwaUxsg+BzUyb7+K9S1R
         C++03xajQeiVA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: remoteproc: qcom,adsp: bring back firmware-name
Date:   Sat, 15 Jul 2023 15:13:30 -0700
Message-ID: <168945921470.1805013.12698671993265758369.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230309083548.47205-1-krzysztof.kozlowski@linaro.org>
References: <20230309083548.47205-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 09 Mar 2023 09:35:48 +0100, Krzysztof Kozlowski wrote:
> The firmware-name property was moved from common qcom,pas-common.yaml
> binding to each device-specific schema, but the qcom,adsp.yaml was not
> updated.
> 
> 

Applied, thanks!

[1/1] dt-bindings: remoteproc: qcom,adsp: bring back firmware-name
      commit: 3aacc3b2e4ea862c21de5a0efbfa8cd59192bc43

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
