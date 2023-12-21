Return-Path: <linux-kernel+bounces-7964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA1F81AFD0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC811C22634
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5648156DD;
	Thu, 21 Dec 2023 07:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="amxEtbeg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E264F156C3;
	Thu, 21 Dec 2023 07:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1432CC433C8;
	Thu, 21 Dec 2023 07:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703145032;
	bh=aQBHmXPeR268UMYmaEjMR/skVztda2cW8384dO+cm64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=amxEtbegWiCcK0P5WfIqGNbjJiSIP0vV2vKHFcsluw1gfDJ7+4kWQbqm0gwN/HAwr
	 QM4EwggESgaYcQO7XxAFl9+uZwhFNi2iGPr9p6vMtbCAuCuTln2XDi9yMVkM0388QR
	 lQbZgd4WoAI8qaZ51TDqGJryp5rugOgb6aXIIQFY=
Date: Thu, 21 Dec 2023 08:50:29 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ryan England <rcengland@gmail.com>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
	Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: Re: [PATCH v2] staging: rtl8712: fix open parentheses alignment
Message-ID: <2023122151-denial-speed-1b4c@gregkh>
References: <ZYM3APIhUHxupDnq@kernel.ryanengland.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYM3APIhUHxupDnq@kernel.ryanengland.xyz>

On Wed, Dec 20, 2023 at 06:48:32PM +0000, Ryan England wrote:
> Made corrections given we have 100 lines. Thanks for the update.

Why is this in the changelog text now?  As per the documentation,
something like this should go below the --- line, as my bot says:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

thanks,

greg k-h

