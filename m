Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D4476FFCE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjHDL5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHDL5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:57:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E57B1;
        Fri,  4 Aug 2023 04:57:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 038A561FA9;
        Fri,  4 Aug 2023 11:57:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1664DC433C7;
        Fri,  4 Aug 2023 11:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691150267;
        bh=KcgazaGjBuDGqutZBwoUPbbDeArwjFsTuUJNqkdlBrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sCs4YQV0vLsYLvOvIfnyojGtS32CO3M3BKBOlN3IlaLuBvKtIJa/yuY462I4F+1/7
         CWmrMfYIK3kfPkwme+GD33CdIKXVvVvEdFx4mmAF04l2WBsnbaHQWn2n8MbqbJyjzf
         AY7yJ/yEJ690cC//eATkWFSzKopIEM7B97VvwSlo=
Date:   Fri, 4 Aug 2023 13:57:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     coolrrsh@gmail.com
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 2/2] fixes warning
Message-ID: <2023080435-knapsack-litter-2cbd@gregkh>
References: <20230804115121.34035-1-coolrrsh@gmail.com>
 <20230804115121.34035-2-coolrrsh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804115121.34035-2-coolrrsh@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 05:21:21PM +0530, coolrrsh@gmail.com wrote:
> From: Rajeshwar R Shinde <coolrrsh@gmail.com>
> 
> drivers/spi/spi-mpc52xx-psc.c:332:5-13:
> WARNING: Unsigned expression compared with zero: mps -> irq < 0
> 
> Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
> ---
>  drivers/spi/spi-mpc52xx-psc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Your subject lines are not correct :(
