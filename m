Return-Path: <linux-kernel+bounces-69941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6E5859090
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04521C213F0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22197C6D2;
	Sat, 17 Feb 2024 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lwHhs3gF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292037B3E8
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708184535; cv=none; b=cB7VqzP31F0TdK4p9uCwRX5oe94NXt0ARNe01cKEiu+dRp2Zwrpcg+hXZph2PjBxGOHczkH97YkGntkg59hqlJDjty+v4NQ2m7ql8A4ejdm/MNLJtqse+yOQG8zCXFlUy36D0XOTXrkk5bzoukxfOvMqvTLbvRCvKJqfC6b1vnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708184535; c=relaxed/simple;
	bh=dWSfIWGZQDjbdl5zINyK6G7jsTcPEdrq5dv0jPqVMMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVDhZZen/81zpmIyHGQ6mb8JGlvyzBBtmKGdgYjQWVDjGvCVyJdi0tsrgbLv7QUJR/qblhWxkYSnKiHEYgxHpaT5vtA55cW3VAEXvoGu69LL7VN/ZU6y9JTnDVm3CVWHX6A9gFgtbykzfxtEFF+60w5J7WHWroqRcihBN4rmpqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lwHhs3gF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361AFC433F1;
	Sat, 17 Feb 2024 15:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708184534;
	bh=dWSfIWGZQDjbdl5zINyK6G7jsTcPEdrq5dv0jPqVMMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lwHhs3gF6gwcd7HquiLw6hobQyaXq8/IT35uQGKr9IyG/JdanlsvBh18yqiVRZqUY
	 286C8WIvI8I96knEP/ZbwOtoBQuFBVDtOYy5M47seXQevuI6XcDgd/Wu58JFEc8Mia
	 Q3Pg7OWPL5OnLCO9zngYEwv94ECCmgZianicG8aI=
Date: Sat, 17 Feb 2024 16:42:11 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] MAINTAINERS: Drop myself as maintainer of TYPEC port
 controller drivers
Message-ID: <2024021735-fascism-shield-04f5@gregkh>
References: <20240215202039.1982539-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215202039.1982539-1-linux@roeck-us.net>

On Thu, Feb 15, 2024 at 12:20:39PM -0800, Guenter Roeck wrote:
> I am no longer involved in Type-C development and not really current on its
> status and progress. Recently I have been doing more damage than good.
> It is time to go.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 73d898383e51..ae3283f9eceb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22864,9 +22864,8 @@ S:	Maintained
>  F:	drivers/usb/typec/mux/pi3usb30532.c
>  
>  USB TYPEC PORT CONTROLLER DRIVERS
> -M:	Guenter Roeck <linux@roeck-us.net>
>  L:	linux-usb@vger.kernel.org
> -S:	Maintained
> +S:	Orphan
>  F:	drivers/usb/typec/tcpm/
>  
>  USB UHCI DRIVER
> -- 
> 2.39.2
> 

Many thanks for all the help you provided here over the years, it is
much appreciated!

I'll go queue this up after -rc5 is out, thanks.

greg k-h

