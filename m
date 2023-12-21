Return-Path: <linux-kernel+bounces-8404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDA481B6AF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 709981C25921
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EA87765C;
	Thu, 21 Dec 2023 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WcDSlBON"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99C773194
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0338FC433C8;
	Thu, 21 Dec 2023 12:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703163180;
	bh=gKhKNa0sY4C4Cj3iqBnWG1NsdzfMGndZJwfkXGkd+NE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WcDSlBONft8xEvMF1g028+ao6/S4/QxET4WaZxu+2Mm+b8oVv706Ni6QQ68pJeEgC
	 I2xJkU9PfIXtKkIIdXj5oQLqrHqMfMWL2j+n+zns72rKL0vLVXmwfzkpk8GShrs+nf
	 e44CLJUMYw24QIDnhUCWC8OGVC4EnXidjYCxRk8Y=
Date: Thu, 21 Dec 2023 13:52:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gary Rookard <garyrookard@fastmail.org>
Cc: philipp.g.hortmann@gmail.com, linux-staging@list.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] staging: rtl8192e: rename variable
 HTInitializeBssDesc and (4) other
Message-ID: <2023122137-account-vitality-9a72@gregkh>
References: <20231221031004.14779-1-garyrookard@fastmail.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221031004.14779-1-garyrookard@fastmail.org>

On Wed, Dec 20, 2023 at 10:09:59PM -0500, Gary Rookard wrote:
> Hi,
> 
> This patch series renames (5) different variables with
> the checkpatch coding style issue, Avoid CamelCase.
> 
> Patch 1/5) rename variable HTInitializeBssDesc
> Patch 2/5) rename variable HTResetSelfAndSavePeerSetting
> Patch 3/5) rename variable HTCCheck
> Patch 4/5) rename variable HTSetConnectBwModeCallback
> Patch 5/5) rename variable ePeerHTSpecVer
> 
> Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
> 
> Gary Rookard (5):
>   staging: rtl8192e: rename variable HTInitializeBssDesc
>   staging: rtl8192e: rename variable HTResetSelfAndSavePeerSetting
>   staging: rtl8192e: rename variable HTCCheck
>   staging: rtl8192e: rename variable HTSetConnectBwModeCallback
>   staging: rtl8192e: rename variable ePeerHTSpecVer
> 
>  drivers/staging/rtl8192e/rtl819x_HT.h     |  2 +-
>  drivers/staging/rtl8192e/rtl819x_HTProc.c | 16 ++++++++--------
>  drivers/staging/rtl8192e/rtllib.h         |  6 +++---
>  drivers/staging/rtl8192e/rtllib_rx.c      |  6 +++---
>  drivers/staging/rtl8192e/rtllib_softmac.c |  6 +++---
>  5 files changed, 18 insertions(+), 18 deletions(-)

I see 2 different patch series here sent to the list, both seeming to do
the same thing?

confused,

greg k-h

