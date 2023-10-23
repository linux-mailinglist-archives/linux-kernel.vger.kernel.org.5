Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD43A7D2EE2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjJWJvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjJWJu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:50:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E1DDF;
        Mon, 23 Oct 2023 02:50:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F79BC433C9;
        Mon, 23 Oct 2023 09:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698054657;
        bh=RwHHbQUAdCzKCO6Oq+QXNcjqKeiLN400+98q3u9Jz80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f3fAeca9Eg9/3yzV9TWME/WZoxghB8vLAPkq+49h5e/7SvCmAt/P3aH90/bESxdNC
         2CjrcY+VJy13O7T6omupN3l81NcSk40MjPfXDVOOxIxug+FH48xwtCeUcjyrDDDgm3
         NPDCcbignbn5Bze8HQ15YSVYrSfWR4mZwidKwXWJ92cOfkLCaYMmoQvA4OHKzAd9XD
         faoVZiJCIGeBE8OSr/PpkfmSjlOacudOAKy4AzRPriGKiUpXrUV6JHc784l2fmVA/E
         g7IUbVrLL30/d/DTIC2PMsFvHu3+/0B+foy6YYWlpQA+TEVvsMmiyti6IKa52rgTU6
         pvK8FAD3+w09A==
Date:   Mon, 23 Oct 2023 10:50:50 +0100
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thierry.reding@gmail.com, ndesaulniers@google.com, trix@redhat.com,
        baruch@tkos.co.il, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Devi Priya <quic_devipriy@quicinc.com>,
        linux-pwm@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        nathan@kernel.org
Subject: Re: (subset) [PATCH V15 3/4] dt-bindings: mfd: qcom,tcsr: Add
 simple-mfd support for IPQ6018
Message-ID: <20231023095050.GF8909@google.com>
References: <20231005160550.2423075-1-quic_devipriy@quicinc.com>
 <20231005160550.2423075-4-quic_devipriy@quicinc.com>
 <169710517252.1166696.13811645504228005200.b4-ty@kernel.org>
 <CAL_JsqKdvnb7c_oMaMsQiJQzm1YF5uV+Tb9nQSgX0_+tP1KD8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKdvnb7c_oMaMsQiJQzm1YF5uV+Tb9nQSgX0_+tP1KD8g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023, Rob Herring wrote:

> On Thu, Oct 12, 2023 at 5:06 AM Lee Jones <lee@kernel.org> wrote:
> >
> > On Thu, 05 Oct 2023 21:35:49 +0530, Devi Priya wrote:
> > > Update the binding to include pwm as the child node to TCSR block and
> > > add simple-mfd support for IPQ6018.
> > >
> > >
> >
> > Applied, thanks!
> >
> > [3/4] dt-bindings: mfd: qcom,tcsr: Add simple-mfd support for IPQ6018
> >       commit: b4a32d218d424b81a58fbd419e1114b1c1f76168
> 
> This is dependent on patch 2 being applied.

I'll pull it for now then.

Unapplied, thanks.

-- 
Lee Jones [李琼斯]
