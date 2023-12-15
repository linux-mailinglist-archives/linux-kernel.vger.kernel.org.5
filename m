Return-Path: <linux-kernel+bounces-1304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABF3814D21
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7391F24ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5936D3DB93;
	Fri, 15 Dec 2023 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SVaRgCY+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10A63FB06;
	Fri, 15 Dec 2023 16:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3C4C433C7;
	Fri, 15 Dec 2023 16:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702657976;
	bh=eoD1nYFrOuV9d2ZEcrHNhPCXoQa+AYf15EwPmZbEwG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SVaRgCY+mT7cvr2OfuNhqZWv+XN/g51kDKo85AFQB5LFQhKouuv+gyU7nk/c7XBTx
	 yaohEHu8Vuo/sPlrQ/0l/Qxsj0641X9zACbDI178BMNTjBZ0v8eY+REKzq/lz44a+H
	 Ar0nDWPnyQIXP9k1CRDaIrvehwr2MoJeUcg4k9vE=
Date: Fri, 15 Dec 2023 17:32:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: users@linux.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PSA: final vger mailing list migration: Thu, Dec 14, 11AM PST
 (1900 UTC)
Message-ID: <2023121504-postwar-skinny-4520@gregkh>
References: <20231212-unselfish-real-myna-67e444@lemur>
 <20231214-unbiased-modest-herring-12b6eb@meerkat>
 <20231214-snobbish-numbat-of-focus-46ab36@meerkat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214-snobbish-numbat-of-focus-46ab36@meerkat>

On Thu, Dec 14, 2023 at 06:05:36PM -0500, Konstantin Ryabitsev wrote:
> On Thu, Dec 14, 2023 at 05:08:44PM -0500, Konstantin Ryabitsev wrote:
> > > This Thursday, December 14, at 11AM Pacific (19:00 UTC), we will switch the MX
> > > record for vger to point to the new location (subspace.kernel.org), which will
> > > complete the mailing list migration from the legacy vger server to the new
> > > infrastructure.
> > 
> > This work is completed, but there will be a brief outage around 3PM PST (23:00
> > UTC) to bump the number of CPUs needed for all the increased spam scanning.
> 
> All work is complete. If anything isn't looking or working right, please
> report this to helpdesk@kernel.org.

Thank you so much for doing this work, I know it hasn't been easy
migrating one of the higest-volume mailing lists in the world with no
interruptions.  If nothing else, you all should get a few conference
talks about it, and free beer from all of us!

thanks,

greg k-h

