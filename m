Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF358779656
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbjHKRly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbjHKRlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:41:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438B7115;
        Fri, 11 Aug 2023 10:41:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD22C67832;
        Fri, 11 Aug 2023 17:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AFFC433C7;
        Fri, 11 Aug 2023 17:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691775711;
        bh=oAS75jsYPlLWzXcf3yjyDEYYAzOEN84fVm3stpvBYLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N6JUo2UOKJLyEgBnkcnHg84TeRJ0mIfn0atfj5tQ0vam/x1WEyceQgJ1mgd7HoRGf
         GCY2NQALBfCCLGnayIGCDIv/+WK+gx4iaYh8HBDietFioBODHEdQaRIU7L6Vx0tbu7
         7/LlvsrglB+nxTaXufCXWAoze/0GL0U8OLVJ/GUaBGnNvnUeYsLwCWkYa2EBtQuBZY
         xV6EYg6wwbmozemcIxpAgsvYOOmIt6O2n+Q8J+40Cn7Z9dcZu2LLjAhCfUYG3gGR8d
         aMzePdaQ7npjuzn/W9vfUZe+uyXcg/84umEyJsW8E5ShtLDoagr9dqSY/ByKKcZ70W
         dR9Q5hEn//Igg==
Received: (nullmailer pid 3657521 invoked by uid 1000);
        Fri, 11 Aug 2023 17:41:48 -0000
Date:   Fri, 11 Aug 2023 11:41:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        quic_kamalw@quicinc.com, linux-kernel@vger.kernel.org,
        quic_collinsd@quicinc.com, linux-arm-msm@vger.kernel.org,
        jestar@qti.qualcomm.com, dmitry.baryshkov@linaro.org,
        agross@kernel.org, quic_subbaram@quicinc.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        krzysztof.kozlowski+dt@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>, andersson@kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: input: qcom,pm8xxx-vib: add new SPMI
 vibrator module
Message-ID: <169177570850.3657456.16255304105054183727.robh@kernel.org>
References: <20230731053712.2220898-1-quic_fenglinw@quicinc.com>
 <20230731053712.2220898-3-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731053712.2220898-3-quic_fenglinw@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Jul 2023 13:37:07 +0800, Fenglin Wu wrote:
> Add compatible string 'qcom,spmi-vib-gen2' to support vibrator module
> inside PMI632, PMI7250B, PM7325B, PM7550BA.
> 
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
>  .../bindings/input/qcom,pm8xxx-vib.yaml          | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

