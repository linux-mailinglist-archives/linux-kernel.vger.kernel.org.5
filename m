Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC09767397
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjG1Rj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjG1RjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:39:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42543AA8;
        Fri, 28 Jul 2023 10:39:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66615621C0;
        Fri, 28 Jul 2023 17:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94819C433C7;
        Fri, 28 Jul 2023 17:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690565961;
        bh=roYtL0lJ24etk1TruYXJXJEuUtCQ5tIVdVJtAre9U6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hS1f/yG41/67hewa9d620jDht7gFRlm9jr3oS53ZfQwSlHq4fe3P4+nC8pjFB2Lmf
         FBLYomlvY0nwpHYoNiPiv9PiG7mMEtmIV6Gaaj5+RenF3icYt2aKiZIM8Pbk/rvwy4
         GbwxH4xKdZ3ScW1VmT7nrDUh/k8p/DL2/Bw3UnHXJ6wgk6le5El9v45vro/48a+3kZ
         5A0A8Xd64+oxyVheCLA3JiI2VFQ2NGU4gTbobXUkcAnavHLFEPJiUFQnsF2nT+1Ft8
         8Wckp3Q/zjvyl5mO4A7Dy0SFH4i/TZKMTVI0JLg41EmMnpFheiA6XvKyYVcbaGLjfv
         7FLN2Saw+v4Ag==
Received: (nullmailer pid 325023 invoked by uid 1000);
        Fri, 28 Jul 2023 17:39:19 -0000
Date:   Fri, 28 Jul 2023 11:39:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Varshini Rajendran <varshini.rajendran@microchip.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        claudiu.beznea@microchip.com, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, tudor.ambarus@linaro.org,
        conor+dt@kernel.org
Subject: Re: [PATCH v3 09/50] dt-bindings: crypto: add sam9x7 in Atmel AES
Message-ID: <169056593367.324463.7670633155489999127.robh@kernel.org>
References: <20230728102422.265715-1-varshini.rajendran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728102422.265715-1-varshini.rajendran@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Jul 2023 15:54:22 +0530, Varshini Rajendran wrote:
> Add DT bindings for atmel AES.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  .../devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml   | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

