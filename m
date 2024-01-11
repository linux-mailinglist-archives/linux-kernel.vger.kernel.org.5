Return-Path: <linux-kernel+bounces-23146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB6382A843
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A6728506C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7933D28D;
	Thu, 11 Jan 2024 07:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hzi2burG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CAC53A0;
	Thu, 11 Jan 2024 07:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E117C433C7;
	Thu, 11 Jan 2024 07:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704957755;
	bh=YBJ+TuhbA4GP+ir1wvuKGwuDiLckR+dJi7f+/lzf00k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hzi2burGhveBZiW5bLJtrwuxVyzi636XRyiLYKBFwc0nvn9fz1hNjID1bK1MoSe57
	 VI2pJRQCzojA+PFMLoSLqO/jWngGpbRLKurldkktzA6E9vQW7YYegp/3ZgY4hiNaEG
	 L4G9G7/2VPo7p3tBZdl8wIDRd/H9TwVChmDVp5zs=
Date: Thu, 11 Jan 2024 08:22:27 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pranav Athreya <pranavsubbu@gmail.com>
Cc: Forest Bond <forest@alittletooquiet.net>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: Remove extra blank lines between code
 blocks
Message-ID: <2024011144-silica-viral-9e79@gregkh>
References: <20240111070652.71717-1-pranavsubbu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111070652.71717-1-pranavsubbu@gmail.com>

On Thu, Jan 11, 2024 at 12:36:52PM +0530, Pranav Athreya wrote:
> Adhere to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> drivers/staging/vt6655/rxtx.h:22: CHECK: Please don't use multiple blank lines
> 
> drivers/staging/vt6655/vt6655_stage.mod.c:38: CHECK: Please don't use multiple blank lines
> ^Ignore the blank lines in vt6655_stage.mod.c since *.mod.c files
> are included in .gitignore.

*.mod.c files are not something that you can change, and are not in your
patch either:

> Signed-off-by: Pranav Athreya <pranavsubbu@gmail.com>
> ---
>  drivers/staging/vt6655/rxtx.h | 1 -
>  1 file changed, 1 deletion(-)

So the text is not correct :(

thanks,

greg k-h

