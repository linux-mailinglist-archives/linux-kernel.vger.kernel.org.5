Return-Path: <linux-kernel+bounces-5860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAF6819067
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 345BC287CA2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4250938F8B;
	Tue, 19 Dec 2023 19:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yUI1o47x"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8335D39AC1;
	Tue, 19 Dec 2023 19:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43714C433C8;
	Tue, 19 Dec 2023 19:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703013165;
	bh=0NclXKpcSiRidFmGC5XGZ6Sc8sUWFuzkW709TjTu/Sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yUI1o47xgms6UXjvf6upSMZRwc8Rn1V/J3pz50WOVGp9SJP0F7N3biclApE3mORvp
	 Mr9u9/lXBhrjiOrrgfbfAxZYkZgJI+w56yQ8dB8TS/Dvi5HpcL19HUtGimdGssc3xk
	 sZrme52r+NBS2R5DFCb42PONI7b4O+t2sGC5exvo=
Date: Tue, 19 Dec 2023 20:12:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Shreeya Patel <shreeya.patel@collabora.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernelci@lists.linux.dev,
	Gustavo Padovan <gustavo.padovan@collabora.com>
Subject: Re: KernelCI stable-rc/linux-6.1.y report (19/12/2023)
Message-ID: <2023121951-clatter-flatfoot-35e9@gregkh>
References: <77f6-65819080-3-401c3100@44872347>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77f6-65819080-3-401c3100@44872347>

On Tue, Dec 19, 2023 at 12:44:59PM +0000, Shreeya Patel wrote:
> Hi Everyone,
> 
> Please find the KernelCI report for stable-rc/linux-6.1.y for this week.
> 
> ## stable-rc HEAD for linux-6.1.y:
> 
> Date: 2023-12-18
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=d4e0eced630816f1c7a6d389a4cb6233a606eeea
>  
> ## Build failures:
> 
> No build failures seen for the stable-rc/linux-6.1.y commit head \o/
>  
> ## Boot failures:
> 
> No **new** boot failures seen for the stable-rc/linux-6.1.y commit head \o/
> 
> Tested-by: kernelci.org bot <bot@kernelci.org>

These are great, thank you for doing this!

But, any chance you can provide these as a response to the -rc email
announcement so my tools can pick them up for the commit message?  I can
mush them in here by hand this time, but doing it twice a week for the
next 10+ years is going to be a pain for me :)

thanks,

greg k-h

