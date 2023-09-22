Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45457ABA98
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 22:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjIVUrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 16:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIVUrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 16:47:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A96CA;
        Fri, 22 Sep 2023 13:46:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D09C433C8;
        Fri, 22 Sep 2023 20:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695415615;
        bh=eay6GwYQbfaEzmyzwcvObd/DgNe3CLNUVoO6E+d20yg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yymq+uiS81ryk1wf6TWAs6DfaLd+Bub4d5HtHmprEtMX0a8w+jxgubF/KSPj+P+7d
         8bbgHPhfBPBLUYRskGRbyn76wZmedtoNQEJYyOfm5aHm56nkas6iWREe95iw670Mo7
         i5QGoAZCM+wxr8wKoWW5cwEiZwcXxi7hmrHW57Jx4eiQ3cCL85CowjnI2ZMMw0hpv2
         mHxnnn9LSOhu++DQ4l3PkB34imIAo5TyMjTpNYdP1u8FT2vmwXogCPUk4aSyLa8RKR
         zw3zY5qjWkB8RRHjp/pRbFGEfYEZBRbBH9Q3JgoaqtNItWc/06+Tj0vgdlGEghj4Pp
         xOTzmAGe48/LQ==
Received: (nullmailer pid 3551557 invoked by uid 1000);
        Fri, 22 Sep 2023 20:46:52 -0000
Date:   Fri, 22 Sep 2023 15:46:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tengfei Fan <quic_tengfan@quicinc.com>
Cc:     devicetree@vger.kernel.org, will@kernel.org, quic_tdas@quicinc.com,
        rafal@milecki.pl, quic_tsoni@quicinc.com,
        linux-kernel@vger.kernel.org, kernel@quicinc.com,
        quic_shashim@quicinc.com, robh+dt@kernel.org,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        quic_aiquny@quicinc.com, andersson@kernel.org,
        geert+renesas@glider.be, agross@kernel.org,
        quic_kaushalk@quicinc.com, quic_tingweiz@quicinc.com,
        krzysztof.kozlowski+dt@linaro.org, nfraprado@collabora.com,
        arnd@arndb.de, maz@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, tglx@linutronix.de,
        konrad.dybcio@linaro.org, peng.fan@nxp.com,
        neil.armstrong@linaro.org
Subject: Re: [PATCH v4 1/6] dt-bindings: interrupt-controller: qcom,pdc:
 document qcom,sm4450-pdc
Message-ID: <169541561121.3551501.7523205377363170934.robh@kernel.org>
References: <20230922081026.2799-1-quic_tengfan@quicinc.com>
 <20230922081026.2799-2-quic_tengfan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922081026.2799-2-quic_tengfan@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Sep 2023 16:10:21 +0800, Tengfei Fan wrote:
> Add SM4450 PDC, which will used in SM4450 DTS.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!

