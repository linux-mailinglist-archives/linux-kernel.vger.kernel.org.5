Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1887C6A69
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343688AbjJLKGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbjJLKGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:06:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB019D;
        Thu, 12 Oct 2023 03:06:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49C7C433C8;
        Thu, 12 Oct 2023 10:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697105172;
        bh=GY14dfkIa5eABaBS7px4dMqCBAzQK6prAasSkaO4UHA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pVOignXfEwk7WgB0BcbvRIbFdYlZ4nuB9qWuZ0up1zdq//imymTmHifZN8p9vpuTl
         tIxLvoPL60/Vno4dvzYv3Rctgvt4L/Fv/QmUCpC4Pa/psR7S95jJis2W6VL4IQUtdk
         zY8/Jsr1Mvo1qMy3mQoF1EmczDvAl+v0GcAk8ZuHpGpFhHo1s21Ef/ry6wufa+aapQ
         BewW4Qmi32fT3YyoxJDVVmpNwFZaOdNlVpvFIgrAXhGyhLqbT7N6INlBBz9LwaQFM9
         QlZ+zjBCg6MBAY/FZiHzHdH+2be9VrD62ZvaC/0ZO5mzIpqsVMOZJbstDsYl3VyhqN
         NTLo3IxYCuXwg==
From:   Lee Jones <lee@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thierry.reding@gmail.com, ndesaulniers@google.com, trix@redhat.com,
        baruch@tkos.co.il, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Devi Priya <quic_devipriy@quicinc.com>
Cc:     linux-pwm@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        nathan@kernel.org
In-Reply-To: <20231005160550.2423075-1-quic_devipriy@quicinc.com>
References: <20231005160550.2423075-1-quic_devipriy@quicinc.com>
Subject: Re: [PATCH V15 0/4] Add PWM support for IPQ chipsets
Message-Id: <169710516837.1166696.14907666532929973777.b4-ty@kernel.org>
Date:   Thu, 12 Oct 2023 11:06:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Oct 2023 21:35:46 +0530, Devi Priya wrote:
> Add PWM driver and binding support for IPQ chipsets.
> Also, add support for pwm node in ipq6018.
> 
> V15:
> Detailed Change logs are added to the respective patches.
> 
> V14 can be found at:
> https://lore.kernel.org/linux-arm-msm/20231005043127.2690639-1-quic_devipriy@quicinc.com/
> 
> [...]

Applied, thanks!

[1/4] pwm: driver for qualcomm ipq6018 pwm block
      (no commit info)
[2/4] dt-bindings: pwm: add IPQ6018 binding
      (no commit info)
[3/4] dt-bindings: mfd: qcom,tcsr: Add simple-mfd support for IPQ6018
      commit: b4a32d218d424b81a58fbd419e1114b1c1f76168
[4/4] arm64: dts: qcom: ipq6018: add pwm node
      (no commit info)

--
Lee Jones [李琼斯]

