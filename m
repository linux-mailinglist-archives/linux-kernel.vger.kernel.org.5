Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6FC75320F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbjGNGfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbjGNGen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:34:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223A330CB;
        Thu, 13 Jul 2023 23:34:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFBEC61BCB;
        Fri, 14 Jul 2023 06:34:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850B7C433C7;
        Fri, 14 Jul 2023 06:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689316468;
        bh=HNJGtyERKCH6z390Vn8aBkVMvYPcPPbKhPvGu9bfFK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JCvAFtfwpLhQTo/ArRDGEGIczn6mJb7aZ0BAEROVm7uShe5izEUnkJTZ7VGcuZn3V
         JfbbZVBqRioE2UHapJceIc4oyzBEK2Rp6bLtuhD/4+MW7JmyenqnFElKBqnzHG6nW2
         pxGdKYd+vr6xARpd2tUE3iUvW66fP6tJpSwnxtwM8apzBlD8GZqXEqLrB9sSKwTUxw
         Vie0cy0omyRhu+N5lJzz22+nPKQLe/e/o7nkf3GTGPYnavpWdIBDN8hS4cJTzsVf0O
         0t4hjr3c1cRKQXU2jdpMA7mF1oxkpPFOm4DW15Av2FNSQujmv/ymXVkOZmicAToiLk
         Rh1Br/SKFWjpA==
Date:   Fri, 14 Jul 2023 12:04:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the soundwire-fixes tree
Message-ID: <ZLDsb6VK7q6VkuHn@matsya>
References: <20230713075901.758e1b65@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713075901.758e1b65@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-07-23, 07:59, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   bfb4da9c536e ("soundwire: amd: Fix a check for errors in probe()")
> 
> Fixes tag
> 
>   Fixes: a673a8dfc214 ("soundwire: amd: Add support for AMD Manager driver")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: d8f48fbdfd9a ("soundwire: amd: Add support for AMD Manager driver")

I have fixed it up, thanks for the report

-- 
~Vinod
