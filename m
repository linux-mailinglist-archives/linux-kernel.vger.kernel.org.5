Return-Path: <linux-kernel+bounces-8435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8538381B718
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7E3E1C2452D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1711773480;
	Thu, 21 Dec 2023 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dR6v5EMD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6607F73195
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7637CC433C7;
	Thu, 21 Dec 2023 13:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703164547;
	bh=2/grUN/vuhhrPk25K2nbD/e1P1sBxAvv/GmwIEq9xAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dR6v5EMD9ndnfc4N+yx16I80f7C0wNf51FBxNu/u8va1Y4//nrC2cARlkOxz/MZVp
	 uztkhIe10Z+WQAkADnhB9G7k5Wwj2V1uO/ZliVMXs0E9kE+t/mdqDxGp0qMXzgNMXe
	 aO93wNsai88nkgEJSivpQG9bkVCsWHIS/ElEf6/Q=
Date: Thu, 21 Dec 2023 14:15:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gary Rookard <garyrookard@fastmail.org>
Cc: philipp.g.hortmann@gmail.com, linux-staging@list.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] staging: rtl8192e: rename variable
 HTInitializeBssDesc and (4) other
Message-ID: <2023122129-underpay-zit-7ec5@gregkh>
References: <20231221031004.14779-1-garyrookard@fastmail.org>
 <2023122137-account-vitality-9a72@gregkh>
 <875y0rog7j.fsf@fastmail.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875y0rog7j.fsf@fastmail.org>

On Thu, Dec 21, 2023 at 08:06:13AM -0500, Gary Rookard wrote:
> 
> Greg KH <gregkh@linuxfoundation.org> writes:
> 
> > On Wed, Dec 20, 2023 at 10:09:59PM -0500, Gary Rookard wrote:
> >> Hi,
> >> 
> >> This patch series renames (5) different variables with
> >> the checkpatch coding style issue, Avoid CamelCase.
> >> 
> >> Patch 1/5) rename variable HTInitializeBssDesc
> >> Patch 2/5) rename variable HTResetSelfAndSavePeerSetting
> >> Patch 3/5) rename variable HTCCheck
> >> Patch 4/5) rename variable HTSetConnectBwModeCallback
> >> Patch 5/5) rename variable ePeerHTSpecVer
> >> 
> >> Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
> >> 
> >> Gary Rookard (5):
> >>   staging: rtl8192e: rename variable HTInitializeBssDesc
> >>   staging: rtl8192e: rename variable HTResetSelfAndSavePeerSetting
> >>   staging: rtl8192e: rename variable HTCCheck
> >>   staging: rtl8192e: rename variable HTSetConnectBwModeCallback
> >>   staging: rtl8192e: rename variable ePeerHTSpecVer
> >> 
> >>  drivers/staging/rtl8192e/rtl819x_HT.h     |  2 +-
> >>  drivers/staging/rtl8192e/rtl819x_HTProc.c | 16 ++++++++--------
> >>  drivers/staging/rtl8192e/rtllib.h         |  6 +++---
> >>  drivers/staging/rtl8192e/rtllib_rx.c      |  6 +++---
> >>  drivers/staging/rtl8192e/rtllib_softmac.c |  6 +++---
> >>  5 files changed, 18 insertions(+), 18 deletions(-)
> >
> > I see 2 different patch series here sent to the list, both seeming to do
> > the same thing?
> >
> > confused,
> >
> > greg k-h
> 
> Sorry that was caused by an address typo
> so it got resent to linux-staging..
> new setup on different distro

Please send a v2 of this then.

thanks,

greg k-h

