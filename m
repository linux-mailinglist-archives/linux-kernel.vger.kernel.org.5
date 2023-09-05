Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1ECE792FDB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243418AbjIEUWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242451AbjIEUWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:22:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD36CC;
        Tue,  5 Sep 2023 13:22:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96C6C433C7;
        Tue,  5 Sep 2023 20:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693945348;
        bh=EwBNwGfu/aekwrpRYA2HuNjlbP3dI7qlSwSX24HdBH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MAnGdh75NZWTic5epmiLnEJaFYVt1gHg+Gfj3s73jOOlJAEVjwtz1kwsq0ueNtcX0
         8ep2D9IwY234tjy95Y0PPKYaPFE2pxuQRuqg1AfA65VkgfbmvIkJUM+y6ZeAlYeA9J
         NMDchGLKnx5MH9Vyz1W5j+A6rn83quSfNoZpdaO/At607Kb4o1V2SztakMgOParC9s
         HlPlSpq5A1D2pB1OG1fCd/CFBCH7p2QYD25k6wAGY59v0VhW4ZPmkD0bOt2sBCgt5b
         3HP2oBavJvgjEL3IdsCfApTIJKtXudpvV16KxyevJYXYZfusIfKLCDbXA2TuV3adCD
         Uw4uTj0fnzogg==
Received: (nullmailer pid 3962578 invoked by uid 1000);
        Tue, 05 Sep 2023 20:22:26 -0000
Date:   Tue, 5 Sep 2023 15:22:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee@kernel.org>, devicetree@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: mfd: Revert "dt-bindings: mfd:
 maxim,max77693: Add USB connector"
Message-ID: <169394534588.3962519.17804734822796231896.robh@kernel.org>
References: <20230905075558.21219-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905075558.21219-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 05 Sep 2023 09:55:58 +0200, Krzysztof Kozlowski wrote:
> This reverts commit da7ee30ae6662f016f28a9ef090b2132b3c0fb48.
> 
> Commit da7ee30ae666 ("dt-bindings: mfd: maxim,max77693: Add USB
> connector") was an earlier version of my patch adding the connector,
> later superseded by commit 789c9ce9b46f ("dt-bindings: mfd:
> maxim,max77693: Add USB connector").
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Fix for v6.6-rc1.
> ---
>  Documentation/devicetree/bindings/mfd/maxim,max77693.yaml | 4 ----
>  1 file changed, 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

