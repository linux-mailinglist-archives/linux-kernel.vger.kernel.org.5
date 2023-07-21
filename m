Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFA375D322
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 21:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjGUTHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 15:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjGUTHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 15:07:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5524C30D6;
        Fri, 21 Jul 2023 12:07:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E683061D93;
        Fri, 21 Jul 2023 19:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D200FC433C8;
        Fri, 21 Jul 2023 19:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689966432;
        bh=I2omJi1yLfOlnrddw6vsyk5JwTbZP32GNq5Yi6owJvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s8rDo2U+10hz1W6DLhzabzeZvnhUJq46+kC0r1+RuBpyHR7dEBGc4wdg+dGyk8bWL
         tE9k+4jaFC0gQwe0mL6tZ10owi7MQiT3TvyZhELX/7XG0msOHgeXGjGUsB+8YOZwXA
         Bz4/mjBneXRLFjbtbG+CVMn9M9VOqZ84vZ/JJPVuoixOx9pFo12fIG4Ac3QM5irzAI
         0T9q6faJnvdV/eX1zqwLfPbF1Q6rDPqay2gyv3M8I1/5WKwMExqG14Yolg4zym6UXJ
         0Sna9GbZ1eoQq5NxIN5Bnv6Luw6d8gXxfJ/CZ1yaDYljpDvg/ZAiWos2skIPu/mD7N
         QJnlyH4ulvbmQ==
Received: (nullmailer pid 1597217 invoked by uid 1000);
        Fri, 21 Jul 2023 19:07:10 -0000
Date:   Fri, 21 Jul 2023 13:07:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: Remove obsolete nxp,lpc1850-uart.txt
Message-ID: <168996642970.1596937.7190693414202449873.robh@kernel.org>
References: <20230707221607.1064888-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707221607.1064888-1-robh@kernel.org>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 07 Jul 2023 16:16:06 -0600, Rob Herring wrote:
> nxp,lpc1850-uart.txt binding is already covered by 8250.yaml, so remove
> it.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/serial/nxp,lpc1850-uart.txt      | 28 -------------------
>  1 file changed, 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/nxp,lpc1850-uart.txt
> 

Applied, thanks!

