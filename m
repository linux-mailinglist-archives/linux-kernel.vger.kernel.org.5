Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4471B7C5B60
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376273AbjJKScA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjJKSb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:31:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412049E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:31:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7EBC433C8;
        Wed, 11 Oct 2023 18:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697049117;
        bh=/9J780tQzBEeuQwQSPtBbrIhiw9EHx3g3BlP3psFwKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DjeJHx+OqphaUMzYfFUXuSccv4+TtSpF63t940mzVkbY7AXjpKi+Xo6laOu+muCQ9
         fFJ0zmahdIzmWqhzWQTmQ5bYxktRQrYNjZEsUbNWr0HdkhtVbT2fPJTEOsEm1Spbqd
         JfKIS5EqZt6KQUvxNwqR2FHEkPfYhan42MM2HMLS4yV83Spr9u6It1xWzi1sUjfxpv
         YSUuP2QRsQHKSyG5JowwyFAGvow8lxSQbq4rrx80ltiDvNvtNfdWikjhFK4vyutBlC
         O4+7+RjFPAwNvTX0TZil50ZXztKj7qMW2qNDQH6tqcSEFF8y0ublI4IhLuha2Ei1N3
         +QICDvqqzJtYg==
Date:   Wed, 11 Oct 2023 20:31:54 +0200
From:   Simon Horman <horms@kernel.org>
To:     Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Cc:     loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: net: wwan: wwan_core.c: resolved spelling
 mistake
Message-ID: <20231011183154.GA1140976@kernel.org>
References: <20231010044608.33016-1-m.muzzammilashraf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010044608.33016-1-m.muzzammilashraf@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 09:46:08AM +0500, Muhammad Muzammil wrote:
> resolved typing mistake from devce to device
> 
> Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>

Hi Muhammad,

while we are here could we also consider fixing concurent ==> concurrent
in the same file?

> ---
>  drivers/net/wwan/wwan_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> index 87df60916960..12c3ff91a239 100644
> --- a/drivers/net/wwan/wwan_core.c
> +++ b/drivers/net/wwan/wwan_core.c
> @@ -302,7 +302,7 @@ static void wwan_remove_dev(struct wwan_device *wwandev)
>  
>  static const struct {
>  	const char * const name;	/* Port type name */
> -	const char * const devsuf;	/* Port devce name suffix */
> +	const char * const devsuf;	/* Port device name suffix */
>  } wwan_port_types[WWAN_PORT_MAX + 1] = {
>  	[WWAN_PORT_AT] = {
>  		.name = "AT",
> -- 
> 2.27.0
> 
> 
