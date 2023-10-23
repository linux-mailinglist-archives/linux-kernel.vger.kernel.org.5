Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498807D2EEC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjJWJx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjJWJxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:53:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F24C4;
        Mon, 23 Oct 2023 02:53:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACC0C433C7;
        Mon, 23 Oct 2023 09:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698054803;
        bh=tKr3T+PU2YjF6+60KuiAqKReKHKVvj5uPgMKPlxY5Xo=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=KfTrbY6NO+vnYuJvOuy47Ffj/pTnIYj33xtycavho9Oafi7zlSX1LEEs59ABhK2YU
         7XK+C5Mw2IC2rDDBQD4iijYTMlNUwT3rKcIAYNisyXG1ueeI6ylXG5rtKJEz94sg1/
         0EMyr0IejrJpS7QF0fGxXSx6qW9zswE4oCst2JodqRY4JJvq17fTZLHke5Nmv/Sqpq
         SmUJ8dF1JCy9ips7AqFNP4A5TnQpGPHde//AzxhMjm/0DmlLsCbh+xOiPx8+VKLGek
         Jhslm2Z6tLxcJdZBxDdtT+HInsvM/yfhnXCxTa2ZV8UUaevZfyA//RtzCFkhlNhxIl
         0zZL9zTtX4VtQ==
Date:   Mon, 23 Oct 2023 10:53:17 +0100
From:   Lee Jones <lee@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, thierry.reding@gmail.com, baruch@tkos.co.il,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, Devi Priya <quic_devipriy@quicinc.com>
Subject: Re: (subset) [PATCH 2/4] dt-bindings: mfd: qcom,tcsr: Extend
 simple-mfd & pwm support for IPQ targets
Message-ID: <20231023095317.GG8909@google.com>
References: <20231006045317.1056625-1-quic_devipriy@quicinc.com>
 <20231006045317.1056625-3-quic_devipriy@quicinc.com>
 <169710526675.1167576.9872640040047520620.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <169710526675.1167576.9872640040047520620.b4-ty@kernel.org>
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

> On Fri, 06 Oct 2023 10:23:15 +0530, Devi Priya wrote:
> > Extend simple-mfd and pwm support for IPQ5332 & IPQ9574 SoCs.
> > 
> > 
> 
> Applied, thanks!
> 
> [2/4] dt-bindings: mfd: qcom,tcsr: Extend simple-mfd & pwm support for IPQ targets
>       commit: abbb729360a50ce949de94a983cb56b15b82018e

Also unapplied, since it seems to depend on:

  dt-bindings: mfd: qcom,tcsr: Add simple-mfd support for IPQ6018

-- 
Lee Jones [李琼斯]
