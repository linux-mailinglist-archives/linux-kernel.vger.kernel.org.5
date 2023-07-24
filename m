Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DE575FBFA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjGXQZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjGXQZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:25:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD44AE4F;
        Mon, 24 Jul 2023 09:25:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28A016125A;
        Mon, 24 Jul 2023 16:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17F6C433C8;
        Mon, 24 Jul 2023 16:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690215919;
        bh=EnWU+f7DpeVD8c/GAjWs1A/LPFoWKgCZUc8yvyI+PjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pgodt+ZABtCoCiaY3rQBv3bhstaDRe8cuxaTpgqFl8KYYyuQ7C4gxZzOkRFS0GA9E
         IOOucLl+UKsN96uOXvRnczwLTQFiJs+vK9M2EFozlnFa451rRmdiL29wPLhpcx92mL
         S3ZZ763g5kSGXQGpfRCFP+z4slGHlGGXh3FpgOSXw4iRfvNKH7dqiqesBuD5JurOG1
         AloT0IiWlWTc9za5XJhVqIPs1+y2E4RA8EmqsDRXD3sfUTuESsod3YQB4jb+Jh8pHd
         Fi04x+9XgI6suGblnYMtl6MtjiqZsjUFG6pgIhm0QcgVjRFuWpjcT6YuvRygEToOO4
         fwWWkA4I/Umsw==
Received: (nullmailer pid 3781750 invoked by uid 1000);
        Mon, 24 Jul 2023 16:25:17 -0000
Date:   Mon, 24 Jul 2023 10:25:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] dt-bindings: mfd: maxim,max77693: add USB connector
Message-ID: <169021591719.3781689.1679415084242354918.robh@kernel.org>
References: <20230723070715.34650-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230723070715.34650-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Jul 2023 09:07:15 +0200, Krzysztof Kozlowski wrote:
> Add micro-USB connector to properly represent the hardware.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> DTS change using this:
> https://lore.kernel.org/linux-samsung-soc/20230722202039.35877-1-krzysztof.kozlowski@linaro.org/T/#u
> ---
>  Documentation/devicetree/bindings/mfd/maxim,max77693.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

