Return-Path: <linux-kernel+bounces-25026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C9682C64B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 21:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD61F1F2218D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 20:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4491642A;
	Fri, 12 Jan 2024 20:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="POGwJLzL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AF416408;
	Fri, 12 Jan 2024 20:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3EDC433F1;
	Fri, 12 Jan 2024 20:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705090609;
	bh=VIhoLIqCtvk1tD1fY7sWAKm66VsDrr9HCMvWDwJLm8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=POGwJLzLmy2j6xtcouSj7Ubg11TZtpwmfQ1cYGTz25UotXcxvSvXi/Cv2Uru6Gn7P
	 yEPJVFHT2hEDlBm1rJBkEY/M7JySUPeyZOntHyVEKU2n3/cesU2kS0Drl9T3qnf5DK
	 vGntsKuDzhJcBbeRbLEoccQjzffvoJlD9x7l0cbA=
Date: Fri, 12 Jan 2024 21:16:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: A quick "Regression tracking: state of the union early 2024"
 from my side
Message-ID: <2024011243-aorta-defraud-7950@gregkh>
References: <7613e402-894a-4d38-8cef-7263630c1c57@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7613e402-894a-4d38-8cef-7263630c1c57@leemhuis.info>

On Wed, Jan 10, 2024 at 08:22:39AM +0100, Thorsten Leemhuis wrote:
> ## The long story short
> 
> I'm not really happy with my performance wrt to my regression tracking
> efforts during the last year. To counter that, I've already shifted my
> focus somewhat ~in October. With the new year I will shift it some more.
> Top-priority will be "make regzbot more useful for kernel subsystem
> maintainers" from now on. My tracking efforts of course will continue,
> but everything except regressions in the current and the previous
> mainline cycle might not see much attention from my side. This
> refocusing also means that I won't work much on resolving some
> ambiguities around "how regressions are supposed to be handled" which
> lead to tension quite a few times. But all that should be for the best
> in the long term.

While you might be "too close" to the details to feel like this past
year was not good with regards to "performance", I'd like to counter
that and say I have been immensely happy with the work you did last
year.  The tracking and pushing on people to get regressions addressed
and merged is thankless (as you well know), but vital to our project in
order to keep our users happy.

So don't beat yourself up at all, you're doing a great job.

thanks,

greg k-h

