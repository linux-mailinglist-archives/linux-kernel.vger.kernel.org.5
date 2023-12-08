Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739BB80A5FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574045AbjLHOvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574048AbjLHOvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:51:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727751995
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:51:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560ADC433C7;
        Fri,  8 Dec 2023 14:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702047072;
        bh=989xLOj/gvmmImHm/TpB8v/+jnlc/gKIC1U9NihBicc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UyCoYTrOHmkBRQtIdKRKb7h4THpHInVwdD08IjL0BLCWPSxv1OD2rhsuUJb2dzZyM
         sNWA/VXMMuXbX0XlnuqVIqLG9GpfMLYPjAPsMCaYk0w3TQlklon++vfua9fIuBC6Wk
         NlEgVUR5pdAarW9l8hEIRKxFQzBOGxoVRz58uBT1OHhfEBk+S5DKkDXYW1vJ8kTBFT
         GLxj0dIv0pra1td2NdcpbSP2BP2X16XKEYDL6bUvTRgJgMzfnWRpMsHBysikhjXWy8
         BJojg3JIS4y3Blh97lHNDApDj5Amg2q2HtWMgeJn0V6/dXIsc1w6EC+CVQs7TN69jp
         ABhnhIMd9zTAA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: (subset) [PATCH v2 1/5] arm64: dts: qcom: sm8650: add ADSP GPR
Date:   Fri,  8 Dec 2023 06:55:20 -0800
Message-ID: <170204733636.342318.14290326651985669294.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204155746.302323-1-krzysztof.kozlowski@linaro.org>
References: <20231204155746.302323-1-krzysztof.kozlowski@linaro.org>
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


On Mon, 04 Dec 2023 16:57:42 +0100, Krzysztof Kozlowski wrote:
> Add the ADSP Generic Packet Router (GPR) device node as part of audio
> subsystem in Qualcomm SM8650 SoC.
> 
> 

Applied, thanks!

[1/5] arm64: dts: qcom: sm8650: add ADSP GPR
      commit: ff28260e3d9820a22d9bf826bdf219d6efa97260
[2/5] arm64: dts: qcom: sm8650: add LPASS LPI pin controller
      commit: 2d6bc13321c90217e1ffecf50a183f20c00ec3e3
[3/5] arm64: dts: qcom: sm8650: add ADSP audio codec macros
      commit: 58872a54e4a858d86301b4fb802fd60c45aad3e1
[4/5] arm64: dts: qcom: sm8650: add Soundwire controllers
      commit: 6a45a90c0c475bf6bf573c4ba89e0415506c868a
[5/5] arm64: dts: qcom: sm8650-mtp: add WSA8845 speakers
      commit: 80627a5d72b6be2652920db402fe2477f086902b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
