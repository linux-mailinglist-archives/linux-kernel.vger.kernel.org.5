Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B70B792F8C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242784AbjIEUIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242573AbjIEUIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:08:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C639C;
        Tue,  5 Sep 2023 13:08:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D97BC4339A;
        Tue,  5 Sep 2023 18:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693937800;
        bh=eE6iIeJVyd5A3sLT9gWxdxdxpP7Nmi6eTWp1cJDxjV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BvR15sG5UVzUcajsRUOMr5AwbM9zRPQZRjn+B0gUL8f1aU//0yQbqrFn8Ej1pYlxE
         3ephHqQeEHUsLGc7PP02lE+ZVADCl/pTnmp13VdDOOBlkQSHIPJP6Nj2H+zOjL7rJz
         SxiKt9R4U/piA/nBrKwKx+bVjBZtbsF98ZXBLUfwNT5uiXQwDc0Mz2oIwMunLEXug8
         OZiD5HkqVXY3wosa2vgNHxvO3wzLewk7AeoBDoiZW24YDCnVqmSKRiuodfjGUduz2X
         mlwn/1zElcaCU2u7O/0+GYROTeHpvgPAnVc6/KYWwhWyBx+tF4nyyI28IFB8v9VKHO
         Wvoq5zvgQL49A==
Received: (nullmailer pid 3743858 invoked by uid 1000);
        Tue, 05 Sep 2023 18:16:37 -0000
Date:   Tue, 5 Sep 2023 13:16:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peter Yin <peteryin.openbmc@gmail.com>
Cc:     patrick@stwcx.xyz,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        peter.yin@quantatw.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v8 2/2] dt-bindings: arm: aspeed: add Meta Minerva board
Message-ID: <20230905181637.GA3742088-robh@kernel.org>
References: <20230905062223.774871-1-peteryin.openbmc@gmail.com>
 <20230905062223.774871-3-peteryin.openbmc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905062223.774871-3-peteryin.openbmc@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 02:22:22PM +0800, Peter Yin wrote:
> Document the new compatibles used on Meta Minerva.
> 
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> 

You should not have blank lines between tags. 

> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 68f717670f78..32582ee56264 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -79,6 +79,7 @@ properties:
>                - facebook,elbert-bmc
>                - facebook,fuji-bmc
>                - facebook,greatlakes-bmc
> +              - facebook,minerva-bmc
>                - facebook,yosemite4-bmc
>                - ibm,everest-bmc
>                - ibm,rainier-bmc
> -- 
> 2.25.1
> 
