Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F3A7B5652
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238031AbjJBPQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238058AbjJBPQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:16:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4A3DA
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:16:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FBEC433C8;
        Mon,  2 Oct 2023 15:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696259788;
        bh=Fb0ymaVOpCVGd7cx59N9jbdB3iYdc12n4vQA6NoFyqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aPFImDyhexsU1wHFumQd4HI2AtZnCoyHnaWvoK9Lp/BJk7TiwY6RuY1djs1iZp5C1
         DDQbWOfBGxG3JyIwNbn2hqu94FZZDGaoCbCGLB2Ddi9AADQ8mN1JmDBS2TwS+aIplR
         dOqwhLTpssI3x3dlD4312/eJEfNlqd+92JZhLeMVjRfGSL7m4KwUOhWbfqjsSoh4ps
         2W6wUwCjoyk5oxEknACrIopYS1WGygWNqWCFXtHarC+hxceEn3fjxGxUcgpcEhr6Wv
         SHKJWjiPIC/EB2EhvAQR5HKFSGF85QMIjI7BBLZI/mPF5xYXJkVR8yXjFylrPc0BnA
         A7Q3z61p6aseQ==
Received: (nullmailer pid 1744043 invoked by uid 1000);
        Mon, 02 Oct 2023 15:16:26 -0000
Date:   Mon, 2 Oct 2023 10:16:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Joerg Schambacher <joerg.hifiberry@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, a-krasser@ti.com,
        joerg@hifiberry.com, Conor Dooley <conor+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ASoC: pcm512x: Adds bindings for TAS575x devices
Message-ID: <169625977391.1743730.497698992999115873.robh@kernel.org>
References: <20230929150555.405388-1-joerg.hifiberry@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929150555.405388-1-joerg.hifiberry@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 29 Sep 2023 17:05:55 +0200, Joerg Schambacher wrote:
> The TAS5754/6 power amplifiers use the same pcm512x driver with
> only minor restictions described in the bindings document.
> 
> Signed-off-by: Joerg Schambacher <joerg.hifiberry@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/pcm512x.txt | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Reviewed-by: Rob Herring <robh@kernel.org>



