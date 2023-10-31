Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033557DC7AF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343801AbjJaHyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343788AbjJaHyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:54:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FED3DE;
        Tue, 31 Oct 2023 00:54:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA08C433C8;
        Tue, 31 Oct 2023 07:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698738846;
        bh=rI1tj+ClpBzU1bf9NbYO6yeIi3E8ggphbloqxq8Xc3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ftVnKX0VoyCbVvu452uXlgW3AItzBiB9NQ5YhvWxkhps5eA7ZmpRty2yValF0Tpny
         1IhURRs6aJTHPaSKoGNhZ3XLkl019/a6KP+OqkKWQhQlJEz7MqHuv1pTtRSzVi4tV6
         HJRdEHFTwjKf84GShCR5aARkJxPsIi3rI+EfXEBnn920uHUWIvCJ2DS47dsExvXJJc
         EioEkqpk31qPoT+wz/Vxehc7V/JqyhMVV8uzamQkLvWhtjQXrPs8WhyNhQgBNErW9H
         9DGz3TPIiwJ2KkW7/J7PTaclHCspRdlAHuQi73yFDQMdpIN8olxENOTJmWuTvha2zu
         1tBf6vA6DDPbQ==
Date:   Tue, 31 Oct 2023 07:54:00 +0000
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: (subset) [PATCH v2 1/3] dt-bindings: mfd: qcom,spmi-pmic: Add
 pm8916 vm-bms and lbc
Message-ID: <20231031075400.GR8909@google.com>
References: <20231023-pm8916-dtsi-bms-lbc-v2-0-343e3dbf423e@trvn.ru>
 <20231023-pm8916-dtsi-bms-lbc-v2-1-343e3dbf423e@trvn.ru>
 <169824868224.758275.3309948002942732059.b4-ty@kernel.org>
 <67b0e974-779c-434c-b558-81840ec46cdd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67b0e974-779c-434c-b558-81840ec46cdd@linaro.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2023, Krzysztof Kozlowski wrote:

> On 25/10/2023 17:44, Lee Jones wrote:
> > On Mon, 23 Oct 2023 11:20:32 +0500, Nikita Travkin wrote:
> >> PM8916 (and probably some other similar pmics) have hardware blocks for
> >> battery monitoring and charging. Add patterns for respecive nodes so the
> >> devicetree for those blocks can be validated properly.
> >>
> >>
> > 
> > Applied, thanks!
> > 
> > [1/3] dt-bindings: mfd: qcom,spmi-pmic: Add pm8916 vm-bms and lbc
> >       commit: e9aec86e211ee493081e8934b8c821d660b417ee
> 
> Hi Lee,
> 
> It seems this patch depends on something not in your tree. This should
> have been clearly explained in cover letter or this patch changelog, but
> wasn't.
> 
> Please drop the patch.

Done.

-- 
Lee Jones [李琼斯]
