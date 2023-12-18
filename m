Return-Path: <linux-kernel+bounces-3017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B320681662D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53DD5B21006
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 05:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D363B6FBF;
	Mon, 18 Dec 2023 05:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BKUd9jZd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FFB6FA3;
	Mon, 18 Dec 2023 05:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5438AC433C8;
	Mon, 18 Dec 2023 05:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1702878870;
	bh=epOGSnTxreQ/s5ZdzE92LmaoiqGP2R33lgR9pl8PglM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BKUd9jZdVV1i+8UHRdM6hvmutR90V3XyNx07x2hLl8whXAehi+RmHAt+kZjw4/LIr
	 n7J3VpikTHfwJa+8mHopsb4ScysQ39i7PjkZ9Zf4Ea0tx512dZhnbhiG8VgJL46wLi
	 5RA0Lr0W8BK7KYy4xHXB/ZRhdpOIEBK0lUgWaeFM=
Date: Sun, 17 Dec 2023 21:54:29 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Greg KH <greg@kroah.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the driver-core tree
Message-Id: <20231217215429.944b318dc38a3646e734a807@linux-foundation.org>
In-Reply-To: <20231218154034.56bf4c68@canb.auug.org.au>
References: <20231218154034.56bf4c68@canb.auug.org.au>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Dec 2023 15:40:34 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> The following commit is also in the mm tree as a different commit (but
> the same patch):
> 
>   2678fd2fe9ee ("initramfs: Expose retained initrd as sysfs file")
> 
> This is commit
> 
>   426081603f6c ("initramfs: expose retained initrd as sysfs file")
> 
> in the mm tree.

I'm suspecting that something went wrong here?

