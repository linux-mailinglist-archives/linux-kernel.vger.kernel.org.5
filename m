Return-Path: <linux-kernel+bounces-10417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 574D281D42A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D891F22935
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 13:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B2ED305;
	Sat, 23 Dec 2023 13:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r6/+3644"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54473D2F2;
	Sat, 23 Dec 2023 13:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE0FC433C7;
	Sat, 23 Dec 2023 13:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703337445;
	bh=5K6x6BcegYWNhn5XSQQZ0ICskrams5vf6alZmXvQeZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r6/+36444ZE99jy55H9SXXP/nSdLH19nDzNYLdy0IYPgq8IAFqGV0GxnbfV60CDwT
	 9XchkzvzzS4pCrwC1khMltgCks24BY9yrjtGLGxQv3qF6pV5Ex3/aDucnBgFRX0mEC
	 iFTbHE0WU9e4il7u72IINIQeSSImr8gupri1rvt8=
Date: Sat, 23 Dec 2023 14:17:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gary Rookard <garyrookard@fastmail.org>
Cc: philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] staging: rtl8192e: rename variable pHT
Message-ID: <2023122316-alike-trimmer-b5db@gregkh>
References: <20231216125303.3404-1-garyrookard@fastmail.org>
 <2023122348-angular-shopper-0b92@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023122348-angular-shopper-0b92@gregkh>

On Sat, Dec 23, 2023 at 02:07:10PM +0100, Greg KH wrote:
> On Sat, Dec 16, 2023 at 07:52:59AM -0500, Gary Rookard wrote:
> > Hi,
> > 
> > This patch series renames (4) different variables with
> > checkpatch coding style issue Avoid CamelCase.
> > 
> > (resubmittals)
> 
> Does not apply to my tree :(
> 
> Please rebase against the correct branch?

Oh wait, this is an old one...

