Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA80779799
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 21:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbjHKTPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 15:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbjHKTPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 15:15:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6112709;
        Fri, 11 Aug 2023 12:15:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97BE26793A;
        Fri, 11 Aug 2023 19:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D4AC433C7;
        Fri, 11 Aug 2023 19:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691781313;
        bh=6QtAcXtlXNSXcw0j6uPr4ISWAtSh7YhKaEmvIEovYFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NtvgsK2oBsjxKjlRfUdQNOXkkC6UK7QpuOaWBsfjynl4qg0reI10lYjwMujfiNrPi
         ewVwrB/2Vef0kxFGnYloj9Gh3SAqUGC1L8L+29yyTy29VwfUmOEQv3UZmuLgJN4vcu
         Skl5XABvqBcdo8mJvOWbLHKKyxl33hCaIbQkp+Fm9IPCocGvnt1v5F/Qh0Gviil9E4
         sZxTcrKomAPOctg/WBe3j7kul1VVH1uw+5U6mBIsx/d8/gbmP9nG6noMJcMNHtjyU7
         5LpxTCBG6x7y9XJ3wdDWoJ+oXfQNBY5rBaDzzdXjLjy+BbA1ISlaPhfMkEl7gUULlU
         4qQS8QNym39Ug==
Received: (nullmailer pid 3977273 invoked by uid 1000);
        Fri, 11 Aug 2023 19:15:10 -0000
Date:   Fri, 11 Aug 2023 13:15:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Rob Herring <robh+dt@kernel.org>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: qcom: Document new msm8916-samsung
 devices
Message-ID: <169178130995.3977197.15210802721346708253.robh@kernel.org>
References: <20230801111745.4629-1-linmengbo0689@protonmail.com>
 <20230801112113.4659-1-linmengbo0689@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801112113.4659-1-linmengbo0689@protonmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 01 Aug 2023 11:22:30 +0000, Lin, Meng-Bo wrote:
> Document the new following device tree bindings used in their
> device trees:
> 
> - samsung,fortuna3g
> - samsung,fortunaltezt
> - samsung,gprimeltecan
> - samsung,grandprimelte
> - samsung,heatqlte
> - samsung,rossa
> 
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

