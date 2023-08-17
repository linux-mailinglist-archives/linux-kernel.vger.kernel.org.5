Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13ED77FD7E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354217AbjHQSEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354210AbjHQSE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:04:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92BE19A1;
        Thu, 17 Aug 2023 11:04:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5003C63999;
        Thu, 17 Aug 2023 18:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A82C433C7;
        Thu, 17 Aug 2023 18:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692295467;
        bh=BcEUikQnq7ddqq5xraAv8pC6uypqhdgGk0XNsDGkbvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BhsI/ke3HLx6K/DZpbWRlQvwjwtLBdMkbTzeFgRLJuJ24AZ37nU3B+miRYv60yQyy
         3Bv/VCEyM11abBhNQd0dipzo3BujpWU3zzzJyLuRaZT9B93JF8V9f9lhRNGYO8i/RX
         U982LLoUKtJ7CoqmBeHwJj1omKIRDeN9ibn6vjr4DAjlsyEaMKrY/Km5pQAf+C/uSX
         jfyD8vkBuqrX63Wn/X/ogxFeOhfS6v3RLhP0dv8dnwE2R0NwwGzzTl35IktaVUWNJV
         BfmSoQuM+otkCnDVKqXpbBw+yUd5FgEzp2UbBtwzdlUlCs2xdliL685nDnE5NoZJyY
         j7ZtdNh6H7gsA==
Received: (nullmailer pid 1888176 invoked by uid 1000);
        Thu, 17 Aug 2023 18:04:25 -0000
Date:   Thu, 17 Aug 2023 13:04:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/6] dt-bindings: interrupt-controller: qcom,pdc: Add
 SDM670
Message-ID: <169229546412.1888098.11242593336275855378.robh@kernel.org>
References: <20230811-topic-tlmm_wakeup-v1-0-5616a7da1fff@linaro.org>
 <20230811-topic-tlmm_wakeup-v1-1-5616a7da1fff@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811-topic-tlmm_wakeup-v1-1-5616a7da1fff@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Aug 2023 22:48:34 +0200, Konrad Dybcio wrote:
> Like all other RPMh-enabled SoCs, SDM670 includes a PDC. Document it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!

