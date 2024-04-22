Return-Path: <linux-kernel+bounces-153915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A608AD4CF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80361B214A7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F2815532C;
	Mon, 22 Apr 2024 19:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rkuyOK3h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E132154432;
	Mon, 22 Apr 2024 19:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713813919; cv=none; b=UtJRGPkNJP/tg7pa1w0wdXn2YODV8hKJuE1ER7K06LWbT0CjmWL0Borxq0IBLgY00Be7mwf99lYHirhAxrkXNb95oq4EMApU8usGihU37di/rJwc0ewQcKEBZZCoyT7xGjs6wY+o1g+nu2K/rTXEmmFJ4FYExh7thRzGF5BoDdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713813919; c=relaxed/simple;
	bh=ey7j9DGDlYGRjNAWEJ6csFe1SLIsaU+lfd4WeNgwijo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOXg+onMOYVE7ZVhXE1b8C7QMHd2QfIFXhRJ/KIuPxefNlvs+/hlyFHLjkobpbkhB1HpTZBDYZuMYbrtNsCZkRgNtNBmcYgvYHoc3uibgfPieHHQDNRpSp6tG34spwsNCMuH7cvgbxVtn5dXqcLyn3cMqsG6g0GXVhvcLQCyFic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rkuyOK3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CF3C113CC;
	Mon, 22 Apr 2024 19:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713813919;
	bh=ey7j9DGDlYGRjNAWEJ6csFe1SLIsaU+lfd4WeNgwijo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rkuyOK3hAkxwMyWp9pLup8L1yTuDkUACR3wikDSds4jSbrg/LUu8mhCGIqvkrGC4e
	 vM+EYMR9skenqZcwOOm534nff6zb7TlJ34e53/Ugcl0EQwIqjcHdXOMRpY3ir0UCWO
	 4Cn483MVgN4lB7GXCMV2OoENXCuTKaGAGwWGqYmQ=
Date: Mon, 22 Apr 2024 15:25:18 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	helpdesk@kernel.org, "workflows@vger.kernel.org" <workflows@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Please create the email alias do-not-apply-to-stable@kernel.org
 -> /dev/null
Message-ID: <20240422-stoic-sawfly-of-protection-db8bfe@lemur>
References: <b452fd54-fdc6-47e4-8c26-6627f6b7eff3@leemhuis.info>
 <20240417-lively-zebu-of-tact-efc8f3@lemur>
 <e7318984-7ef4-48cd-aae4-1deda3d711a5@leemhuis.info>
 <2024041734-gleeful-freewill-b24b@gregkh>
 <d4853f43-2538-4a92-9ac4-aff5c7b0893e@leemhuis.info>
 <2024041830-karaoke-aspirate-df00@gregkh>
 <655ce2a3-eb04-4ade-999e-23fc5dc5fb3a@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <655ce2a3-eb04-4ade-999e-23fc5dc5fb3a@leemhuis.info>

On Mon, Apr 22, 2024 at 05:49:29PM +0200, Thorsten Leemhuis wrote:
> @Greg, BTW: should this be stable+noautosel@kernel.org or have a 
> 'vger.'

No vger, just stable+whatever@kernel.org.

> in it, e.g. stable+noautosel@vger.kernel.org? I assume without 'vger.'
> is fine, just wanted to be sure, as
> Documentation/process/stable-kernel-rules.rst in all other cases
> specifies stable@vger.kernel.org, so people are likely to get confused.
> :-/ #sigh

These serve two different purposes:

stable@kernel.org (goes into devnull)
stable@vger.kernel.org (actual mailing list)

Confusion happens all the time, unfortunately.

Notably, even if someone uses stable+noautosel@vger.kernel.org, it won't 
do anything terrible (it won't bounce, it'll just quietly go into 
nowhere because that's not a valid expansion command).

-K

