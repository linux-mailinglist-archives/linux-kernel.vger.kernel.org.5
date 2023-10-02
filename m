Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433F27B5B35
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238823AbjJBTUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjJBTUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:20:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D266C6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 12:20:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA7AC433C8;
        Mon,  2 Oct 2023 19:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696274419;
        bh=VQ45G7PYlL0FP/UIakxyWuwF9DPXgSI52rIbqA5VkiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P/3zTldmAvtvA6Dupg185llQZT3c+BZdhuLzSBPvA25QSnATf5zk+lekQjHRBPDIA
         pnzVH3mh1kd+fcYfcWAr+5s9JLiTe6h3JTUjHgyUdInFfLaMiPKZ0USzW6pNj+Q1Wo
         Cy2xLkTKOYN3ZHWWTXMX1afdQz+BpFv1/ZGfNUIc9YqRYeoBFNsJrGMBKnkzkh9r24
         uMZpHIYXPy4QZM+VaZvTNcj5NK7f1FzBee49Ai5qs49NO4C4Q2p5CiB2u9aUz5YvYF
         KKHGSFmiJ0YJcSdtxZKKexR8BdhI+TheZHS67r+ekHkbo053RgixC+IlUSpCi1Ih2I
         tg8zJGpdhC4cQ==
Received: (nullmailer pid 2379910 invoked by uid 1000);
        Mon, 02 Oct 2023 19:20:18 -0000
Date:   Mon, 2 Oct 2023 14:20:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        conor+dt@kernel.org, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH v2] ASoC: dt-bindings: rt5616: Convert to dtschema
Message-ID: <169627441749.2379855.17500143382668612525.robh@kernel.org>
References: <20230930165050.7793-1-bragathemanick0908@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930165050.7793-1-bragathemanick0908@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 30 Sep 2023 22:20:50 +0530, Bragatheswaran Manickavel wrote:
> Convert the rt5616 audio CODEC bindings to DT schema
> 
> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
> ---
> V1 -> V2: Changes codec to audio-codec and added spacing above
> 
>  .../bindings/sound/realtek,rt5616.yaml        | 49 +++++++++++++++++++
>  .../devicetree/bindings/sound/rt5616.txt      | 32 ------------
>  2 files changed, 49 insertions(+), 32 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5616.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/rt5616.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

