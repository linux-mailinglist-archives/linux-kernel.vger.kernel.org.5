Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6F67C04C0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343919AbjJJTgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343946AbjJJTgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:36:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E939E;
        Tue, 10 Oct 2023 12:36:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C8DC433C8;
        Tue, 10 Oct 2023 19:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696966603;
        bh=cZkzPPFC3wMzzRvvFIDetx465/S9zd2QKLoizRzR0gI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LYGlVfKg4sSSZjfl2XDMA6KCVaRbQF/bXgrzY8OcHIvKxtXq0Pfw73bxJUGhWtc6e
         17dTUdIS7RnQy0sCqfZGGQYS5Y/vC2T967KmNtzcgmCHDwe0+BY9K7y5FTWjjc4ek2
         yU7dtRz6CmPWaHLcyYnVu7wA6Qa9dSaWUNrnxqAMfxWdYLcZPx0ukMqx9hSI3NiGMZ
         5l0dwTKvv59Yt3MdWjVextK9jf4dqBfu4SSJHO5KeS/brR6ijvhs3lNscCBOd0o8cE
         kUB9LYxgW2yLb1r07biJ25GjEtFloOyG4qhLSR0t3B2IeVx5QXQDSH0uq0n5gFCwTu
         Uq1i24pvfu9Ig==
Received: (nullmailer pid 1423129 invoked by uid 1000);
        Tue, 10 Oct 2023 19:36:40 -0000
Date:   Tue, 10 Oct 2023 14:36:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mehdi Djait <mehdi.djait@bootlin.com>
Cc:     ezequiel@vanguardiasur.com.ar, robh+dt@kernel.org, heiko@sntech.de,
        linux-media@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        mchehab@kernel.org, conor+dt@kernel.org, hverkuil-cisco@xs4all.nl,
        maxime.chevallier@bootlin.com, paul.kocialkowski@bootlin.com
Subject: Re: [PATCH v7 1/3] media: dt-bindings: media: add bindings for
 Rockchip VIP
Message-ID: <169696659993.1423074.9501474541283864884.robh@kernel.org>
References: <cover.1696943295.git.mehdi.djait@bootlin.com>
 <a103d2e4e2c80a97a62574a782eba29f78731471.1696943295.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a103d2e4e2c80a97a62574a782eba29f78731471.1696943295.git.mehdi.djait@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Oct 2023 15:15:04 +0200, Mehdi Djait wrote:
> Add a documentation for the Rockchip Video Input Processor
> binding.
> 
> The PX30 SoC is the only platform supported so far.
> 
> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> ---
>  .../bindings/media/rockchip,px30-vip.yaml     | 93 +++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

