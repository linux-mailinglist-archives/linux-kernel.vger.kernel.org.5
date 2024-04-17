Return-Path: <linux-kernel+bounces-148117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E408A7DEC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9DD32840DE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419887D3EF;
	Wed, 17 Apr 2024 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tzmmDcRN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7123329CEB;
	Wed, 17 Apr 2024 08:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713341790; cv=none; b=oGQiQlsheUV8y3fCTt9aAZjrcLeLHbFMmno82EuNCD20aXNrSYKcCiKfhvVzLU8s4iqER+08KFb+E0Wim8a4v7NIbf6/FDogy4M5vYHNeEdeXjrPzVKdA9Rxxk9Iyj0cxzMZs3KWvXVDBJeYhiEDK6+kCbXmd7G3hfZhS+czCKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713341790; c=relaxed/simple;
	bh=hsTZxusieQgew76uCYQ1GcdVOv20DDKahcOzZ4kHvyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7jT0WG0R6CPLhMm4pWvkVKK9RaIbJK69U3TXtkRMdmmsA1UDwJMz8e64//j6bJZC7NZHEGOKj/lp1eswh8kfwZoei0H06grXDf4nhpU5yThQcK/n59GDOZ9kVvrRa8kvQfFkq6ZDahtOJSrXPPJ6T3CyDF8eimNjMpJspYFGMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tzmmDcRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880B0C072AA;
	Wed, 17 Apr 2024 08:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713341790;
	bh=hsTZxusieQgew76uCYQ1GcdVOv20DDKahcOzZ4kHvyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tzmmDcRNS0mc0FyEC9G5Tu1AhLyt52wUt/pNSiICp7fwl7ei/XVd+VFbC3IuC1O8k
	 07QnYwQuTPmzurPu+9DVvxsgYTjcsW6GYn5OEMRdms38SmSh1wTrl76DeqKpd9KozJ
	 7AazHRdlyc6bE+XWgHW1C3kGjtz9sgcjmolIRZRY=
Date: Wed, 17 Apr 2024 10:16:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Thorsten Leemhuis <linux@leemhuis.info>, helpdesk@kernel.org,
	"workflows@vger.kernel.org" <workflows@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Please create the email alias do-not-apply-to-stable@kernel.org
 -> /dev/null
Message-ID: <2024041715-calorie-late-c4de@gregkh>
References: <b452fd54-fdc6-47e4-8c26-6627f6b7eff3@leemhuis.info>
 <20240417090918.77360289@sal.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417090918.77360289@sal.lan>

On Wed, Apr 17, 2024 at 09:09:26AM +0100, Mauro Carvalho Chehab wrote:
> Em Wed, 17 Apr 2024 09:48:18 +0200
> Thorsten Leemhuis <linux@leemhuis.info> escreveu:
> 
> > Hi kernel.org helpdesk!
> > 
> > Could you please create the email alias
> > do-not-apply-to-stable@kernel.org which redirects all mail to /dev/null,
> > just like stable@kernel.org does?
> > 
> > That's an idea GregKH brought up a few days ago here:
> > https://lore.kernel.org/all/2024041123-earthling-primarily-4656@gregkh/
> > 
> > To quote:
> > 
> > > How about:
> > > 	cc: <do-not-apply-to-stable@kernel.org> # Reason goes here, and must be present
> > > 
> > > and we can make that address be routed to /dev/null just like
> > > <stable@kernel.org> is?  
> > 
> > There was some discussion about using something shorter, but in the end
> > there was no strong opposition and the thread ended a a few days ago.
> 
> Heh, a shorter name would make it a lot easier to remember, specially
> since not wanting a patch to go to stable is an exception... I bet
> I'll never remember the right syntax, needing to look at the docs
> every time it would be used.
> 
> IMO, something like:
> 	no-stable
> or
> 	nostable
> 
> would do the trick and would be a lot easier to remember.
> 
> Btw, IMO, it won't hurt accepting more than one variant that
> could be allowed, e. g. using a regular expression like:
> 
> 	(do)?[-_]?(nt|not?).*stable

That's not going to work at the mailing list server, or with my scripts,
sorry.

> at the scripts used by stable developers - and maybe at the ML server - to
> catch different variations won't hurt, as it sounds likely that people will
> end messing up with a big name like "do-not-apply-to-stable", typing
> instead things like:
> 
> 	do_not_apply_to_stable
> 	dont-apply-to-stable
> 
> and other variants.

I want this very explicit that someone does not want this applied, and
that it has a reason to do so.  And if getting the email right to do so
is the issue with that, that's fine.  This is a very rare case that
almost no one should normally hit.

And again, if maintainers don't want their tree to have Fixes: and
AUTOBOT run on them, we can easily add that to our lists.  That's the
simpler and more explicit thing to do for those that do not want to have
anything backported they do not explicitly mark as such (some subsystems
do this already, like kvm and -mm and xfs, it's fine!).  This all is
here because of maintainers who do NOT want to do that.

thanks,

greg k-h

