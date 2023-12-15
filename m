Return-Path: <linux-kernel+bounces-1231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8143B814C15
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3BB01C21252
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26833A8F4;
	Fri, 15 Dec 2023 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z+USVQfI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C738A3A8E7;
	Fri, 15 Dec 2023 15:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222C1C433C8;
	Fri, 15 Dec 2023 15:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702655328;
	bh=rsPUpCj2bYxs7k3PRRq5DJkVAQ0qVf/ojfEsU0inDpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=z+USVQfIbkB98dDpugqCgCMHDt3biGRRYpWj8y5HPiA5Kgkz+eF/0mRepjQC/bo+1
	 kkthLzJPI0y60HXoL6LrHE5BuAyS8YKZw92P805tpC0VT7E2PBlf82UbKlS57fpm6A
	 NuTVyaY7J/uRPTufMbSS40SpzUXCtfF5lsnB2QxI=
Date: Fri, 15 Dec 2023 16:48:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Nathan DSilva <expitau@gmail.com>
Cc: philipp.g.hortmann@gmail.com, tdavies@darkphysics.net,
	error27@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8192e: Add blank line after declarations
Message-ID: <2023121533-bulge-appealing-73e0@gregkh>
References: <ZXvevJ2vEEQ92rau@oatmeal.darkphysics>
 <20231215152918.532037-1-expitau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215152918.532037-1-expitau@gmail.com>

On Fri, Dec 15, 2023 at 03:29:18PM +0000, Nathan DSilva wrote:
> Remove a warning about line breaks after declarations found by checkpatch.
> 
> Signed-off-by: Nathan DSilva <expitau@gmail.com>
> ---
> 
> Thank you very much for your response. I didn't realize you could select
> multiple --to recipients, or that you could have comments not in the changelog.
> 
>  drivers/staging/rtl8192e/rtllib_rx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
> index ecaa4dec3f94..397859c7f5b1 100644
> --- a/drivers/staging/rtl8192e/rtllib_rx.c
> +++ b/drivers/staging/rtl8192e/rtllib_rx.c
> @@ -946,6 +946,7 @@ static int rtllib_rx_data_filter(struct rtllib_device *ieee, struct ieee80211_hd
>  {
>  	u8 type, stype;
>  	u16 fc = le16_to_cpu(hdr->frame_control);
> +
>  	type = WLAN_FC_GET_TYPE(fc);
>  	stype = WLAN_FC_GET_STYPE(fc);
>  
> -- 
> 2.43.0
> 


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

