Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAAC7B21D9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjI1P4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjI1P41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:56:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DB3B7;
        Thu, 28 Sep 2023 08:56:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E30C433C7;
        Thu, 28 Sep 2023 15:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695916585;
        bh=+yB/ieAYMpsdupP/5zZB4lDxUaT4bemJx8J3u0gpO74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RyGd+26oibkU148y/+dyH5DGAuaaxM1izEQx7gzA41NtIQiZkZPG5dOo8ZdHYc2Jm
         sEuwg9csKx6VYw+BBY0vIILEiwkL+5FC4wHZ4ONy7O52CIQIssFSiV+bM5tTtr2vnk
         CLLN0cnmmfzaIZfeJfbZsdYw4FWKLgE4Uj1lVPLBDik2PNLtJjTJ57zDv9vfeSSjwu
         IRD6l39yum87T0792AsUMZr67DcQ4xjCASTS1pvjMGtl39QBzvWEiPjupdjY44CBwn
         BIagKsXD47z2+V2H1MwjoC6cTG5O4slAZSiV+z5rmypZomxX1ZOAi25nd4BOivIbun
         4MeTxcMmC9pCg==
Received: (nullmailer pid 577358 invoked by uid 1000);
        Thu, 28 Sep 2023 15:56:21 -0000
Date:   Thu, 28 Sep 2023 10:56:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Priyansh Jain <quic_priyjain@quicinc.com>
Cc:     Amit Kucheria <amitk@kernel.org>, linux-arm-msm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        quic_manafm@quicinc.com, kernel@quicinc.com,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: thermal: tsens: Add sa8775p
 compatible
Message-ID: <169591652205.576134.1499529748346625633.robh@kernel.org>
References: <20230926085948.23046-1-quic_priyjain@quicinc.com>
 <20230926085948.23046-2-quic_priyjain@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926085948.23046-2-quic_priyjain@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 26 Sep 2023 14:29:47 +0530, Priyansh Jain wrote:
> Add compatibility string for the thermal sensors on sa8775p platform.
> 
> Signed-off-by: Priyansh Jain <quic_priyjain@quicinc.com>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



