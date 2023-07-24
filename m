Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9B575FBF8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjGXQZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjGXQZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:25:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B21410F7;
        Mon, 24 Jul 2023 09:25:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08A1761268;
        Mon, 24 Jul 2023 16:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99474C433C7;
        Mon, 24 Jul 2023 16:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690215903;
        bh=kuT5WuayIHUIJdTrVnzXZK/Yfwp44+sg2Y3wXv+liZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DS7fNzg5tgihiHAyiKBMbQ2zw0/YwTueg3nPqq9Fc5xlIPjsmgA9fD3Q1Ax+0PDhY
         EQNLQmL236AW/l01/xRS05gQXusNM9MNNXOE83VbdrYa+i4lUJWganyWhgMXUROv09
         r2JXnSxMZTKVMpopFJymxxZ8kcNgv6Ffx1Le0rM3PBb88x1Rjw7JZ8LQPymUEqH06O
         vpv6n5gVwT0Mn4T4bxAvWFo+5f5jJEDSXUTUIMJAIDMVEcsGDEeGvLesa6yxGMA0Yp
         avRwtr6jHlMsZ+Ph2gqBrWRKHYVX2ceYzYq+bV5Zsf/BZOLYTSfJd2AvnNrXvDJerx
         PdAW0Rji82yxg==
Received: (nullmailer pid 3780931 invoked by uid 1000);
        Mon, 24 Jul 2023 16:25:01 -0000
Date:   Mon, 24 Jul 2023 10:25:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: samsung-hsotg: remove bindings already
 part of dwc2
Message-ID: <169021589442.3780113.10060353053959051163.robh@kernel.org>
References: <20230722201620.35489-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230722201620.35489-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 22 Jul 2023 22:16:20 +0200, Krzysztof Kozlowski wrote:
> samsung,s3c6400-hsotg compatible is already fully covered in dwc2.yaml
> bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/usb/samsung-hsotg.txt | 38 -------------------
>  1 file changed, 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/samsung-hsotg.txt
> 

Applied, thanks!

