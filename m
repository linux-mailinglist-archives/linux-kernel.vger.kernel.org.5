Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF457D2485
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjJVQXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjJVPqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 11:46:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D22F4;
        Sun, 22 Oct 2023 08:46:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B12C433C9;
        Sun, 22 Oct 2023 15:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697989572;
        bh=UFQMux8mJrhRG1jHtuMxgySyVsftohzaHt3B3BYT308=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=POeBEqAe91tjxitPUfPpIjYTGL6Y/vQ4chi1wcBZ/dL4mRbB/vfgRF3AzsDzCtm4x
         3L33IgO+WFuU5nTahxy1thP5or6nykuTuryI3SS+1tBaDYS4t8JdYv3lC3EEVi8YyH
         R2gueOxeKE096PVEMQ81ScQY3RsZfGFYBPw7N+BZXCQG+NdSM2pdB87wmai3MzIPuW
         VN89KVnd7Ryf4bniqj1BFr2OmR8A5D/5vNPQQrYkA8tcv34Bmvwm1JufISLXSZV46s
         lGq906v9GcTRbQTdMxLIqrr2cXmRYIcgUNkN6yOtNJs8BuTGqFVSwcMnLDv/CMW+yz
         l8HTldCNOVc3g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: msm8226: provide dsi phy clocks to mmcc
Date:   Sun, 22 Oct 2023 08:50:19 -0700
Message-ID: <169798982357.271027.4496714712357504780.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230712-msm8226-dsi-clock-fixup-v1-1-71010b0b89ca@z3ntu.xyz>
References: <20230712-msm8226-dsi-clock-fixup-v1-1-71010b0b89ca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Jul 2023 09:52:07 +0200, Luca Weiss wrote:
> Some mmcc clocks have dsi0pll & dsi0pllbyte as clock parents so we
> should provide them in the dt, which I missed in the commit adding the
> mdss nodes.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: msm8226: provide dsi phy clocks to mmcc
      commit: 836d083524888069cd358776a4e6c4ceec04962e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
