Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2472576DD0A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 03:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjHCBKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 21:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjHCBKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 21:10:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB73268D;
        Wed,  2 Aug 2023 18:10:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6906961B6F;
        Thu,  3 Aug 2023 01:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A77C433C7;
        Thu,  3 Aug 2023 01:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691025046;
        bh=hS+wWHOSc7suOikukB3SlS71jwtRkqueEvadGpvCvIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gSPFL6lIRpOiqkYZ7G0IYcS0ico/2UKwGtButbMrl4t4Q6xSR+I/lhW1NGfFT36+S
         GIZOsTcy8yUalK2alWFPVqlkJl2aDQuD3IFptVAFBvUMTwt+WcA8EsAvOqvPwhi9+/
         pCHtxCn9U7mCx1LOHJN/63bGE1LtoEZ76fvzmj3EhhRMBWCixA5xKuz65Z97ccsY5w
         uvUAnPtgA8vdSvM/s1kJ5IZupBtQbUdtNuih7EQRsCiHFQtouTBS7kdRdvb8NYzpgt
         TVnDp5yC31dJbCugqOziaM+cbwWVnMnlOl+xMUXOLqur/Bwkcs7oSBEet9y7Ro8PfO
         IoAuc15ZMKH5A==
Received: (nullmailer pid 1635414 invoked by uid 1000);
        Thu, 03 Aug 2023 01:10:44 -0000
Date:   Wed, 2 Aug 2023 19:10:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>
Subject: Re: [PATCH] treewide: Update Guru Das Srinagesh's email address
Message-ID: <169102504217.1635327.17550815290439094819.robh@kernel.org>
References: <20230728001622.4938-1-quic_gurus@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728001622.4938-1-quic_gurus@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Jul 2023 17:16:22 -0700, Guru Das Srinagesh wrote:
> Clean up my email address as the codeaurora.org address is not used
> anymore.
> 
> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> ---
>  Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml | 2 +-
>  Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!

