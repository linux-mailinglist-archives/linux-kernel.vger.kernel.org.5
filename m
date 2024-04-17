Return-Path: <linux-kernel+bounces-148563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BD68A8475
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F7941C21B24
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44DC14199F;
	Wed, 17 Apr 2024 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hhHWeVHK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F80E13F453;
	Wed, 17 Apr 2024 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360306; cv=none; b=oP+0FFTH2MLmI7qJCswXN6X6AFHbdpImRbzoUbCJ6nogVmENFD5MHkjr9uOemErbmSt5+i4hrB0rL0oK+u3CbXP++gj6NYbChUU4/i6t+OL93EX2ZKzfziZeBvujiv63EJU1YCQjR8vjOUh3rhphjyi6HzTeDhpDGFlHwOVL9m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360306; c=relaxed/simple;
	bh=PclmaXUve3QTnkek1j1X1Acf8JqyK7VekXgdK/l0vDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+q2b/CSm1BTzM/KBmm7xXLQ1XaYYsn5UnRdNFyirj3+WA5J5vr+YL2NVUOoGSSPVyf5nO8OJj6p/1n32iPxPx+Z0ZDoTzPG/nlMtNP0DZyfmu+y5xXYwhbxP0nmCezG0o19etXPDTJ7JktoGfOaxu6zNN6mmMa0q9uhofiWLXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hhHWeVHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54D8C072AA;
	Wed, 17 Apr 2024 13:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713360305;
	bh=PclmaXUve3QTnkek1j1X1Acf8JqyK7VekXgdK/l0vDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hhHWeVHKnerSmvol0UI1D6Ah2x6TQw4ROQxMn4vczVj4U6K5+gNJctrC2kLOdafMu
	 D8I3+AVPaiavO4R+XQgtp6wCY8uKax/wkH107ceFaoxQrB2dR9fpJBO4dJXuiNp7TT
	 Z4nUZq7AYhjlE59SsLDTaLDaDeYlhiIghDz8X09M=
Date: Wed, 17 Apr 2024 09:25:04 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: helpdesk@kernel.org, Greg KH <gregkh@linuxfoundation.org>, 
	"workflows@vger.kernel.org" <workflows@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Please create the email alias do-not-apply-to-stable@kernel.org
 -> /dev/null
Message-ID: <20240417-orthodox-wildcat-of-prestige-e1ea2b@lemur>
References: <b452fd54-fdc6-47e4-8c26-6627f6b7eff3@leemhuis.info>
 <20240417-lively-zebu-of-tact-efc8f3@lemur>
 <e7318984-7ef4-48cd-aae4-1deda3d711a5@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7318984-7ef4-48cd-aae4-1deda3d711a5@leemhuis.info>

On Wed, Apr 17, 2024 at 03:21:12PM +0200, Thorsten Leemhuis wrote:
> > In general, I feel this information belongs in the patch basement 
> > (the place where change-id, base-commit, etc goes). E.g.:
> > 
> >     stable-autosel: ignore
> >     [This fix requires a feature that is only present in mainline]
> > 
> > This allows passing along structured information that can be parsed by 
> > automated tooling without putting it into the commit.
> 
> That afaics makes them useless for the stable team (Greg may correct me
> if I'm wrong here), as they deal with the commits and have no easy,
> fast, and reliable way to look up the patch posting to query this. Or is
> the "patch basement" available somehow in git for each commit and I just
> missed that?

Ah, okay, my assumption was wrong, then.

How about meeting things halfway, then:

    Cc: stable+noautosel@kernel.org # Reason

-K

