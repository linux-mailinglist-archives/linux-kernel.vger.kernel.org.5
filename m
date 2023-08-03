Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415D176EFAD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237170AbjHCQf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235670AbjHCQfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:35:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA02C2698;
        Thu,  3 Aug 2023 09:35:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 782DA61E3D;
        Thu,  3 Aug 2023 16:35:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2729CC43395;
        Thu,  3 Aug 2023 16:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691080513;
        bh=Iv0qdMHHYSPH+rD/oCAF0Tcwgn2U3oH2eQHhmtldJIk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aNvW/eoC0EtiUH8Sr+KpxKdAV4T9X8NGk5WyeRXg7RsZz906DSP1/4Hv4B8Ly8Bxg
         XURGhtCGFUFcvjF5x74FqOeLb1gn59ZuP6UGJ519thG8VRUN7EI7pyCHOLROYeTQ9i
         3IXQ/WHWHw+1vUVXVxik2AuiU8F4AFZayDfjgRzGqmNXeKRLoFfpQVYymbX2Or3QAx
         AUz7vOTEzSS4Wp3SubEMK0CCR7lYdjeuuDsy+JCuGei1+3LMLDyVeS/Q0xYOTgTD7O
         LApjjmCWQfeMMW/E2RW+1encBNHmiHhlMpNrY8ogB/e1m1l27Js0zTH2ugyrnmsu7R
         QCPgNz5VdsQTQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: use defines for interrupts
Date:   Thu,  3 Aug 2023 09:38:04 -0700
Message-ID: <169108064637.108343.11490080785136956394.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230730180638.23539-1-krzysztof.kozlowski@linaro.org>
References: <20230730180638.23539-1-krzysztof.kozlowski@linaro.org>
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


On Sun, 30 Jul 2023 20:06:38 +0200, Krzysztof Kozlowski wrote:
> Replace hard-coded interrupt parts (GIC, flags) with standard defines
> for readability.  No changes in resulting DTBs.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: use defines for interrupts
      commit: b79663a5515f01307f25206c313997ef6267e0fd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
