Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6537C6B08
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347116AbjJLKZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbjJLKZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:25:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392FAC9;
        Thu, 12 Oct 2023 03:25:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DCAC433C8;
        Thu, 12 Oct 2023 10:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697106350;
        bh=wzBgNttTkwq+ey3nh0EClZ1bDYJi51qfQW72cGgJJR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dZf0271oiB81Qb9DHNDeeIaaCtG5Bs/F5DwukXxhL2PBdOlmTBlKedMCJtrkMu5WG
         /MpuSpxGv5cBUVI9yjaCQR8MJvpvcQ1XagFHTi8smebHKMSMKTky0HjHKh9/Wq31J+
         d2oQMniPYfOxxjlAWAFh1RboinpW7Fq7xcoghwfXYF1QI20PhpChhq9d3tbI6r8z91
         Q/9hROpL7jKiO0MvqRA/t2c4CGrm3lFjpYh9Y6SU/GatLa4TJxvLouY7WuQIlGjCHS
         QB/qk3l9pX33FdunNm2oFIzKzzgppj4l99CLUUptW/7pL/dQ4LyrYGCSK+Cb1VAvSO
         Niynl0PqXZNKg==
Date:   Thu, 12 Oct 2023 11:25:44 +0100
From:   Lee Jones <lee@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, thierry.reding@gmail.com,
        ndesaulniers@google.com, trix@redhat.com, baruch@tkos.co.il,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Devi Priya <quic_devipriy@quicinc.com>
Cc:     linux-pwm@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        nathan@kernel.org
Subject: Re: [PATCH V15 0/4] Add PWM support for IPQ chipsets
Message-ID: <20231012102544.GH8314@google.com>
References: <20231005160550.2423075-1-quic_devipriy@quicinc.com>
 <169710516837.1166696.14907666532929973777.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <169710516837.1166696.14907666532929973777.b4-ty@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023, Lee Jones wrote:

> On Thu, 05 Oct 2023 21:35:46 +0530, Devi Priya wrote:
> > Add PWM driver and binding support for IPQ chipsets.
> > Also, add support for pwm node in ipq6018.
> > 
> > V15:
> > Detailed Change logs are added to the respective patches.
> > 
> > V14 can be found at:
> > https://lore.kernel.org/linux-arm-msm/20231005043127.2690639-1-quic_devipriy@quicinc.com/
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/4] pwm: driver for qualcomm ipq6018 pwm block
>       (no commit info)
> [2/4] dt-bindings: pwm: add IPQ6018 binding
>       (no commit info)
> [3/4] dt-bindings: mfd: qcom,tcsr: Add simple-mfd support for IPQ6018
>       commit: b4a32d218d424b81a58fbd419e1114b1c1f76168
> [4/4] arm64: dts: qcom: ipq6018: add pwm node
>       (no commit info)

Disregard - tooling error!

-- 
Lee Jones [李琼斯]
