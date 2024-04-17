Return-Path: <linux-kernel+bounces-148635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD3B8A855E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D7FCB2133D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A50B140E29;
	Wed, 17 Apr 2024 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W02DEiN6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8894012DDB2;
	Wed, 17 Apr 2024 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713362156; cv=none; b=DKTgDvJeffUI+4u2QU7uIgwaF7jSIoLiRkKAUPW/NU6qGJKznLerVIyeTBaZZYdC4tjBNQ9Bz+KrKt4AmhpJITWA4E3/qwWculPk3vhfDI3Ox58yG3goXS870sqRsuDQmCpQEg1C7AmQwXafljHw+O6ZfMbb0NES5S2v5FzitVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713362156; c=relaxed/simple;
	bh=PHhywEDejzCtYrvo8CvOuGJJnvBEhXLfU2dwZK5oFx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBpPsl65ilwJaIFWaXwZpWWeDasivUKt5sVupmLio0F5+mdeJu5Ai0tRBqA1PaXzH1CEhj/t7NuOh/w40XnPMwfEp/mPv1zeURz+pKgyxOwIEbSzV3+oX05S1W4/rmlz+l0qdXx0F9hsayJStdBiZEKRG+qpK/MfNnXHJAW7qn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W02DEiN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2FAC072AA;
	Wed, 17 Apr 2024 13:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713362156;
	bh=PHhywEDejzCtYrvo8CvOuGJJnvBEhXLfU2dwZK5oFx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W02DEiN6yeGwb6a4u24jSIqT8gDfxeeGMHQw6OUmyNU0YYLnfYpbMiysAWSpGbS8L
	 H7lwohYZrfuj09Wvq8Zb53cu8XoB8wGhbpp1ughlwnp9ol/3M+dyB+IrXYj+tpCqen
	 S8nhUvk8YnvlANU6tsDedOw25wcB9u9GnGWQ01PA=
Date: Wed, 17 Apr 2024 09:55:52 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thorsten Leemhuis <linux@leemhuis.info>, helpdesk@kernel.org, 
	"workflows@vger.kernel.org" <workflows@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Please create the email alias do-not-apply-to-stable@kernel.org
 -> /dev/null
Message-ID: <20240417-spectral-doberman-of-prosperity-d2c0cc@lemur>
References: <b452fd54-fdc6-47e4-8c26-6627f6b7eff3@leemhuis.info>
 <20240417-lively-zebu-of-tact-efc8f3@lemur>
 <e7318984-7ef4-48cd-aae4-1deda3d711a5@leemhuis.info>
 <2024041734-gleeful-freewill-b24b@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024041734-gleeful-freewill-b24b@gregkh>

On Wed, Apr 17, 2024 at 03:38:28PM +0200, Greg KH wrote:
> > That afaics makes them useless for the stable team (Greg may correct 
> > me
> > if I'm wrong here), as they deal with the commits and have no easy,
> > fast, and reliable way to look up the patch posting to query this. Or is
> > the "patch basement" available somehow in git for each commit and I just
> > missed that?
> 
> You are correct, as-is, that would make it useless for my tools.
> 
> BUT I could, if it's possible, just look up the original in lore somehow
> and parse that.  If it's there, does anyone have a "simple" way to map a
> git commit back to a lore message if it does NOT have a Link: line in
> it?

Our current way of doing it is going by patch-id, and it's not great 
either, because there is more than one way to create a patch from a git 
commit. We've discovered this when Linus recommended that people send 
patches with the --histogram algorithm, which broke a bunch of our 
stuff. :)

E.g. here's a recent commit that has a Fixes:

  git show c0297e7dd50795d559f3534887a6de1756b35d0f | git patch-id --stable | cut -d' ' -f1
  c2f5c42a5a3bc05ffacd9679dd367e4a2207b018

it successfully maps to the patch:
https://lore.kernel.org/all/?q=patchid%3Ac2f5c42a5a3bc05ffacd9679dd367e4a2207b018

I only put this here for academic purposes -- I really don't want you to 
go that route, because it's fragile (more fragile than git notes, and 
that's saying something).

-K

